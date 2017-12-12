# Week 3

## Subsetting and Sorting

# Subsetting - quick review
set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,3)] = NA # 1 and 3 are the positions
X
X[,1]
X[,"var1"]
X[1:2, "var2"]

# Logical ands and ors
X[(X$var1 <= 3 & X$var3 > 11), ] # both conditions will be met
X[(X$var1 <= 3 | X$var3 > 11), ] # one of the conditions will be met

# Dealing with missing values
X[which(X$var2>8),] # which does not return NA

# Sorting
sort(X$var1) # increasing order
sort(X$var1, decreasing=TRUE)
sort(X$var2, na.last=TRUE)

# Ordering
X[order(X$var1),] # order the df by var1, ie, sort the df by var1
X[order(X$var1, X$var3), ]

# Ordering with plyr
library(plyr)
arrange(X, var1)
arrange(X, desc(var1))

# Adding rows and columns
X$var4 <- rnorm(5)
X

Y <- cbind(X, rnorm(5))
Y

## Summarizing Data
# https://data.baltimorecity.gov/Culture-Arts/Restaurants/k5ry-ef3g

# create data directory (if it doesnt exist)
if (!file.exists("../data")){
    dir.create("../data")}

fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "../data/restaurants.csv", method="curl")
restData <- read.csv("../data/restaurants.csv")

head(restData, n=3)
tail(restData, n=3)

summary(restData)

str(restData)

quantile(restData$councilDistrict, na.rm=TRUE)

quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))

table(restData$zipCode, useNA="ifany") # would add a column to the table with NA, telling the n# of them

table(restData$councilDistrict, restData$zipCode)

# Check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0) # all checks for every single value

# Rows and columns sums
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

# Values with specific characteristics
table(restData$zipCode %in% c("21212"))

table(restData$zipCode %in% c("21212", "21213"))

# subsetting with specific values
restData[restData$zipCode %in% c("21212", "21213"),]

# Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt<- xtabs(Freq ~ Gender + Admit, data=DF) # 1st variable is the one displayed on the DF. 
                                           # For his example it is Freq
xt # will show the frequancy of males and females admitted and rejected

# Flat tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data=warpbreaks) # ~. means all the other variables
xt
ftable(xt)

# Size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData), units="Mb")

## Creating New Variables

# Create sequences
s1 <- seq(1, 10, by=2)
s1
s2 <- seq(1,10, length=3) # length is the number of values that will be created
s2
x<- c(1,3,8,25,100) # it's a vector of indexes 
seq(along=x)

# Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# creating binary variables
restData$zipWrong = ifelse(restData$zipCode <0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode <0)

# Creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

# Easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# Create factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# Levels of factor variables
yesno <- sample(c("yes", "no"), size=10, replace=TRUE)
yesnofac = factor(yesno, levels=c("yes", "no"))
relevel(yesnofac, ref="yes")

as.numeric(yesnofac)

# Cutting produces factor variables
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# Using mutate function
library(plyr)
restData2 = mutate(restData, zipGroups=cut2(zipCode, g=4))
table(restData2$zipGroups)

## Reshaping Data
library(reshape2)
head(mtcars)

# Melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars=c("mpg", "hp"))
head(carMelt,n=3)
tail(carMelt,n=3)

# Casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

# Averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum) # apply to count, along the index sray, the sum

# Another way - split
spIns = split(InsectSprays$count, InsectSprays$spray) # split the counts by each different spray
spIns

# Another way - Apply
sprCount = lapply(spIns, sum)
sprCount

# Another way - combine
unlist(sprCount)

sapply(spIns, sum)

# Another way - plyr package
library(plyr)
ddply(InsectSprays,.(spray), summarize, sum=sum(count))

# Creating a new variable
spraySums <- ddply(InsectSprays,.(spray), summarize, sum=ave(count, FUN=sum))
dim(spraySums)
head(spraySums)













