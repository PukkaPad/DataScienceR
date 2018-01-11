# Lesson 3: Working with Colour
# Week 3

# colorRamp
# [,1] [,2] [,3] corresponds to [Red] [Blue] [Green]
par(mfrow=c(1,1))
pal <- colorRamp(c("red", "blue")) # interpolating between red and blue

pal(0) # 255 0 0 = brightest red 
pal(1) # 0 0 255 = brightest blue
pal(0.5) # 127.5 0 127.5 = colour in betwen red and blue..
pal(seq(0, 1, len = 10)) # gives me 10 colours

# colorRampPalette
pal <- colorRampPalette(c("red", "yellow"))
pal(2) # returns 2 colours, red and yellow
pal(10) # returns 10 colours

# RColorBrewer and colorRampPalette
library(RColorBrewer)
cols <- brewer.pal(3, "BuGn") # number of colours, name of the pallet
cols # it returns 3 colours
pal <- colorRampPalette(cols)
image(volcano, col = pal(20))

# the smoothScatter function
# useful if i need to make a scatterplot of large data points
x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x, y)

# scatterplot with no transparency
plot(x, y, pch=19)

# scatterplot with transparency
plot(x, y, col = rgb(0,0,0,0.2), pch=19) # areas with points overlapping will be darker

