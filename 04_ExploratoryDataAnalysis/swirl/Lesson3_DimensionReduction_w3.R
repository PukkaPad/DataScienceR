# Practice Programming Assignment: swirl Lesson 3: Dimension Reduction
# week 3

library(fields)
library(jpeg)
library(datasets)

# random data
set.seed(12345); 
dataMatrix <- matrix(rnorm(400),nrow=40)
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]


image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt="n")
#image(t(dataMatrix)[,order(kmeansObj$cluster)],yaxt="n")

heatmap(dataMatrix)
# data look random
# rows = observation
# columns = variables

# add pattern to the data
# it will be determined by a coin flip
# in rows affected by the coin flip, the 5 left columns will still have a mean 
# of 0 but the right 5 columns will have a mean closer to 3.
source("addPatt.R", local = TRUE)

# altered matrix
# pattern is visible: right half is yellower, indicating higher values in the matrix
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt="n")

heatmap(dataMatrix)
# dendrogram split into 2 clusters (see columns)
# lower numbered: 1 through 5
# higher numbered: 6 through 10

# patterns in rows and columns
hh <- hclust(dist(dataMatrix)); 
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered),40:1, ,xlab="Row Mean",ylab="Row",pch=19)
plot(colMeans(dataMatrixOrdered),xlab="Column",ylab="Column Mean",pch=19)
# The middle display shows the mean of each of the 40 rows (along the x-axis). 
# The rows are shown in the same order as the rows of the heat matrix on the 
# left. The rightmost display shows the mean of each of the 10 columns. Here the 
# column numbers are along the x-axis and their means along the y.

# We see immediately the connection between the yellow (hotter) portion of the 
# cluster image and the higher row means, both in the upper right portion of the 
# displays. Similarly, the higher valued column means are in the right half of 
# that display and lower colummn means are in the left half.














