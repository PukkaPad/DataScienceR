# Lesson 2: Plotting

# par()

# 1. Base Plot
library(datasets)
data(cars)
with(cars, plot(speed, dist))

# 1.1 Simple Base Graphics: Histogram
hist(airquality$Ozone)

# 1.2 Simple Base Graphics: Scatterplot
with(airquality, plot(Wind, Ozone))

# 1.3 Simple Base Graphics: Boxplot
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

# 1.4 Checking default global graphics parameters
par("lty")
par("col")
par("pch")
par("bg")
par("mar")
par("mfrow")

# 1.5 Base Plot with Annotation
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")

# or
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

# or
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points (Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

# 1.6 Base Plot with Regression Line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

# 1.7 Multiple Base Plots
par(mfrow = c(1, 2))
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation") 
    })

# another example
par(mfrow = c(1, 3), mar =  c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    plot(Temp, Ozone, main = "Ozone and Temperature")
    mtext("Ozone and Weather in New York City", outer = TRUE)
})

# 2. The Lattice System
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

# 3. ggplot2 System
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

