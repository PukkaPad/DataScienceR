# Practice Programming Assignment: swirl Lesson 3: GGPlot2 Part1
library(ggplot2)
data(mpg)

str(mpg)
# 234 points in the dataset concerning 11 different characteristics of the cars

# Suppose we want to see if there's a correlation between engine displacement 
# (displ) and highway miles per gallon (hwy)
qplot(displ, hwy, data = mpg)
# The negative trend (increasing displacement and lower gas mileage) 
# is pretty clear

# do the same plot but this time use different colors to distinguish between the 
# 3 factors (subsets) of different types of drive (drv) in the data 
# (front-wheel, rear-wheel, and 4-wheel)
qplot(displ, hwy, data = mpg, color = drv)

# add moothing function to produce trend lines, one for each color
qplot(displ, hwy, data = mpg, color = drv, geom = c("point", "smooth"))
# Notice the gray areas surrounding each trend lines. 
# These indicate the 95% confidence intervals for the lines.

qplot(y=hwy, data = mpg, color = drv)
# We see the x-axis ranges from 0 to 250 and we remember that we had 234 data 
# points in our set, so we can infer that each point in the plot represents one 
# of the hwy values (indicated by the y-axis)

# qplot can also create box and whisker plots
qplot(drv, hwy, data = mpg, geom = "boxplot")
# 3 boxes, one for each drive
qplot(drv, hwy, data = mpg, geom = "boxplot", color = manufacturer)
# there are still 3 regions of the plot (determined by the factor drv). 
# Each is subdivided into several boxes depicting different manufacturers.

# histograms
# First specify the variable for which you want the frequency count
# then specify the data 
qplot(hwy, data = mpg, fill = drv)

# two plots, a scatterplot and then a histogram, each with 3 facets
# the argument facets which will be set equal to the expression . 
# ~ drv which is ggplot2's shorthand for number of rows (to the left of the ~) 
# and number of columns (to the right of the ~)
qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv ~., binwidth = 2)













