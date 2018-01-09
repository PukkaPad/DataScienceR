# Practice Programming Assignment: swirl Lesson 2: Exploratory Graphs
library(ggplot2)
library(jpeg)


# we've copied some data for you from the U.S. Environmental Protection Agency (EPA) 
# which sets national ambient air quality standards for outdoor air pollution. 
# These Standards say that for fine particle pollution (PM2.5), the "annual
# mean, averaged over 3 years" cannot exceed 12 micro grams per cubic meter. We 
# stored the data from the U.S. EPA web site in the data frame pollution. 
# Use the R function head to see the first few entries of pollution.
pollution <- read.csv("../data/avgpm25.csv")
head(pollution)

# We see right away that there's at least one county exceeding the EPA's standard 
# of 12 micrograms per cubic meter.
# We see 5 columns of data. The pollution count is in the first column labeled pm25
# The other 4 columns are a fips code indicating the state (first 2 digits) and 
# county (last 3 digits) with that count, the associated region (east or west), 
# and the longitude and latitude of the area. 

# Now run the R command dim with pollution as an argument to see how long the table is.
dim(pollution)
# there are 576 entries in pollution

# "Are there any counties in the U.S. that exceed that national standard 
# (12 micro grams per cubic meter) for fine particle pollution?

summary(pollution$pm25)
# this shows mim( 0 percentile), max(100 percentile) values and 3 quartiles of data.
# quartiles indicate the pollution measures at which 25%, 50%, and 75% of the 
# counties fall below. 
# In addition to these 5 numbers we see the Mean or average measure of 
# particulate pollution across the 576 counties.

ppm <- pollution$pm25

quantile(ppm)

boxplot(ppm, col = "blue")
# The "whiskers" of the box (the vertical lines extending above and below the box) 
# relate to the range parameter of boxplot, which we let default to the value 1.5 
# used by R. The height of the box is the interquartile range, the difference 
# between the 75th and 25th quantiles. In this case that difference is 2.8. 
# The whiskers are drawn to be a length of range*2.8 or 1.5*2.8. This shows us roughly
# how many, if any, data points are outliers, that is, beyond this range of values.

abline(h = 12)

hist(ppm, col = "green")
# The histogram gives us a little more detailed information about our data, 
# specifically the distribution of the pollution counts, or how many counties 
# fall into each bucket of measurements.
rug(ppm)
# This one-dimensional plot, with its grayscale representation, gives you a 
# little more detailed information about how many data points are in each bucket 
# and where they lie within the bucket. It shows (through density of tick marks) 
# that the greatest concentration of counties has between 9 and 12 micrograms 
# per cubic meter just as the histogram did.

hist(ppm, col = "green", breaks = 100)
rug(ppm)

hist(ppm, col = "green")
abline(v = median(ppm), col = "magenta", lwd = 4)


names(pollution)

# Let's look at the region column to see what's there
reg <- table(pollution$region)
reg
# more E than W counties


# use the R formula y ~ x to show that y (in this case pm25) depends on x (region). 
# Since both come from the same data frame (pollution) we can specify a data 
# argument set equal to pollution. By doing this, we don't have to type 
# pollution$pm25 (or ppm) and pollution$region. We can just specify the formula 
# pm25~region. Call boxplot now with this formula as its argument, data equal to
# pollution, and col equal to "red".
boxplot(pm25 ~ region, data = pollution, col = "red")

par(mfrow=c(2,1),mar=c(4,4,2,1))

# We'll use subset to pull off the data we want to plot. Call subset now with 
# pollution as its first argument and a boolean expression testing region for 
# equality with the string "east". Put the result in the variable east.
east <- subset(pollution, region == "east")
hist (east$pm25, col = "green")
hist(subset(pollution,region=="west")$pm25, col = "green")

# We'll call plot from inside the R command with which evaluates 
# "an R expression in an environment constructed from data". We'll use pollution 
# as the first argument to with and the call to plot as the second. 
# This allows us to avoid typing "pollution$" before the arguments to plot, 
# so it saves us some typing and adds to your base of R knowledge. 
par(mfrow=c(1,1))
with(pollution, plot(latitude, pm25)) 
abline(h = 12, lwd = 2, lty = 2)

plot(pollution$latitude, ppm, col = pollution$region) 
abline(h = 12, lwd = 2, lty = 2)

# We see many counties are above the healthy standard set by the EPA, but it's 
# hard to tell overall, which region, east or west, is worse. let's plot the
# scatterplots side by side (one row and two columns). We also need to use different margins.
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
# For the first scatterplot, on the left, we'll plot the latitudes and pm25 counts 
# from the west. We already pulled out the information for the counties in the 
# east. Let's now get the information for the counties from the west. Create the 
# variable west by using the subset command with pollution as the first argument 
# and the appropriate boolean as the second.
west <- subset(pollution,region=="west")
plot(west$latitude, west$pm25, main = "West")
# For the second scatterplot, on the right, we'll plot the latitudes and pm25 
# counts from the east.
plot(east$latitude, east$pm25, main = "East")
# It looks like there are more dirty counties in the east but the extreme
# dirt (greater than 15) is in the west.







