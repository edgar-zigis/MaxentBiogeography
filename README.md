# MaxentBiogeography
This is a sample R project for future species distribution visualisation using MaxEnt model.
In order to use it, please download any species distribution data from GBIF in CSV format and future climatic data from WorldClim with a 5 minute resolution.

1. Define preferred bioclimatic variables according to your investigated species ecology:
```
bioclim_vars <- c(
    BioClimaticVariable$ANNUAL_MEAN_TEMPERATURE,
    BioClimaticVariable$TEMPERATURE_SEASONALITY,
    BioClimaticVariable$MIN_TEMPERATURE_OF_COLDEST_MONTH,
    BioClimaticVariable$MEAN_TEMPERATURE_OF_WETTEST_QUARTER,
    BioClimaticVariable$MEAN_TEMPERATURE_OF_WARMEST_QUARTER,
    BioClimaticVariable$MEAN_TEMPERATURE_OF_COLDEST_QUARTER,
    BioClimaticVariable$ANNUAL_PRECIPITATION,
    BioClimaticVariable$PRECIPITATION_SEASONALITY,
    BioClimaticVariable$PRECIPITATION_OF_WETTEST_QUARTER,
    BioClimaticVariable$PRECIPITATION_OF_DRIEST_QUARTER
  )
```
2. Download future bioclimatic prediction data and place them in the climate directory. Prediction data resolution should be 5 minutes.
**Example:**
`future_bioclim_stack <- rast("climate/wc2.1_5m_bioc_EC-Earth3-Veg_ssp245_2041-2060.tif")`
3. Run the main.R file for desired results
