# cicero-koppers

This repository contains data and findings for a collaboration between [MuckRock](https://www.muckrock.com/) and [*the Cicero Independiente*](https://www.ciceroindependiente.com/) called [“The Air We Breathe.”](https://www.muckrock.com/news/archives/2023/nov/07/air-we-breathe-cicero-pollution/)

You can find our earlier work on Chicago's air quality in [chicago-air-quality-automated](https://github.com/MuckRock/chicago-air-quality-automated). More data and analysis driving the investigations of MuckRock's news team are cataloged in [news-team](https://github.com/MuckRock/news-team).


## Data

### Illinois Air Emissions Inventory
Through an open-records request to the Illinois Environmental Protection Agency, MuckRock and the Cicero Independiente received Illinois state inventory data from 2012 to 2021, for 141 pollutants released at more than 1,000 facilities in Cook County. 

This data is in the file `data/raw/foia_reported_emissions_2012-2021`and is used in `analysis/findings_notebook` to calculate the average annual pollution of Koppers compared to other polluters in Cook County. 

### EPA's Toxics Release Inventory
After analyzing the amount and types of emissions from Koppers in Cicero, we compared the plant to others nationally using the federal EPA’s Toxics Release Inventory. We pulled 10 years’ worth of data, from 2012 to 2022, for facilities that emit several hazardous or cancer-linked chemicals, including those also emitted at Koppers: benzene, naphthalene, phthalic anhydride, maleic anhydride, quinoline, styrene and creosote.

### EPA's AirToxScreen 
We also used the federal EPA’s national air toxics risk assessment based on emissions inventories, now called AirToxScreen, to identify census tracts in Cicero that face an elevated risk of cancer from benzene and naphthalene. 

## Data Transformation and Analysis 
