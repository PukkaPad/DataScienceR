# Practice Programming Assignment: swirl Lesson 1: Hierarchical Clustering
# Week 3

# Clustering organizes data points that are close into groups. 
# So obvious questions are "How do we define close?"
# "How do we group things?"
# "How do we interpret the grouping?"

library(fields)
library(jpeg)
library(datasets)

# Consider the random points generated:
set.seed(1234)
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each  = 4), sd = 0.2)
plot(x,y,col="blue", pch=19, cex=2)
text(x+0.05, y + 0.05, labels = as.character(1:12))

# In this method, each observation starts in its own cluster, and pairs of 
# clusters are merged as one moves up the hierarchy." 
# (http://en.wikipedia.org/wiki/Hierarchical_clustering)
# This means that I have to find the closest 2 points and put them together in
# one cluster. Then I find the next closest par in the updated picture, and so on
# This process is repeated until I reach a reasonable stopping place

# As the image shows, I will 1st cluster the points 5 and 6
# However, there are several ways to measure distance or similarity. 
# Euclidean distance and correlation similarity are continuous measures, 
# while Manhattan distance is a binary measure

# the coordanates of the points are stored in a data frame:
dataFrame <- data.frame(x = x, y = y)

# compute the distance between all the pairs of these points:
distxy <- dist(dataFrame) # by default dist uses Euclidean distance
# the output is a lower triangular matrix that indicates the distance between the points i and j

# R has a function, hclust(), that creates a dendrogram. It takes the distance matrix 
# as argument
hClustering <- hclust(distxy)
plot(hClustering)
# at the bottom: 5 and 6 are connected, 10 and 11 are connected
# as the original plot showed, there are 3 groups

# for the leaves(original points) to be printed at the same level:
plot(as.dendrogram(hClustering))
abline(h = 1.5, col = "blue")
# this blue line intersects 3 vertical lines and this tells us that using the 
# distance 1.5 (unspecified units) gives 3 clusters (1 through 4), 
# (9 through 12), and (5 through 8). This is called a "cut" of the dendrogram. 
# I will cut the dendrogam by drawing a red horizontal line at .4.
abline(h = 0.4, col = "red")
# At this distance, there are 5 clusters

# The number of clusters in the data depends on where I draw the line. 
# How is the distance between clusters measured?
# One way of measuring it is called complete linkage. IT says that if you are 
# trying to measure the distance between 2 clusters, take the greatest distance 
# between the pair of points in those clusters

# if I were measuring the distance between the two clusters of points 
# (1 through 4) and (5 through 8), using complete linkage as the metric I would 
# use the distance between points 4 and 8 as the measure since this is the 
# largest distance between the pairs of those groups.
plot(x,y,col="blue", pch=19, cex=2)
text(x+0.05, y + 0.05, labels = as.character(1:12))
segments(x[4], y[4], x[8], y[8], col = "orange")

# The distance between the two clusters of points (9 through 12) and (5 through 8), 
# using complete linkage as the metric, is the distance between points 11 and 8 
# since this is the largest distance between the pairs of those groups.
segments(x[11], y[11], x[8], y[8], col = "red")

# the distance between the two clusters of points (9 through 12) and (1 through 4), 
# using complete linkage as the metric, is the distance between points 11 and 4.
segments(x[11], y[11], x[4], y[4], col = "black")

# Create a df containing these 3 points
dFsm<- dataFrame[c(4,8,11),]
# whats the smallest distance between these 3 points?
dist(dFsm)
# it's between points 2 and 3 in the reduced set (they are actually points 8 and 
# 11). This indicates that the 2 clusters these 2 points represent 
# ((5 through 8) and (9 through 12) respectively) would be joined (at distance 1.87)
# before being connected with the 3rd cluster (1 through 4)
# this is consistent with the dendrogram plotted
plot(as.dendrogram(hClustering))

# Another way to measure the distance between 2 clusters is called average linkeage
# First an average point is computed in each cluster. This is done by computing the 
# average of x and y coordinates of the points in the cluster
plot(x,y,col="blue", pch=19, cex=2)
text(x+0.05, y + 0.05, labels = as.character(1:12))
points(mean(x[1:4]),mean(y[1:4]),col="orange",pch=3,lwd=3,cex=3)
points(mean(x[5:8]),mean(y[5:8]),col="red",pch=3,lwd=3,cex=3)
points(mean(x[10:12]),mean(y[10:12]),col="black",pch=3,lwd=3,cex=3)
# then I compute the distances between each cluster average to computer the 
# intercluster distance
segments(mean(x[1:4]),mean(y[1:4]),mean(x[5:8]),mean(y[5:8]),lwd=3,col="green")
segments(mean(x[1:4]),mean(y[1:4]),mean(x[10:12]),mean(y[10:12]),lwd=3,col="green")
segments(mean(x[10:12]),mean(y[10:12]),mean(x[5:8]),mean(y[5:8]),lwd=3,col="green")

# Looking at hCustering
hClustering
# the linkage used to agglomerate clusters was "complete".

# Next method for visualizing data is heat maps
# Wikipedia (http://en.wikipedia.org/wiki/Heat_map) tells a heat map is 
# "a graphical representation of data where the individual values contained in 
# a matrix are represented as colors. ... 
# Heat maps originated in 2D displays of the values in a data matrix. Larger
# values were represented by small dark gray or black squares (pixels) and 
# smaller values by lighter squares."

# R tutorial:
# http://sebastianraschka.com/Articles/heatmaps_in_r.html#clustering

#install.packages("gplots")
library(gplots)
library(RColorBrewer)

url = "https://raw.githubusercontent.com/rasbt/R_snippets/master/heatmaps/dataset.csv"
download.file(url, destfile = "../data/dataset.csv", method = "curl")


# follow here: https://github.com/rasbt/R_snippets/blob/master/heatmaps/h1_simple.R
data <- read.csv("../data/dataset.csv", sep = ",", header = TRUE, comment.char="#")
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
mat_data <- data.matrix(data[,2:ncol(data)])  # transform column 2-5 into a matrix
rownames(mat_data) <- rnames                  # assign row names

#########################################################
### customizing and plotting heatmap
#########################################################

# creates a own color palette from red to green
my_palette <- colorRampPalette(c("red", "yellow", "green"))(n = 299)

# (optional) defines the color breaks manually for a "skewed" color transition
col_breaks = c(seq(-1,0,length=100),   # for red
               seq(0.01,0.7,length=100),            # for yellow
               seq(0.71,1,length=100))              # for green

# creates a 5 x 5 inch image
png("h1_simple.png",
    width = 5*300,        # 5 x 300 pixels
    height = 5*300,
    res = 300,            # 300 pixels per inch
    pointsize = 8)        # smaller font size

heatmap.2(mat_data,
          cellnote = mat_data,  # same data set for cell labels
          main = "Correlation", # heat map title
          notecol="black",      # change font color of cell labels to black
          density.info="none",  # turns off density plot inside color legend
          trace="none",         # turns off trace lines inside the heat map
          margins =c(12,9),     # widens margins around plot
          col=my_palette,       # use on color palette defined earlier
          breaks=col_breaks,    # enable color transition at specified limits
          dendrogram="row",     # only draw a row dendrogram
          Colv="NA")            # turn off column clustering

##############################################################################
# NOTE
##############################################################################
# The color breaks above will yield a warning
#    "...unsorted 'breaks' will be sorted before use" since they contain
#    (due to the negative numbers). To avoid this warning, you can change the
#    manual breaks to:
#
#  col_breaks = c(seq(0,1,length=100),   # for red
#    seq(1.01,1.7,length=100),           # for yellow
#    seq(1.71,2,length=100))             # for green
#
# However, the problem is then that our heatmap contains negative values
# which will then not be colored correctly. Remember that you don't need to
# provide manual color breaks at all, this is entirely optional.
##############################################################################

dev.off()


heatmap.2(mat_data,
          cellnote = mat_data,  # same data set for cell labels
          main = "Correlation", # heat map title
          notecol="black",      # change font color of cell labels to black
          density.info="none",  # turns off density plot inside color legend
          trace="none",         # turns off trace lines inside the heat map
          margins =c(12,9),     # widens margins around plot
          col=my_palette,       # use on color palette defined earlier
          breaks=col_breaks,    # enable color transition at specified limits
          dendrogram="row",     # only draw a row dendrogram
          Colv="NA")            # turn off column clustering

### back to swirl
dataFrame <- data.frame(x=x,y=y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),] # point data in a matrix
heatmap(dataMatrix,col=cm.colors(25))
# The rows and columns are grouped together as shown by colors. The top rows 
# (labeled 5, 6, and 7) seem to be in the same group (same colors) while 8 is 
# next to them but colored differently. This matches the dendrogram shown on the 
# left edge. Similarly, 9, 12, 11, and 10 are grouped together (row-wise) along 
# with 3 and 2. These are followed by 1 and 4 which are in a separate group. 
# Column data is treated independently of rows but is also grouped.











