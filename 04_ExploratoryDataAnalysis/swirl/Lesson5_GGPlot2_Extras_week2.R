# Practice Programming Assignment: swirl Lesson 5: GGPlot2 Extras
library(ggplot2)
data(diamonds)

str(diamonds)

# plot a histogram of the price of the 53940 diamonds in this dataset
qplot(price, data = diamonds)
range(diamonds$price)
# the range (difference between these two numbers) is $18497
qplot(price, data = diamonds, binwidth = 18497/30)

qplot(price, data = diamonds, binwidth = 18497/30, fill= cut)

# replot the histogram as a density function which will show the proportion 
# of diamonds in each bin
qplot(price, data = diamonds, geom="density")
# The highest peak is close to 0 on the x-axis meaning that most of the diamonds 
# in the dataset were inexpensive. In general, as prices increase (move right 
# along the x-axis) the number of diamonds (at those prices) decrease. The 
# exception to this is when the price is around $4000; there's a slight increase in
# frequency. Let's see if cut is responsible for this increase.
qplot(price, data = diamonds, geom="density", color=cut)
# Four of the five cuts have 2 peaks, one at price $1000 and the other between 
# $4000 and $5000. The exception is the Fair cut which has a single peak at $2500

qplot(carat, price, data = diamonds)
# We see the positive trend here, as the number of carats increases the price 
# also goes up
qplot(carat, price, data = diamonds, shape = cut)
qplot(carat, price, data = diamonds, color = cut)
qplot(carat, price, data = diamonds, color = cut) + geom_smooth(method = "lm")
# 5 regression lines, one for each cut of diamonds
# around each line is a shadow showing the 95% confidence interval
# unsurprisingly, that the better the cut, the steeper (more positive) 
# the slope of the lines.
qplot(carat, price, data = diamonds, color = cut, facets=.~cut) + 
    geom_smooth(method = "lm")


# create a graphical object g by assigning to it the output of a call to the 
# function ggplot with 2 arguments. The first is the dataset diamonds and the 
# second is a call to the function aes with 2 arguments, depth and price
g <- ggplot(diamonds, aes(depth, price))
summary(g)
# g holds the entire dataset
g + geom_point(alpha = 1/3)

# Suppose we want to see if this relationship (between depth and price) is affected by cut 
# or carat. We know cut is a factor with 5 levels (Fair, Good, Very Good, Premium, 
# and Ideal). But carat is numeric and not a discrete factor
# divide the data into 3 pockets, so 1/3 of the data falls into each
# create the variable cutpoints and assign to it the output of a call to the 
# function quantile with 3 arguments.
# The first is the data to cut,namely diamonds$carat; the second is a call to the 
# R function seq. This is also called with 3 arguments, (0, 1, and length set equal
# to 4). The third argument to the call to quantile is the boolean na.rm set 
# equal to TRUE.
cutpoints <- quantile(diamonds$carat, seq(0, 1, length = 4), na.rm = TRUE)
cutpoints
# 0.2 is the smallest carat size
# 5.01 is the largest carat size
# 1/3 of the diamonds are between 0.5 and 0.5
# another third between 0.5 and 1 carat
# remaining third are between 1 and 5.01 carats

# use the R command cut to label each of the 53940 diamonds in the
# dataset as belonging to one of these 3 factors
diamonds$car2 <- cut(diamonds$carat,cutpoints)

# Now we can continue with our multi-facet plot
g <- ggplot(diamonds, aes(depth, price))
g + geom_point(alpha = 1/3) + facet_grid(cut ~ car2)

g + geom_point(alpha = 1/3) + facet_grid(cut ~ car2) + 
    geom_smooth(method = "lm", size = 3, color = "pink")

ggplot(diamonds,aes(carat,price))+geom_boxplot()+facet_grid(.~cut) 


























