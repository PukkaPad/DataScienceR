# Practice Programming Assignment: swirl Lesson 1: Lattice Plotting System
# Week 2
library(lattice)
library(ggplot2)

# Here's an example of typical lattice plot call, xyplot(y ~ x | f * g, data). 
# The f and g represent the optional conditioning variables.
# The * represents interaction between them

library(datasets)
str(airquality)
head(airquality)

# try running xyplot with the formula Ozone~Wind as the first argument and the 
# second argument data set equal to airquality.
xyplot(Ozone~Wind, data = airquality)
xyplot(Ozone ~ Wind, data = airquality, pch=8, col="red", main="Big Apple Data")

# Run xyplot with the formula Ozone~Wind | as.factor(Month) as the first argument 
# and the second argument data set equal to airquality
xyplot(Ozone~Wind | as.factor(Month), data = airquality, layout = c(5,1))
xyplot(Ozone~Wind |Month, data = airquality) # not as informative!

# The print methods for lattice functions actually do the work of plotting 
# the data on the graphics device.
# create a variable p which is assigned the output of this simple call to xyplot
p <- xyplot(Ozone~Wind, data=airquality)
print(p)
names(p)
p[["formula"]]

# dimanond data
data(diamonds)
str(diamonds)

# So the data frame contains 10 pieces of information for each of 53940 diamonds. 
# Run the R command table with diamonds$color as an  argument.
table(diamonds$color)
table(diamonds$color, diamonds$cut)
# We see a 7 by 5 array with counts indicating how many diamonds in the data 
# frame have a particular color and cut.

# To save you some trouble we've defined three character strings for you, 
# labels for the x- and y-axes and a main title. They're in the file week2_myLabels.R
file.edit("week2_myLabels.R")
source("week2_myLabels.R")
xyplot(price~carat|color*cut,data=diamonds,strip=FALSE,pch=20,
       xlab=myxlab,ylab=myylab,main=mymain)

xyplot(price~carat|color*cut,data=diamonds,pch=20,
       xlab=myxlab,ylab=myylab,main=mymain) # without the strip argument
















