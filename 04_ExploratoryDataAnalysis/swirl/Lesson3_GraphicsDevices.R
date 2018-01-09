# Practice Programming Assignment: swirl Lesson 3: Graphics Devices in R

# As an example, run the R command with with 2 arguments. The first is a dataset, 
# faithful, which comes with R, and the second is a call to the base plotting 
# function plot. Your call to plot should have two arguments, eruptions and waiting.
library(datasets)
data(faithful)
with(faithful, plot(eruptions, waiting)) 
title (main = "Old Faithful Geyser data")
dev.cur()

# The second way to create a plot is to send it to a file device. Depending on 
# the type of plot you're making, you explicitly launch a graphics device, 
# e.g., a pdf file.
pdf(file="myplot.pdf") # will launch the file device
with(faithful, plot(eruptions, waiting)) 
title (main = "Old Faithful Geyser data")
dev.off() # to close the pdf device

with(faithful, plot(eruptions, waiting)) 
title (main = "Old Faithful Geyser data")
dev.copy(png, file = "geyserplot.png")
dev.off()
