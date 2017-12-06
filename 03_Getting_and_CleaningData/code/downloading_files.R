# Week 1 - Getting and Cleaning Data

cat("\014")

setwd("03_Getting_and_CleaningData/code/")

# Checking for and creating 'data' directory
if (!file.exists ("../data")){
    dir.create("../data")
}

# Getting data from the internet
# download.file()
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "../data/cameras.csv", method = "curl") # method curl is necessary because of MAC
list.files("../data")
# keeping track of when I downloaded the data, so I know if there's some difference
# from other data downloaded previously
dateDownloaded <- date()
dateDownloaded

# Reading local flat files
# read.table(), read.csv(), read.csv2()
cameraData <- read.table("../data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)
# read.csv() automatically sets 'sep' to ',' and 'header' to 'TRUE'
cameraData <- read.csv("../data/cameras.csv")
head(cameraData)

# Reading Excel files
# fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true"
# download.file(fileUrl, destfile = "../data/cameras.xlsx", method = "curl") 
# list.files("../data")
# dateDownloaded <- date()
# dateDownloaded
library(openxlsx)
file = write.xlsx(cameraData, "../data/cameras.xlsx")
cameraData <- read.xlsx("../data/cameras.xlsx", sheet = 1)
head(cameraData)

# Reading XML files
# Extensible markup language
library(XML)
library(RCurl)
fileUrl <- "https://www.w3schools.com/xml/simple.xml"
xData <- getURL(fileUrl)
doc <- xmlParse(xData)
rootNode <- xmlRoot(doc) # to get the root node 
xmlName(rootNode)
names(rootNode) # tells what the nested elements within the root node are
# to directly access parts of the XML document
# similar to accessing lists in R
rootNode[[1]] 
rootNode[[1]][[1]] # 1st emelemt of the 1st subcomponent
# to programaticalllu extract parts of the file
xmlSApply(rootNode, xmlValue) #all the values

# XPath
# /node: Top level node
# //node: node at any level
# node[@attr-name]: node with an attribute name
# node[@attr-name='bob]: node with attribute name attr-name='bob'
# more info: https://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf

xpathSApply(rootNode, "//name", xmlValue) # will get all nodes that corresponds to an element with the title 'name'
xpathSApply(rootNode, "//price", xmlValue)

#
fileUrl <- "http://espn.co.uk/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=TRUE)
scores <- xpathSApply(doc, "//div[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams


# Reading JSON
# Javascript Object Notation
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData) # structured dataframe
# from the output of the above we can see the variables. 
# for example, one of the variables is 'owner'
# it is possible to access the names of that variable by:
names(jsonData$owner)
jsonData$owner$login # acess all the login

# Writing data frames to JSON
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
Iris2 <- fromJSON(myjson)
head(Iris2)


# Create data tables 
# data.table()
# inherets from data.frame
# much faster than data.frame
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3),z=rnorm(9))
head(DF,3)
DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3),z=rnorm(9))
head(DT,3)
tables()

#subsetting rows
DT[2,]
DT[DT$y=="a"]
DT[c(2,3)]

#susetting columns
DT[,c(2,3)]
DT[,list(mean(x), sum(z))]
DT[,table(y)] # table of the y values

# add new columns
# :=
DT[,w:=z^2]
# if I change DT I will also change DT2. To avoid that I need to use the copy function
DT2 <- DT
DT[, y:=2]
head(DT, n=3)
head(DT2,n=3)

# multiple operations
# {} : it's an expression
# each statement is followed by a ';'
# 1st statement: assigning to tmp the value of x+z
# 2nd: take the log base 2 of the tmp variable and add 5
# 2nd statement is what is returned (obviously)
DT[,m:={tmp <- (x+z); log2(tmp+5)}]

# plyr like operations
DT[,a:=x>0] # binary variable a!
DT[,b:= mean(x+w), by=a] # mean of all TRUE and all FALSE

# special variables
# .N An integer, length 1, containing the number r
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE)) #1E5 is the size! loads of letters!
DT[, .N, by=x] # it counts the number of time the letters appear
               # by: the same as group by
               # .N: count

# Keys
DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT,x) # quick subsetting: setting the key of DT to the variable x
DT['a'] # it looks in x and subset to the values of x that are equals to a

# Joins
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a','b', 'dt2'), y=5:7)
setkey(DT1, x); setkey(DT2, x) # same key for both DT
merge(DT1, DT2)

# Fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names = TRUE, sep="\t", quote=FALSE)
system.time(fread(file)) # fread is substitute for read.table

system.time(read.table(file, header=TRUE, sep='\t'))






