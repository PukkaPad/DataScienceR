# Practice Programming Assignment: swirl Lesson 4: GGPlot2 Part2
library(ggplot2)
data(mpg)

qplot(displ, hwy, data = mpg, geom=c("point", "smooth"),facets=.~drv) 
#  We see a 3 facet plot, one for each drive type (4, f, and r)

# Now we'll see how ggplot works. We'll build up a similar plot using
# the basic components of the package
# create a variable g by assigning to it the output of a call to ggplot with 2 arguments
g <- ggplot(mpg, aes(displ,hwy) )
summary(g)
# if you tried to print g with the expressions g or print(g) you'd get an error
# type g+geom_point() and see what happens.
g+geom_point() 
# By calling the function geom_point you added a layer. By not assigning the 
# expression to a variable you displayed a plot
g+geom_point()+geom_smooth() 
# The gray shadow around the blue line is the confidence band
# try a different smoothing function
g+geom_point()+geom_smooth(method = "lm") 
g+geom_point()+geom_smooth(method="lm") + facet_grid(.~drv) 
# Notice how each panel is labeled with the appropriate factor.
g+geom_point()+geom_smooth(method="lm") + facet_grid(.~drv) + ggtitle("Swirl Rules!")

# practice modifying aesthetics
g+geom_point(color="pink",size=4,alpha=1/2) 
g+geom_point(size=4,alpha=1/2,aes(color=drv)) 

g + geom_point(aes(color = drv)) + labs(title="Swirl Rules!") + labs(x="Displacement", y="Hwy Mileage")

g + geom_point(aes(color = drv), size = 2, alpha = 1/2) +geom_smooth(size = 4, linetype = 3, method="lm", se = FALSE) 
#  The method specified a linear regression (note the negative slope indicating 
# that the bigger the displacement the lower the gas mileage), the linetype 
# specified that it should be dashed (not continuous), the size made the dashes
# big, and the se flag told ggplot to turn off the gray shadows indicating 
# standard errors (confidence intervals).

# let's do a simple plot using the black and white theme, theme_bw
g + geom_point(aes(color = drv)) + theme_bw(base_family="Times")

# Create the graphical object g by assigning to it a call to ggplot with 2 
# arguments. The first is the dataset and the second is a call to the function 
# aes. This call will have 3 arguments, x set equal to displ, y set equal to hwy, 
# and color set equal to factor(year). This last will allow us to distinguish 
# between the two manufacturing years (1999 and 2008) in our data.
g <- ggplot(mpg, aes(x = displ, y = hwy, color = factor(year)))
g
# add to g a call to the function geom_point with 0 arguments
g + geom_point()
# add a call the function facet_grid with 2 arguments
# The first is the formula drv~cyl, and the second is the argument margins 
# set equal to TRUE
g + geom_point() +  facet_grid(drv~cyl, margins = TRUE)
# The margins argument tells ggplot to display the marginal totals over each row 
# and column, so instead of seeing 3 rows (the number of drv factors) and 4 
# columns (the number of cyl factors) we see a 4 by 5 display
# Now add to your last command a call to geom_smooth with 4 arguments. 
# These are method set to "lm", se set to FALSE, size set to 2, and color set 
# to "black".
g + geom_point() +  facet_grid(drv~cyl, margins = TRUE) +
    geom_smooth(method = "lm", se = FALSE, size = 2, color = "black")
# Finally, add to your last command a call to the function labs with 3 arguments
# These are x set to "Displacement", y set to "Highway Mileage", 
# and title set to "Swirl Rules!".
g + geom_point() +  facet_grid(drv~cyl, margins = TRUE) + 
    geom_smooth(method = "lm", se = FALSE, size = 2, color = "black") + 
    labs(x = "Displacement", y = "Highway Mileage", title = "Swirl Rules!")














