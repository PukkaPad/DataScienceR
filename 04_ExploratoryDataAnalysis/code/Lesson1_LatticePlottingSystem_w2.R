# Week2 :  Lesson 1: Lattice Plotting System

library(lattice)
library(datasets)

# Simple scatterplot
xyplot(Ozone~Wind, data = airquality)

# Convert Month to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone~Wind | Month, data = airquality, layout = c(5, 1)) # by month

# Lattice behavior
p <- xyplot(Ozone~Wind, data = airquality)
print(p) 

## Panel Functions
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels, c ("Group 1", "Group 2"))
xyplot(y~x | f, layout = c(2,1)) # plot with 2 panels

# Custom panel function
xyplot(y~x | f, panel = function(x, y, ...){
    panel.xyplot(x, y, ...) # 1st call the default panel function for xyplot
    panel.abline(h = median(y), lty = 2) # add a horizontal line at the median
})

# Custom panel function
xyplot(y~x | f, panel = function(x, y, ...){
    panel.xyplot(x, y, ...) # 1st call the default panel function for xyplot
    panel.lmline(x, y, col = 2) # overlay a simple linear regression line
})







