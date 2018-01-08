# Lesson 1: Graphs: Exploratory Graphs

# The U.S. Environmental Protection Agency (EPA) sets national ambient air 
# quality standards for outdoor air pollution

# For fine particle pollution (PM2.5), the "annual mean, averaged over 3 years" 
# cannot exceed 12 μg/m^3

pollution <- read.csv ("../data/avgpm25.csv", 
                       colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
head(pollution)
# 5th row exceeds 12microgram/m^3
tail(pollution)

# 1. Summary of data:
summary(pollution$pm25)
# max is 18.4 microgram/m^3

boxplot(pollution$pm25, col = "blue")
# some counties are above 12microgram/m^3

hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)

boxplot(pollution$pm25, col = "blue")
abline(h = 12) # shows that the bulk are bellow the 12microgram/m^3 line

hist(pollution$pm25, col = "green", breaks = 100)
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each REgion")

# multiple boxplots
boxplot(pm25 ~ region, data = pollution, col = "red")

# multiple histograms
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east") $pm25, col = "green")
hist(subset(pollution, region == "west") $pm25, col = "green")

# scatterplot
par(mfrow=c(1,1))
with(pollution, plot(latitude, pm25)) # N/S trend? latitude increase means going N
abline(h = 12, lwd = 2, lty = 2)
# pm25 is higher in middle latitudes

# scatterplot with colour
par(mfrow=c(1,1))
with(pollution, plot(latitude, pm25, col = region)) # N/S trend? latitude increase means going N
abline(h = 12, lwd = 2, lty = 2)

# muktiple scatterplots
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))
