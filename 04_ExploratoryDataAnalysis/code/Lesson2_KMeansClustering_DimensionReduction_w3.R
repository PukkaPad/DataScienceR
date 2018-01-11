# Lesson 2: K-Means Clustering & Dimension Reduction
# Week 3 

############################## K-means clustering
set.seed(1234); #par(mar=c(0,0,0,0))
x <- rnorm(12,mean=rep(1:3,each=4),sd=0.2)
y <- rnorm(12,mean=rep(c(1,2,1),each=4),sd=0.2)
plot(x,y,col="blue",pch=19,cex=2)
text(x+0.05,y+0.05,labels=as.character(1:12))

# starting centroids
#par(mar=rep(0.2,4))
plot(x,y,col="blue",pch=19,cex=2)
text(x+0.05,y+0.05,labels=as.character(1:12))
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
points(cx,cy,col=c("red","orange","purple"),pch=3,cex=2,lwd=2)

# assign to closest centroid
#par(mar=rep(0.2,4))
plot(x,y,col="blue",pch=19,cex=2)
cols1 <- c("red","orange","purple")
text(x+0.05,y+0.05,labels=as.character(1:12))
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
points(cx,cy,col=cols1,pch=3,cex=2,lwd=2)

## Find the closest centroid
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust])
 
# recalculate centroid
plot(x,y,col="blue",pch=19,cex=2)
cols1 <- c("red","orange","purple")
text(x+0.05,y+0.05,labels=as.character(1:12))

## Find the closest centroid
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust])
newCx <- tapply(x,newClust,mean)
newCy <- tapply(y,newClust,mean)

## Old centroids

cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)

points(newCx,newCy,col=cols1,pch=3,cex=2,lwd=2)

# reassign values
plot(x,y,col="blue",pch=19,cex=2)
cols1 <- c("red","orange","purple")
text(x+0.05,y+0.05,labels=as.character(1:12))


cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)


## Find the closest centroid
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
newCx <- tapply(x,newClust,mean)
newCy <- tapply(y,newClust,mean)

## Old centroids

points(newCx,newCy,col=cols1,pch=3,cex=2,lwd=2)


## Iteration 2
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-newCx[1])^2 + (y-newCy[1])^2
distTmp[2,] <- (x-newCx[2])^2 + (y-newCy[2])^2
distTmp[3,] <- (x-newCx[3])^2 + (y-newCy[3])^2
newClust2 <- apply(distTmp,2,which.min)

points(x,y,pch=19,cex=2,col=cols1[newClust2])

# update centroids
plot(x,y,col="blue",pch=19,cex=2)
cols1 <- c("red","orange","purple")
text(x+0.05,y+0.05,labels=as.character(1:12))


cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)

## Find the closest centroid
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
newCx <- tapply(x,newClust,mean)
newCy <- tapply(y,newClust,mean)



## Iteration 2
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-newCx[1])^2 + (y-newCy[1])^2
distTmp[2,] <- (x-newCx[2])^2 + (y-newCy[2])^2
distTmp[3,] <- (x-newCx[3])^2 + (y-newCy[3])^2
finalClust <- apply(distTmp,2,which.min)


## Final centroids
finalCx <- tapply(x,finalClust,mean)
finalCy <- tapply(y,finalClust,mean)
points(finalCx,finalCy,col=cols1,pch=3,cex=2,lwd=2)



points(x,y,pch=19,cex=2,col=cols1[finalClust])

# kmeans()
dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame,centers=3)
names(kmeansObj)
kmeansObj$cluster

plot(x,y,col=kmeansObj$cluster,pch=19,cex=2) # coloring according to the cluster they happen to be
points(kmeansObj$centers,col=1:3,pch=3,cex=3,lwd=3)

# heatmaps
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObj <- kmeans(dataMatrix,centers=3)
par(mfrow=c(1,2), mar = c(2, 4, 0.1, 0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt="n")
image(t(dataMatrix)[,order(kmeansObj$cluster)],yaxt="n")

############################# Dimension Reduction
par(mar= c(5.1, 4.1, 4.1, 2.1))
# matrix data
set.seed(12345); par(mar=rep(0.2,4))
dataMatrix <- matrix(rnorm(400),nrow=40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])

# cluster data
heatmap(dataMatrix)

# add a pattern?
set.seed(678910)
for(i in 1:40){
    # flip a coin
    coinFlip <- rbinom(1,size=1,prob=0.5)
    # if coin is heads add a common pattern to that row
    if(coinFlip){
        dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3),each=5)
    }
}
par(mar= c(5.1, 4.1, 4.1, 2.1))
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])

heatmap(dataMatrix)

# patterns in rows and columns
hh <- hclust(dist(dataMatrix)); 
dataMatrixOrdered <- dataMatrix[hh$order,]
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered),40:1, ,xlab="Row Mean",ylab="Row",pch=19)
plot(colMeans(dataMatrixOrdered),xlab="Column",ylab="Column Mean",pch=19)


# problems:

# lot of variables, not necessarily independent 
# and I want to create a new set of variables that are uncorrelated
# want the reduced set of variables to explain the variability in the data

# want to find the best matrix created with fewer variables but that 
# explains the data really well


# Singular Value Decomposition (SVD)!

# Components of SVD - $u$ and $v$
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1],40:1, ,xlab="Row",ylab="First left singular vector",pch=19)
plot(svd1$v[,1],xlab="Column",ylab="First right singular vector",pch=19)

# Components of the SVD - Variance explained
par(mfrow=c(1,2))
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)

# Relationship to principal components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered,scale=TRUE)
plot(pca1$rotation[,1],svd1$v[,1],pch=19,xlab="Principal Component 1",ylab="Right Singular Vector 1")
abline(c(0,1))

# Components of the SVD - variance explained
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1),each=5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)

# add 2nd pattern?
set.seed(678910)
for(i in 1:40){
    # flip a coin
    coinFlip1 <- rbinom(1,size=1,prob=0.5)
    coinFlip2 <- rbinom(1,size=1,prob=0.5)
    # if coin is heads add a common pattern to that row
    if(coinFlip1){
        dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),each=5)
    }
    if(coinFlip2){
        dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),5)
    }
}
hh <- hclust(dist(dataMatrix)); dataMatrixOrdered <- dataMatrix[hh$order,]

# Singular value decomposition - true patterns
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rep(c(0,1),each=5),pch=19,xlab="Column",ylab="Pattern 1")
plot(rep(c(0,1),5),pch=19,xlab="Column",ylab="Pattern 2")

# $v$ and patterns of variance in rows
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd2$v[,1],pch=19,xlab="Column",ylab="First right singular vector")
plot(svd2$v[,2],pch=19,xlab="Column",ylab="Second right singular vector")

# d and variance explained
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,2))
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Percent of variance explained",pch=19)

# Missing values
dataMatrix2 <- dataMatrixOrdered
## Randomly insert some missing data
dataMatrix2[sample(1:100,size=40,replace=FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2))  ## Doesn't work!

# Imputing {impute}
library(impute)  ## Available from http://bioconductor.org
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100,size=40,replace=FALSE)] <- NA
dataMatrix2 <- impute.knn(dataMatrix2)$data
svd1 <- svd(scale(dataMatrixOrdered)); svd2 <- svd(scale(dataMatrix2))
par(mfrow=c(1,2)); plot(svd1$v[,1],pch=19); plot(svd2$v[,1],pch=19)

# Face example
load("../data/face.rda")
image(t(faceData)[,nrow(faceData):1])

# Face example - variance explained
svd1 <- svd(scale(faceData))
plot(svd1$d^2/sum(svd1$d^2),pch=19,xlab="Singular vector",ylab="Variance explained")

# Face example - create approximations

svd1 <- svd(scale(faceData))
## Note that %*% is matrix multiplication

# Here svd1$d[1] is a constant
approx1 <- svd1$u[,1] %*% t(svd1$v[,1]) * svd1$d[1]

# In these examples we need to make the diagonal matrix out of d
approx5 <- svd1$u[,1:5] %*% diag(svd1$d[1:5])%*% t(svd1$v[,1:5]) 
approx10 <- svd1$u[,1:10] %*% diag(svd1$d[1:10])%*% t(svd1$v[,1:10]) 

# Face example - plot approximations
par(mfrow=c(1,4))
image(t(approx1)[,nrow(approx1):1], main = "(a)")
image(t(approx5)[,nrow(approx5):1], main = "(b)")
image(t(approx10)[,nrow(approx10):1], main = "(c)")
image(t(faceData)[,nrow(faceData):1], main = "(d)")  ## Original data
