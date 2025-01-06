source("scripts/Utilities.R")

initialize_required_packages(c("dismo", "terra", "sf"))

generate_distribution_maps <- function(
    study_area, 
    species_data,
    bioclimatic_variables,
    future_bioclimatic_data,
    xlab = "Longitude",
    ylab = "Latitude",
    currentDistributionTitle = "Current distribution",
    futureDistributionTitle = "Predicted future distribution"
) {
  # Load historical climatic data from 1970 to 2000
  historical_bioclimatic_data <- rast(list.files("climate/historical", pattern = ".tif$", full.names = TRUE))
  
  # Align column names, so they would not differ when further running Maxent modelling
  names(future_bioclimatic_data) <- names(historical_bioclimatic_data)
  
  # Use only specified subset of bioclimatic variables
  historical_bioclimatic_data_subset <- subset(historical_bioclimatic_data, bioclimatic_variables)
  future_bioclimatic_data_subset <- subset(future_bioclimatic_data, bioclimatic_variables)
  
  # Crop and mask environmental layers to study area
  study_area_vect <- vect(study_area)
  bioclim_stack <- mask(crop(historical_bioclimatic_data_subset, study_area), study_area_vect)
  future_bioclim_stack <- mask(crop(future_bioclimatic_data_subset, study_area), study_area_vect)
  
  # Filter species data to study area
  species_sf <- st_as_sf(species_data, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)
  species_sf <- st_intersection(species_sf, study_area)
  
  # Remove species points with NA predictor values
  species_points <- as.data.frame(st_coordinates(species_sf))
  colnames(species_points) <- c("decimalLongitude", "decimalLatitude")
  predictor_values <- extract(bioclim_stack, species_points)
  species_points <- species_points[complete.cases(predictor_values), ]
  
  # Convert environmental layers to raster format for MaxEnt
  bioclim_stack_raster <- raster::stack(bioclim_stack)
  future_bioclim_stack_raster <- raster::stack(future_bioclim_stack)
  
  # Run MaxEnt model
  maxent_model <- maxent(x = bioclim_stack_raster, p = species_points)
  
  # Predict current habitat suitability
  predict_distribution <- predict(bioclim_stack_raster, maxent_model)
  plot(predict_distribution, main = currentDistributionTitle, xlab = xlab, ylab = ylab)
  
  # Add species data points to the current distribution map
  points(species_points$decimalLongitude, species_points$decimalLatitude, pch = 20, cex = 0.3, col = "red")
  
  # Predict future habitat suitability
  future_predict_distribution <- predict(future_bioclim_stack_raster, maxent_model)
  plot(future_predict_distribution, main = futureDistributionTitle, xlab = xlab, ylab = ylab)
}