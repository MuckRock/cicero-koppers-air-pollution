library(tidyverse)
library(janitor)
library(here)
library(readxl)



# LOAD DATA
cook_county_emissions <- read_excel(here("data", "raw", "foia_reported_emissions_2012-2021.xlsx")) 


facility_addresses <- cook_county_emissions %>% 
  clean_names() %>% 
  mutate(address_full = paste(address, city, state, sep = ", ")) %>% 
  mutate(address_full = paste(address_full, zipcode, sep = " ")) %>% 
  distinct(name, address_full)



# GEOCODING 

# Register API key for geocoding through Google
register_google(key = "AIzaSyBLV6jfsyvWjA7-bSSU9fJBGcdb2lGgUzE", write = TRUE)

facility_lat_longs <- facility_addresses %>% 
  mutate_geocode(address_full, output = "latlona")

#Geocoded all but five addresses, which I will look up and fix address to geocode again 
# Praxair = 900 E 26th Ave. La Grange Park, IL 60526 
# K-Five = 13769 Main Street, Lemont, IL 60439-9371 
# Waste management = 13707 S Jeffery Ave, Chicago, IL 60633 
# COFC0 = 11700 S Torrence Ave, Chicago, IL 60617

addr_fix <- facility_lat_longs %>% 
  filter(is.na(lon) | is.na(lat)) %>% 
  mutate(address_fix = case_when(name == "Praxair Inc" ~ "900 E 26th Ave. La Grange Park, IL 60526",
                                name == "K-Five Construction Co" ~ "13769 Main Street, Lemont, IL 60439-9371",
                                name == "Waste Management of Illinois Inc CID RDF" ~ "13707 S Jeffery Ave, Chicago, IL 60633",
                                name == "COFCO International Grains US LLC" ~ "11700 S Torrence Ave, Chicago, IL 60617",
                                TRUE ~ "fix_fail")) %>% 
  mutate_geocode(address_fix, output = "latlona") 


facility_lat_long_export <-  addr_fix %>% 
  select(name, address_full, lon...7, lat...8) %>% 
  rename(lon = lon...7, lat = lat...8) %>% 
  rbind(facility_lat_longs) %>% 
  filter(!is.na(lon))
  



write.csv(facility_lat_long_export, "data/processed/aer_lat_longs.csv")
