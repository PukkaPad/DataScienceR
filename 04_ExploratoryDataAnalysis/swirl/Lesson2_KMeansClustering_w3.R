# Practice Programming Assignment: swirl Lesson 2: K Means Clustering
# week 3

library(ggplot2)
library(fields)
library(jpeg)
library(datasets)

# this technique is most useful in the early stages of analysis when trying to 
# understand the data

# Consider the random points generated:
set.seed(1234)
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each  = 4), sd = 0.2)
plot(x,y,col="blue", pch=19, cex=2)
text(x+0.05, y + 0.05, labels = as.character(1:12))

# k-means is a partioning approach which requires that to first guess how many 
# clusters are present (or wanted). Once this number is fixed, randomly create a 
# "centroid" (a phantom point) for each cluster and assign each point or 
# observation in the dataset to the centroid to which it is closest. Once each 
# point is assigned a centroid, readjust the centroid's position by making it 
# the average of the points assigned to it.
# Once the centroid have been repositioned, it is necessary to recalculate the 
# distance of the observations to the centroids and reassign any, if necessary,
# to the centroid closest to them. 
# Once the reassignement is done, readjust the positions of the centroids based 
# on the new cluster membership.
# The process stops once it reachs an iteration in which no adjustments are made 
# or when it's reached some predetermined maximum number of iterations.

# create the centroids
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
points(cx,cy,col=c("red","orange","purple"),pch=3,cex=2,lwd=2)

#dataFrame <- data.frame(x=cx,y=cy)
set.seed(143)
cmat <- matrix(NA,nrow=2,ncol=3)
cmat[1,] <- as.matrix(dataFrame$x) # point data in a matrix
cmat[2,] <- as.matrix(dataFrame$y) 
cmat
# The coordinates of these points are (1,2), (1.8,1) and (2.5,1.5)

# add centroids to plot
points(cx, cy, col = c("red", "orange", "purple"), pch = 3, cex = 2, lwd = 2)

# now calculate the distance between each point and every centroid
# 12 points and 36 centroids = 36 distances to calculate

# swirl function, mdist, to compute the distance
mdist <- function(x,y,cx,cy){
    distTmp <- matrix(NA,nrow=3,ncol=12)
    distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
    distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
    distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2  
    return(distTmp)
}
mdist(x,y,cx,cy)
distTmp <- mdist(x,y,cx,cy)

# Now I need to assig a cluster to each point
# Look at each column and pick the minimum entry

# From the distTmp, point 6 would be assigned to cluster 3 (0.26 distance)
# To know the minimum distances
apply(distTmp, 2, which.min) # 2 meaning the columns of distTmp
# The 1st 3 entrances are assigned to the second (orange) cluster, and only points 4 and 8 are assigned to the first red cluster

# store vector of colours in cols1
# store the cluster assignments in newClust
# colurs the 12 points according to the assignments
cols1 <- c("red","orange","purple")
newClust <- apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust])

# recalculate the centroid so they are the average of the cluster points assigned
# to them
# use tapply which applies "a function over a ragged array" - every element of 
# the array is assigned a factor and the function is applied to subsets of the 
# array (identified by the factor vector)
newCx <- tapply(x, newClust, mean)
newCy <- tapply(y, newClust, mean)

points(newCx, newCy, col = cols1, pch = 8, cex = 2, lwd = 2)
# the centroids have moved closer to their respective clusters

# call mdist to check if the points will need to be reassigned
distTmp2 <- mdist(x,y,newCx,newCy)
distTmp2
# point 7 is closer to red (line 1)
# point 4 is closer to orange (line 2)

# find the new cluster assignments for the points
apply(distTmp2, 2, which.min) 

newClust2 <- apply(distTmp2,2,which.min)

# recolor the points with their new assignments
points(x,y,pch=19,cex=2,col=cols1[newClust2])

# find coordinates of new centroid nd plot them
finalCx <- tapply(x, newClust2, mean)
finalCy <- tapply(y, newClust2, mean)

points(finalCx, finalCy, col = cols1, pch = 9, cex = 2, lwd = 2)

#########################
# R has a command that does all this!
# it's called kmeans
dataFrame <- data.frame(x,y)
kmeans(dataFrame, centers = 3)
kmeansObj <- kmeans(dataFrame,centers=3)

names(kmeansObj)

# how many iterations?
kmeansObj$iter

# to plot the data points color coded to their cluster
kmeansObj$cluster
plot(x,y,col = kmeansObj$cluster, pch = 19, cex = 2)

# add the centroid 
points(kmeansObj$centers, col = c("black", "red", "green"),pch=3,cex=3,lwd=3)

###################
# 6 clusters instead of 3?

# the clustering changes with different starts

plot(x,y,col =  kmeans(dataFrame,6)$cluster, pch = 19, cex = 2)
plot(x,y,col =  kmeans(dataFrame,6)$cluster, pch = 19, cex = 2)
plot(x,y,col =  kmeans(dataFrame,6)$cluster, pch = 19, cex = 2)





