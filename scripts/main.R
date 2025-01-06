source("scripts/bioclimatic_variable.R")
source("scripts/map_generator.R")

# Define study area polygon where vectors are geographical coordinates
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

draw_cicadetta_montana_distribution <- function(study_area) {
  # Load species occurrence data and environmental layers
  species_data <- read.csv("distribution/Cicadetta montana.csv", sep = "\t", header = TRUE)
  
  # Bioclimatic variables used in the analysis according to Laphria gibbosa ecology
  bioclim_vars <- c(
    BioClimaticVariable$ANNUAL_MEAN_TEMPERATURE,
    BioClimaticVariable$TEMPERATURE_SEASONALITY,
    BioClimaticVariable$MAX_TEMPERATURE_OF_WARMEST_MONTH,
    BioClimaticVariable$MEAN_TEMPERATURE_OF_WETTEST_QUARTER,
    BioClimaticVariable$MEAN_TEMPERATURE_OF_COLDEST_QUARTER,
    BioClimaticVariable$MEAN_TEMPERATURE_OF_WARMEST_QUARTER,
    BioClimaticVariable$MIN_TEMPERATURE_OF_COLDEST_MONTH,
    BioClimaticVariable$TEMPERATURE_ANNUAL_RANGE,
    BioClimaticVariable$ANNUAL_PRECIPITATION,
    BioClimaticVariable$PRECIPITATION_SEASONALITY,
    BioClimaticVariable$PRECIPITATION_OF_WARMEST_QUARTER
  )
  
  # Load predicted climatic data for 2040-2060. EC-Earth3-Veg good for Europe.
  future_bioclim_stack <- rast("climate/wc2.1_5m_bioc_EC-Earth3-Veg_ssp245_2041-2060.tif")
  
  generate_distribution_maps(
    study_area,
    species_data,
    bioclim_vars,
    future_bioclim_stack,
    currentDistributionTitle = "Current distribution of Cicadetta montana",
    futureDistributionTitle = "Predicted distribution of Cicadetta montana 2040-2060, SSP245"
  )
}

draw_sarcosoma_globossum_distribution <- function(study_area) {
  # Load species occurrence data and environmental layers
  species_data <- read.csv("distribution/Sarcosoma globossum.csv", sep = "\t", header = TRUE)
  
  # Bioclimatic variables used in the analysis according to Sarcosoma globossum ecology
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
  
  # Load predicted climatic data for 2040-2060. UKESM1-0-LL good for Europe and focuses on precipitation+temperature
  future_bioclim_stack <- rast("climate/wc2.1_5m_bioc_UKESM1-0-LL_ssp245_2041-2060.tif")
  
  generate_distribution_maps(
    study_area,
    species_data,
    bioclim_vars,
    future_bioclim_stack,
    currentDistributionTitle = "Current distribution of Sarcosoma globossum",
    futureDistributionTitle = "Predicted distribution of Sarcosoma globossum 2040-2060, SSP245"
  )
}

# Call drawing maps

draw_cicadetta_montana_distribution(study_area)
draw_sarcosoma_globossum_distribution(study_area)
