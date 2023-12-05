# cicero-koppers

This repository contains data and findings for a collaboration between [MuckRock](https://www.muckrock.com/) and [*the Cicero Independiente*](https://www.ciceroindependiente.com/) called [“The Air We Breathe.”](https://www.muckrock.com/news/archives/2023/nov/07/air-we-breathe-cicero-pollution/)

You can find our earlier work on Chicago's air quality in [chicago-air-quality-automated](https://github.com/MuckRock/chicago-air-quality-automated). More data and analysis driving the investigations of MuckRock's news team are cataloged in [news-team](https://github.com/MuckRock/news-team).


## Data

### Illinois Air Emissions Inventory
Through an open-records request to the Illinois Environmental Protection Agency, MuckRock and the Cicero Independiente received Illinois emissions inventory data from 2012 to 2021, for 141 pollutants released at more than 1,000 facilities in Cook County. 

We copied the [Illinois EPA pollutant codes](https://epa.illinois.gov/topics/air-quality/planning-reporting/annual-emission-reports/reference-tables/pollutants.html) and stored them in `data/manual/pollutant_code_crosswalk.csv` to use in analysis. The raw data from our request is in the file `data/raw/foia_reported_emissions_2012-2021.csv` and is used in `analysis/findings_notebook.qmd` to calculate the average annual pollution of Koppers compared to other polluters in Cook County from 2012 to 2021. 

### EPA's Toxics Release Inventory
After analyzing the amount and types of emissions from Koppers in Cicero, we compared the plant to others nationally using the federal [EPA’s Toxics Release Inventory](https://www.epa.gov/toxics-release-inventory-tri-program/tri-data-and-tools). We pulled 10 years’ worth of the [Basic Plus Data Files](https://www.epa.gov/toxics-release-inventory-tri-program/tri-basic-plus-data-files-calendar-years-1987-present), from 2012 to 2022.

The raw data files are in `data/raw/toxic_release_inventory`. In `etl/prep_tri_data.R`, we then concatenated the years together and filtered the data to focus on the column `115_total_air_emissions`, which is the total air emissions for the facility, for several hazardous or cancer-linked chemicals, including those also emitted at Koppers: benzene, naphthalene, phthalic anhydride, maleic anhydride, quinoline, styrene and creosote.

We chose the pollutants after speaking with three environmental health experts and reviewing each pollutant that Koppers emits to check its carcinogenic classification in the file `data/manual/koppers_pollutants_cancer_check.csv`.

The filter data was exported to `data/koppers_tri_pollutants.csv` and used in `analysis/findings_notebook.qmd` to assess how Koppers compares to other facilities across the country that report their emissions in the Toxics Release Inventory.  

### EPA's AirToxScreen 
We also used the federal EPA’s national air toxics risk assessment based on emissions inventories, now called [AirToxScreen](https://www.epa.gov/AirToxScreen/2019-airtoxscreen), to identify census tracts in Cicero that face an elevated risk of cancer from benzene and naphthalene. We downloaded the [2019 AirToxScreen National Cancer Risk by Pollutant (xlsx)](https://www.epa.gov/AirToxScreen/2019-airtoxscreen-assessment-results) file and stored it in `data/raw/2019_National_CancerRisk_by_tract_poll.xlsx` before loading it into `etl/prep_tract_analysis.R` to filter the data file and make it smaller, so it could be used in `analysis/findings_notebook.qmd` to compare the cancer risks from benzene and naphthalene in Cicero to census tracts across the country. 

You can find a data dictionary for TRI's Basic Plus Files in `data/dictionaries`.

## Mapping 
In `etl/geocode.R`, we geocoded facility addresses from the Illinois EPA Air Emissions Inventory using Google's Geocoding API, which we then exported to `data/processed/aer_lat_longs.csv` and then used in `analysis/map_eda` to generate maps of polluters by pollutant that formed the basis for our illustrated map of benzene and naphthalene polluters in the story. 

## Questions / Feedback
Contact Dillon Bergin at dillon@muckrock.com. 
