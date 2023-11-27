library(tidyverse)
library(janitor)
library(here)
library(readxl)

# Load all Toxic Release Investory Basic Plus Files, for what's called "Type 1A (Releases and Other Waste Mgmt)" for the same years we have IEPA Emissions Inventory data
# Plus the year 2022, which we have TRI for but not Illinois Emissions Invetory for 
yr_2012 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2012.txt"), locale=locale(encoding="latin1"))
yr_2013 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2013.txt"), locale=locale(encoding="latin1"))
yr_2014 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2014.txt"), locale=locale(encoding="latin1"))
yr_2015 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2015.txt"), locale=locale(encoding="latin1"))
yr_2016 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2016.txt"), locale=locale(encoding="latin1"))
yr_2017 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2017.txt"), locale=locale(encoding="latin1"))
yr_2018 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2018.txt"), locale=locale(encoding="latin1"))
yr_2019 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2019.txt"), locale=locale(encoding="latin1"))
yr_2020 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2020.txt"), locale=locale(encoding="latin1"))
yr_2021 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2021.txt"), locale=locale(encoding="latin1"))
yr_2022 <- read_tsv(here("data", "raw", "toxic_release_inventory", "US_1a_2022.txt"), locale=locale(encoding="latin1"))

# Combine all years into a single data frame and pull the columns we want 
all_years <- rbind(yr_2012, yr_2013, yr_2014, yr_2015, yr_2016, yr_2017, yr_2018, yr_2019, yr_2020, yr_2021) %>% 
  clean_names() %>% 
  select(x1_form_type, x2_reporting_year, x10_facility_name, x11_facility_street, x12_facility_city, x13_facility_county, x14_facility_state, 
         x74_frs_facility_id, x76_cas_number, x78_chemical_name, x115_total_air_emissions)

# Make a dataframe of just column names to easily look through to be sure we have the columns we want 
col_names <- as.data.frame(colnames(all_years))

# Seperate just benzene and napthalene out 
# Get rid of any rows where total air emissions is NA, because those are emissions of a different sort. We're just interested in air 
benzene_and_napthalene <- all_years %>% 
  filter(x76_cas_number %in% c("71-43-2", "91-20-3")) %>% 
  filter(!is.na(x115_total_air_emissions)) 

# Export for use in analysis 
write.csv(benzene_and_napthalene, "data/processed/tri_benzene_and_napthalene.csv")





