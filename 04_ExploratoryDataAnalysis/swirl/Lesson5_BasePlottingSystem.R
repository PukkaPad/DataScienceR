# Practice Programming Assignment: swirl Lesson 5: Base Plotting System
data("airquality")
head(airquality)
range(airquality$Ozone, na.rm = TRUE)

# So the measurements range from 1 to 168. First we'll do a simple histogram of 
# this ozone column to show the distribution of measurements. 
hist(airquality$Ozone)

table(airquality$Month)
# We'll want a boxplot of ozone as a function of the month in which the
# measurements were taken
boxplot(Ozone ~ Month, airquality)
# or
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)", col.axis = "blue", col.lab = "red")
title(main="Ozone and Wind in New York City")

# Now we'll show you how to plot a simple two-dimensional scatterplot using the 
# R function plot. We'll show the relationship between Wind (x-axis) and Ozone (y-axis)
with(airquality, plot(Wind, Ozone))
title(main="Ozone and Wind in New York City")

plot(airquality$Wind, airquality$Ozone, type = "n")
title(main="Wind and Ozone in NYC")

# Now create a variable called may by subsetting airquality appropriately
may <- subset(airquality, Month == 5)

# Now use the R command points to plot May's wind and ozone (in that order) as 
# solid blue triangles. You have to set the color and plot character with two 
# separate arguments. Note we use points because we're adding to an existing plot.
points(may$Wind,may$Ozone,col="blue",pch=17) 


notmay <- subset(airquality, Month != 5)

# Now use the R command points to plot these notmay's wind and ozone 
# (in that order) as red snowflakes.
points(notmay$Wind,notmay$Ozone,col="red",pch=8) 

legend("topright", pch = c(17, 8), col = c("blue", "red"), legend = c("May", "Other Months"))

# Now add a vertical line at the median of airquality$Wind. Make it dashed (lty=2) with a width of 2.
abline(v=median(airquality$Wind), lty = 2, lwd = 2)

par(mfrow = c(1,2))
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Ozone, airquality$Solar.R, main = "Ozone and Solar Radiation")

# This one with 3 plots, to illustrate inner and outer margins. First, set up 
# the plot window by typing par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), 
# oma = c(0, 0, 2, 0))
par(mfrow = c(1, 3), mar =c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone, main = "Ozone and Solar Radiation")
plot(airquality$Temp, airquality$Ozone, main = "Ozone and Temperature")
# Now we'll put in a title.
mtext("Ozone and Weather in New York City", outer = TRUE)


