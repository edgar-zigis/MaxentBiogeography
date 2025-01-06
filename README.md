# Species biogeography prediction using MaxEnt model
This is a sample R project for future species distribution visualisation using **MaxEnt** model.<br/>For demonstration purpose, project contains all required data for predicting habitat distribution of *Cicadetta montana*, *Sarcosoma globosum* species and bioclimatic data with GCM of `UKESM1-0-LL` and `EC-Earth3-Veg` both for `2041-2060 SSP245`.

![alt text](https://github.com/edgar-zigis/MaxentBiogeography/blob/master/preview.jpg?raw=true)

### Usage instructions
1. Download species occurrences data from [GBIF](https://www.gbif.org). When picking a location, use rectangle or polygon tool as you will need to get specific coordinates for the boundaries of the location area. When picking download options, choose **Simple** which should generate a CSV file. Update `main.R` file with the path of your species data.
2. In the `main.R` file set location of your species data and update study area coordinates with the ones from your study area (`species_data <- read.csv("distribution/Cicadetta montana.csv", sep = "\t", header = TRUE)`).
```R
study_area <- st_sfc(
  st_polygon(list(matrix(c(
    -11.91717, 34.35806,
    46.05072, 34.35806,
    46.05072, 71.73288,
    -11.91717, 71.73288,
    -11.91717, 34.35806
  ), ncol = 2, byrow = TRUE))),
  crs = 4326
)
```
3. Download desired future climate data from [WorldClim](https://www.worldclim.org/data/cmip6/cmip6climate.html). Choose GCM according to your needs as some of them suit some regions better than others. At the moment this project supports 5 minute resolution. In case you wish to use another resolution, you will need to update `map_generator.R` script as by default it points to 5 minutes. In the `main.R` file update the path to the future bioclimatic data you are willing to use (`future_bioclim_stack <- rast("climate/wc2.1_5m_bioc_EC-Earth3-Veg_ssp245_2041-2060.tif")`).
4. Define preferred bioclimatic variables according to your investigated species ecology in the `main.R` file.
```R
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
5. Adjust function parameter sin the `main.R` file. to get the best visual representation and run the script.
```R
generate_distribution_maps <- function(
    study_area, 
    species_data,
    bioclimatic_variables,
    future_bioclimatic_data,
    xlab = "Longitude",
    ylab = "Latitude",
    currentDistributionTitle = "Current distribution",
    futureDistributionTitle = "Predicted future distribution"
)
```
