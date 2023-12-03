library(tidyverse)
library(janitor)
library(here)
library(readxl)


cancer_risk_tract <- read_excel(here("data", "raw", "2019_National_CancerRisk_by_tract_poll.xlsx")) %>% 
  clean_names() 

cols <- as.data.frame(colnames(cancer_risk_tract))
                         
# Data only covers benzene and naphthelene, not quinonline, styrene or creosote                          
naphthalene_benzene <- cancer_risk_tract %>% 
  select(state, epa_region, county, fips, tract, population, benzene, naphthalene) %>% 
  #filter(state == "IL") %>% 
  mutate(census_tract = str_sub(tract, -9, -1))


write.csv(naphthalene_benzene, "data/processed/airtoxscreen_aphthalene_benzene_risk.csv")




