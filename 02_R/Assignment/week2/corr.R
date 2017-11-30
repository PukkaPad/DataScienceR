# Course 2 - R Programming
# Week 2, Assignment 1

# Part 3

corr <- function (directory, threshold = 0) {
    
    corrVector = NULL
    data <- data.frame()
    for (i in 1:332) {
        files<- read.csv(paste(directory, "/", sprintf('%03d', i), ".csv", sep = ""))
        nobs <- files[complete.cases(files), ]
        data <- rbind(data,nobs)
        
        if (nrow(nobs) < threshold) {
            next
        }
        else {corrVector = c (corrVector, cor(nobs[,2], nobs[,3]))}
    }
    corrVector
    #return (data)
}


cr <- corr("specdata", 150)
head(cr); summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)

cr <- corr("specdata", 5000)
summary(cr)
length(cr)

cr <- corr("specdata")
summary(cr)
length(cr)
