# Week2 :  Lesson 2: ggplot2
library(ggplot2)
str(mpg)
qplot(displ, hwy, data = mpg)

# modifying aesthetics
qplot(displ, hwy, data = mpg, color = drv)

# adding a geom
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

# histograms
qplot(hwy, data = mpg, fill = drv)

# facets
qplot(displ, hwy, data = mpg, facets =.~drv) # separate columns
qplot(hwy, data = mpg, facets = drv~.,binwidth = 2) # separate rows

# axis limits
par(mfrow= c(1,1))
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50, 2] <- 100 # introducing an outlier
plot(testdat$x, testdat$y, type = "l", ylim = c(-3, 3))

g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()

# how to specify axis limits
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line() + ylim(-3,3) # changing y limit will subset the data. 
                            # only values between -3 and 3 will be included

g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line() + coord_cartesian(ylim=c(-3,3))

#### from Quiz ####
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

library(datasets)
data(airquality)
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
