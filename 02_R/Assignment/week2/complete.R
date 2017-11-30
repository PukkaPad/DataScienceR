# Course 2 - R Programming
# Week 2, Assignment 1

# Part 2

complete <- function(directory, id = 1:332) {
    # Inputs:
    # directory: location of the CSV files
    # id = monitor number. For example id = 200 is monitor 200.
    
    # Returns:
    # data frame with id and number of observations
    
    data <- data.frame()
    for (i in id) {
        files<- read.csv(paste(directory, "/", sprintf('%03d', i), ".csv", sep = ""))
        nobs <- sum(complete.cases(files))
        dataObs <- data.frame(i, nobs)
        data <- rbind(data,dataObs)
        
    }
    
    colnames(data) <- c("id", "nobs")
    return(data)
    
}

complete("specdata", 1)
complete("specdata", 3)
complete("specdata", 30:25)