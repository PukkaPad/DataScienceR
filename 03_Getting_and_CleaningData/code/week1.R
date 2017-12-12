# week 1 

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "../data/quiz_week1.csv", method = "curl") # method curl is necessary because of MAC
list.files("../data")
dateDownloaded <- date()
dateDownloaded

surveyData <- data.table (read.csv("../data/quiz_week1.csv", sep = ",", header = TRUE))

# 1.
#Code book says VAL with 24 represents any house more than $1000000.
surveyData[, .N, by=VAL]

# 2.

# 3. 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "../data/q3_week1.xlsx", method = "curl") # method curl is necessary because of MAC
list.files("../data")
dateDownloaded <- date()
dateDownloaded

library(openxlsx)
NGP <- read.xlsx("../data/q3_week1.xlsx", sheet = 1, rows = 18:23, cols = 7:15)
head(cameraData)
sum(NGP$Zip*NGP$Ext,na.rm=T)

# 4. 
library(XML)
library(bitops)
library(RCurl)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xData <- getURL(fileUrl)
doc <- xmlParse(xData)
rootNode <- xmlRoot(doc)
length((xpathSApply(rootNode, "//zipcode[text()='21231']", xmlValue)))


# 5.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "../data/q5.csv", method = "curl")
library(data.table)
DT <- fread("../data/q5.csv", sep = ",")

system.time(DT[,mean(pwgtp15),by=SEX])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15))  
system.time(mean(DT[DT$SEX==2,]$pwgtp15))