# Practice Programming Assignment: swirl Lesson 4: Plotting Systems
library(ggplot2)
library(jpeg)
library(lattice)

# The first plotting system is the Base Plotting System which comes with R. 
# It's the oldest system which uses a simple "Artist's palette" model. 
# What this means is that you start with a blank canvas and build your plot up 
# from there, step by step.

cars <- read.csv("cars.csv")
# the dataset collates the speeds and distances needed to stop for 50 cars. 
# This data was recorded in the 1920's
with(cars, plot(speed, dist))
text(mean(cars$speed), max(cars$dist), "SWIRL rules!")

# Now we'll move on to the second plotting system, the Lattice System which 
# comes in the package of the same name. Unlike the Base System, lattice plots 
# are created with a single function call such as xyplot or bwplot. Margins and 
# spacing are set automatically because the entire plot is specified at once.
# The lattice system is most useful for conditioning types of plots which display 
# how y changes with x across levels of z. The variable z might be a categorical 
# variable of your data. This system is also good for putting many plots on a 
# screen at once.
state <- read.csv("state.csv")
# state holds 9 pieces of information for each of the 50 states
# Run the R command table with the argument state$region to see how many 
# categories there are and how many states are in each.
table(state$region)
# So there are 4 categories and the 50 states are sorted into them appropriately
# Let's use the lattice command xyplot to see how life expectancy varies with 
# income in each of the four regions.
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))
# To do this we gave xyplot 3 arguments. The first is the most complicated. 
# It is this R formula, Life.Exp ~ Income | region, which indicates we're 
# plotting life expectancy as it depends on income for each region. The second 
# argument, data, is set equal to state. This allows us to use "Life.Exp" and 
# "Income" in the formula instead of specifying the dataset state for each term 
# (as in state$Income). The third argument, layout, is set equal to the two-long 
# vector c(4,1). Run xyplot now with these three arguments.

# Now for the last plotting system, ggplot2, which is a hybrid of the base and 
# lattice systems. It automatically deals with spacing, text, titles 
# (as Lattice does) but also allows you to annotate by "adding" to a plot 
# (as Base does), so it's the best of both world
mpg <- read.csv(mpg.csv)

table(mpg$model)
# 38 models

# We're interested in the effect engine displacement (displ) has on highway gas 
# mileage (hwy), so we'll use the ggplot2 command qplot to display this relationship.
qplot(displ, hwy, data = mpg)
# the bigger the engine displacement the lower the gas mileage.








