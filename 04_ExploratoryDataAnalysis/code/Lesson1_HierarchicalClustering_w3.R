# Lesson 1: Hierarchical Clustering
# Week 3 

set.seed(1234)
#par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each  = 4), sd = 0.2)
plot(x,y,col="blue", pch=19, cex=2)
text(x+0.05, y + 0.05, labels = as.character(1:12))

# calculate the distance
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame) # pairwise distance

hClustering <- hclust(distxy)
plot(hClustering)
# the farther down the tree are the points clustered 1st

# Prettier dendrograms
myplclust <- function( hclust, lab=hclust$labels, lab.col=rep(1,length(hclust$labels)), hang=0.1,...){
    ## modifiction of plclust for plotting hclust objects *in colour*!
    ## Copyright Eva KF Chan 2009
    ## Arguments:
    ##    hclust:    hclust object
    ##    lab:        a character vector of labels of the leaves of the tree
    ##    lab.col:    colour for the labels; NA=default device foreground colour
    ##    hang:     as in hclust & plclust
    ## Side effect:
    ##    A display of hierarchical cluster with coloured leaf labels.
    y <- rep(hclust$height,2); x <- as.numeric(hclust$merge)
    y <- y[which(x<0)]; x <- x[which(x<0)]; x <- abs(x)
    y <- y[order(x)]; x <- x[order(x)]
    plot( hclust, labels=FALSE, hang=hang, ... )
    text( x=x, y=y[hclust$order]-(max(hclust$height)*hang),
          labels=lab[hclust$order], col=lab.col[hclust$order], 
          srt=90, adj=c(1,0.5), xpd=NA, ... )
}

dataFrame <- data.frame(x=x,y=y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
myplclust(hClustering,lab=rep(1:3,each=4),lab.col=rep(1:3,each=4))

# Even prettier
# http://gallery.r-enthusiasts.com/RGraphGallery.php?graph=79

# Merging points - complete
dataFrame <- data.frame(x=x,y=y)
par(mar=rep(0.1,4))
plot(x,y,col="blue",pch=19,cex=2)
points(x[8],y[8],col="orange",pch=3,lwd=3,cex=3)
points(x[1],y[1],col="orange",pch=3,lwd=3,cex=3)
segments(x[8],y[8],x[1],y[1],lwd=3,col="orange")

# Merge points - average
dataFrame <- data.frame(x=x,y=y)
par(mar=rep(0.1,4))
plot(x,y,col="blue",pch=19,cex=2)
points(mean(x[1:4]),mean(y[1:4]),col="orange",pch=3,lwd=3,cex=3)
points(mean(x[5:8]),mean(y[5:8]),col="orange",pch=3,lwd=3,cex=3)
segments(mean(x[1:4]),mean(y[1:4]),mean(x[5:8]),mean(y[5:8]),lwd=3,col="orange")

# heatmap()
# uses hierarchal cluster to organize the rows and columns
dataFrame <- data.frame(x=x,y=y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
heatmap(dataMatrix)















