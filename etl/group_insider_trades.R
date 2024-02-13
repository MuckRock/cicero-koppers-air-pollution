library(tidyverse)
library(janitor)
library(here)
library(jsonlite)
library(lubridate)
library(zoo)


#Cleaning insider trades data
#As a publicly-traded company, Koppers is required to report all stock transactions by its senior executives and large shareholders to the U.S. Securities and Exchange Commission in filings called a "Form 4" 
#Editor Derek Kravitz exported all SEC Form 4 filings for Koppers from Jan. 1, 2006, through Dec. 31, 2023, to identify trends in different types of transactions by these so-called "insiders."
#He then sorted by the transaction code, "S," which is defined as the "open market or private sale of non-derivative or derivative security" and then grouped these sales volume by month to look for trends
#I'm going to take the monthly data Derek pulled and group to quarterly for a bit smoother of a visualization



trades <- read_csv(here("data","manual","insider_trades.csv")) %>% 
  mutate(year_month = my(paste0(month, "-", year))) %>% 
  mutate(quarter = as.yearqtr(year_month)) %>% 
  mutate(num_shares = as.numeric(num_shares)) %>% 
  group_by(quarter) %>% 
  summarize(sum_shares = sum(num_shares))

write.csv(trades, "data/manual/insider_trading.csv")

