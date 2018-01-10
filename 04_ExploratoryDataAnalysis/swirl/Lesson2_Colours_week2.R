# Practice Programming Assignment: swirl Lesson 2: Working with Colors
#  The motivation for this lesson is that the default color schemes for most plots 
# in R are not optimal. Fortunately there have been recent developments to improve 
# the handling and specification of colors in plots and graphs.

library(jpeg)
library(RColorBrewer)
library(datasets)

# So we'll first discuss some functions that the grDevices package offers
# The function colors() lists the names of 657 predefined colors you can use 
# in any plotting function
colors()
sample(colors(),10)

# two additional functions from grDevices, colorRamp and colorRampPalette, 
# give you more options
pal <- colorRamp(c("red","blue"))
pal(0) # red
pal(1) # blue
pal(.5)
pal(seq(0,1,len=6))

p1 <- colorRampPalette(c("red", "blue"))
p1(2) # FF0000 represents red, 0000FF represents blue
p1(6)
0xcc

p2 <- colorRampPalette(c("red", "yellow"))
p2(2)

# Create the function p3 now by calling colorRampPalette with the colors blue 
# and green (remember to concatenate them into a single argument) and setting the
# alpha argument to .5.
p3 <- colorRampPalette(c("blue", "green"), alpha = .5)

# reate a new object, cols by calling the function brewer.pal with 2 arguments, 
# 3 and "BuGn". The string "BuGn" is the second last palette in the sequential 
# display. The 3 tells the function how many different colors we want.
cols <- brewer.pal(3, "BuGn")























