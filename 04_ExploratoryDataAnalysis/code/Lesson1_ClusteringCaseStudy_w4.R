# Lesson 1: Case Studies
# Clustering Case Study
# Week 4
setwd("/Users/MarianaSouza/Code/onlineCourses/Coursera/DataScienceR")
load("../data/samsungData.rda")
names(samsungData)[1:12]
table(samsungData$activity)

# plotting average acceleration for first subject
par(mfrow = c(1,2))
samsungData <- transform(samsungData, activity = factor(activity))
sub1 <- subset(samsungData, subject == 1)
plot(sub1[, 1], col = sub1$activity, ylab = names(sub1)[1])
plot(sub1[, 2], col = sub1$activity, ylab = names(sub1)[2])
legend("bottomright", legend = unique(sub1$activity), col = unique(sub1$activity),
       pch = 1)
par(mfrow = c(1,1))

# clustering based just on average acceleration
source("../swirl/myplclust.R")
distanceMatrix <- dist(sub1[, 1:3])
hpclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))

# plotting the max acceleration for the first subject
par(mfrow = c(1,2))
plot(sub1[, 10], pch = 19, col = sub1$activity, ylab = names(sub1)[10])
plot(sub1[, 11], pch = 19, col = sub1$activity, ylab = names(sub1)[11])
par(mfrow = c(1,1))

# clustering based just on maximum acceleration
source("../swirl/myplclust.R")
distanceMatrix <- dist(sub1[, 10:12])
hpclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))

# Singular Value Decomposition
svd1 = svd(scale(sub1[, -c(562, 563)]))
par(mfrow=c(1,2))
plot(svd1$u[,1],col=sub1$activity,pch=19)
plot(svd1$u[,2],col=sub1$activity,pch=19)
par(mfrow = c(1,1))

# Find maximum contributor
plot(svd1$v[,2],pch=19)

# New clustering with maximum contibutor
maxContrib <- which.max(svd1$v[,2])
distanceMatrix <- dist(sub1[, c(10:12,maxContrib)])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering,lab.col=unclass(sub1$activity)) 

# New clustering with maximum contributor
names(samsungData)[maxContrib]

# K-means clustering (nstart=1, first try)
kClust <- kmeans(sub1[,-c(562,563)],centers=6)
table(kClust$cluster,sub1$activity)

# K-means clustering (nstart=1, 2nd try)
kClust <- kmeans(sub1[,-c(562,563)],centers=6,nstart=1)
table(kClust$cluster,sub1$activity)

# K-means clustering(nstart=100, 1st try)
kClust <- kmeans(sub1[,-c(562,563)],centers=6,nstart=100)
table(kClust$cluster,sub1$activity)

# K-means clustering(nstart=100, 2nd try)
kClust <- kmeans(sub1[,-c(562,563)],centers=6,nstart=100)
table(kClust$cluster,sub1$activity)

# Cluster 1 Variable Centers(Walking)
plot(kClust$center[1,1:10],pch=19,ylab="Cluster Center",xlab="")

# Cluster 2 Variable Centers(Laying)
plot(kClust$center[4,1:10],pch=19,ylab="Cluster Center",xlab="")









