# Course 2 - R Programming
# Week 2, Assignment 1

# Part 1

pollutantmean <- function (directory, pollutant, id = 1:332) {
    # Inputs:
    # directory: location of the CSV files
    # pollutant: name of the pollutant; either "sulfate" or "nitrite
    # id = monitor number. For example id = 200 is monitor 200.
    
    # Returns:
    # mean of pollutant, ignoring NA values
    
    data <- data.frame()
    for (i in id) {
        files <- read.csv(paste(directory, "/", sprintf('%03d', i), ".csv", sep = "") )
        data <- rbind(data, files)
    }
    return (mean(data[,pollutant], na.rm = T))
}

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)

