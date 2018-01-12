# Practice Programming Assignment: swirl Lesson 4: Clustering Example
# # week 3
# 
# 
#  we'll apply some of the analytic techniques we learned in this course to data 
#  from the University of California, Irvine. Specifically, the data we'll use 
#  is from UCI's Center for Machine Learning and Intelligent Systems. 
#  You can find out more about the data at 
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 
#  As this address indicates, the data involves smartphones and recognizing human activity.
#  
#  
ssd <- read.csv("ssd.csv") #[1:563]
dim(ssd) # 7352 obs, 563 variables

# The study creating this database involved 30 volunteers "performing activities 
# of daily living (ADL) while carrying a waist-mounted smartphone with embedded 
# inertial sensors. Each person performed six activities wearing a smartphone 
# (Samsung Galaxy S II) on the waist. 
# The experiments have been video-recorded to label the data manually.  
# The obtained dataset has been randomly partitioned into two sets, where 70% of 
# the volunteers was selected for generating the training data and 30% the test data."
names(ssd[562:563])

table(ssd$subject) # ssd contains only training data
sum(table(ssd$subject))

table(ssd$activity)
sum(table(ssd$activity))
ssd <- transform(ssd, activity = factor(activity))

# look at 1st subject
sub1 <- subset(ssd, subject == 1)
dim(sub1)
names(sub1[1:12])
# X, Y, and Z (3 dimensions) of different aspects of body acceleration 
# measurements, such as mean and std deviation
# do some comparisons of activities now by looking at plots of mean body 
# acceleration in the X and Y directions
# showXY.R
source("showXY.R")
#  the active activities related to walking (shown in the two blues and magenta) 
#  show more variability than the passive activities (shown in black, red, and green),
#  particularly in the X dimension.
#  

showMe <- function(cv){
    "displays colour vectors"
    myarg <- deparse(substitute(cv))
    z<- outer( 1:20,1:20, "+")
    obj<- list( x=1:20,y=1:20,z=z )
    image(obj, col=cv, main=myarg  )
}

showMe(1:6)
# The colors at the bottom, black, red and green, mark the passive activities, 
# while the true blues and magenta near the top show the walking activities.

# focus on the 3 dimensions of mean acceleration. (The plot above looked at the 
# first 2 dimensions.) Create a distance matrix, mdist, of the first 3 columns 
# of sub1, by using the R command dist. Use the x[,1:3] notation to specify the
# columns.
mdist <- dist(sub1[,1:3])
# create the variable hclustering by calling the R command hclust and passing it 
# mdist as an argument
hclustering <- hclust(mdist)
# call the pretty plotting function (myplclust) with 2 arguments: hclustering
# and lab.col
source("myplclust.R")
myplclust(hclustering, lab.col = unclass(sub1$activity))
# There's no clear grouping of colors, except that active colors (blues and
# magenta) are near each other as are the passive (black, red, and green)

# average acceleration doesnt help much. 
# How about maximum acceleration? look at that for the first subject 
# (in array sub1) for the X and Y dimensions. These are in column 10 and 11.
par(mfrow=c(1, 2), mar = c(5, 4, 1, 1))
plot(sub1[, 10], col = sub1$activity, ylab = names(sub1)[10])
plot(sub1[, 11], col = sub1$activity, ylab = names(sub1)[11])
legend("bottomright",legend=unique(sub1$activity),col=unique(sub1$activity), pch = 1)
par(mfrow=c(1,1))
# passive activities mostly fall below the walking activities

# focus then on the 3 dimensions of maximum acceleration, stored in columns 10 
# through 12 of sub1. Create a new distance matrix, mdist, of these 3 columns of 
# sub1, by using the R command dist. Again, use the x[,10:12] notation to catch 
# the columns.
mdist <- dist(sub1[,10:12])
# Now create the variable hclustering by calling hclust with mdist as the argument.
hclustering <- hclust(mdist)
myplclust(hclustering, lab.col = unclass(sub1$activity))
# Clearly the data splits into 2 clusters, active and passive activities. 
# Moreover, the light blue (walking down) is clearly distinct from the other 
# walking activities. The dark blue (walking level) also seems to be somewhat 
# clustered. The passive activities, however, seem all jumbled together with no 
# clear pattern visible.

# Try SVD
# Create the variable svd1 by assigning to it the output of a call to the R 
# command svd. The argument to svd should be scale(sub1[,-c(562,563)]). This will 
# remove the last 2 columns from sub1 and scale the data. Recall that the last 2
# columns contain activity and subject information which is not necessary.
svd1 <- svd(scale(sub1[,-c(562,563)]))

# check left singular vector of sub1
dim(svd1$u)
# the u matrix is a 347 by 347 matrix. Each row in u corresponds to a row in the 
# matrix sub1.
# in sub1 each row has an associated activity.

# check the 2 left singular vectors of sdv (the first 2 columns of svd1$u)
# Each entry of the columns belongs to a particular row with one of the 6 
# activities assigned to it.
# Moving from left to right, the first section of rows are green (standing), 
# the second red (sitting), the third black (laying), etc.  The first column of u
# shows separation of the nonmoving (black, red, and green) from the walking 
# activities. The second column is harder to interpret. However, the magenta 
# cluster, which represents walking up, seems separate from the others.
par(mfrow=c(1, 2), mar = c(5, 4, 1, 1))
plot(svd1$u[, 1], col = sub1$activity)
plot(svd1$u[, 2], col = sub1$activity)
legend("bottomright",legend=unique(sub1$activity),col=unique(sub1$activity), pch = 1)
par(mfrow=c(1,1))

# why is this?
# To do that we'll have to find which of the 500+ measurements (represented by 
# the columns of sub1) contributes to the variation of that component. Since 
# interested is in sub1 columns, look at the RIGHT singular vectors (the columns
# of svd1$v), and in particular, the second one since the separation of the 
# magenta cluster stood out in the second column of svd1$u.
plot(svd1$v[, 2], col = rgb(0,0,0, 0.5), pch = 19) # Here's a plot of the second column of svd1$v

# Create the variable maxCon by assigning to it the output of the R command 
# which.max using the second column of svd1$v as an argument.
maxCon <- which.max(svd1$v[,2])
# create a distance matrix mdist by assigning to it the output of the R command 
# dist using 4 columns of sub1 as the arguments.
# These 4 columns are 10 through 12 (10:12) and maxCon
mdist <- dist(sub1[,c(10:12,maxCon)])

hclustering <- hclust(mdist)
myplclust(hclustering, lab.col = unclass(sub1$activity))
# there's now some real separation
# Magenta (walking up) is on the far left, and the two other walking activities, 
# the two blues, are on the far right, but in separate clusters from one another. 
# The nonmoving activities still are jumbled together.

#  see what measurement is associated with this maximum contributor
names(sub1[maxCon])
# the mean body acceleration in the frequency domain in the Z direction is the 
# main contributor to this clustering phenomenon

# check if k-means clustering can distinguish between the activities.
# Create the variable kClust by assigning to it the output of the R command 
# kmeans with 2 arguments. The first is sub1 with the last 2 columns removed.
kClust <- kmeans(sub1[,-c(562,563)], centers = 6) # without specifying coordinates 
                                                  # for the cluster centroids (as done), 
                                                  # kmeans will generate starting 
                                                  # points randomly.
table(kClust$cluster, sub1$activity) # check result
# run with 1 random start, the clusters tend to group the nonmoving activities 
# together in one cluster. The walking activities seem to cluster individually by
# themselves.

# call kmeans with 3 arguments, the last of which will tell it to try more 
# random starts and return the best one
kClust <- kmeans(sub1[,-c(562,563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity) 
# the passive activities tend to cluster together. 
# One of the clusters contains only laying

# find the dimensions of kClust's centers
dim(kClust$centers) 

# Sometimes it's a good idea to look at the features (columns) of these centers 
# to see if any dominate.
# Create the variable laying and assign to it the output of the call to the R 
# command which with the argument kClust$size==29.
laying <- which(kClust$size==29)

plot(kClust$centers[laying,1:12], pch = 19, ylab = "Laying Cluster")
#  the first 3 columns dominate this cluster center
# what these columns contain?
names(sub1[1:3])
# So the 3 directions of mean body acceleration seem to have the biggest effect on laying.

walkdown <- which(kClust$size==49) 
plot(kClust$centers[walkdown,1:12], pch = 19, ylab = "Walkdown Cluster")
# From left to right, looking at the 12 acceleration measurements in groups of 3, 
# the points decrease in value.

























