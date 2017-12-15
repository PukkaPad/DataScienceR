# Week 3 - quiz

# 1) The American Community Survey distributes downloadable data 
# about United States communities. Download the 2006 microdata survey about 
# housing for the state of Idaho using download.file() and load the data into R
# The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

# Create a logical vector that identifies the households on greater than 
# 10 acres who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame 
# where the logical vector is TRUE.

# which(agricultureLogical)

# What are the first 3 values that result?
    
library(dplyr)

URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file (url = URL, destfile = "../data/IdahoHousing.csv", method = "curl")
dateDownloaded <- date()
dateDownloaded

idaho <- read.csv("../data/IdahoHousing.csv")
head(idaho)

agricultureLogical <- (idaho$ACR == 3 & idaho$AGS == 6)
View(agricultureLogical)    

which(agricultureLogical)[1:3]


# 2) Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of 
# the resulting data? (some Linux systems may produce an answer 638 different 
# for the 30th quantile)

library(jpeg)

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url = URL, destfile = "../data/jpegImage.jpg",
              method = "curl", mode = "wb")
dateDownloaded <- date()
dateDownloaded

loadImg <- readJPEG("../data/jpegImage.jpg", native =TRUE)

quantile(loadImg, probs = c(0.3, 0.8))


# 3) Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

URL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
URL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(url = URL1, destfile = "../data/gdp.csv")
download.file(url = URL2, destfile = "../data/eductionalData.csv")

gdp <- read.csv("../data/gdp.csv")
edu <- read.csv("../data/eductionalData.csv")

dim(gdp)
head(gdp)
tail(gdp, 100)
gdp <- read.csv("../data/gdp.csv", skip = 4, nrows = 215)
head(gdp)
tail(gdp)


library(data.table)
gdp <- gdp[, c("X", "X.1", "X.3", "X.4")]
names(gdp)
setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
names(gdp)

names(edu)

finalDF <- merge(gdp, edu, by.x = "CountryCode", by.y = "CountryCode", all = TRUE)

sum(!is.na(unique(finalDF$CountryCode)))
sum(!is.na(unique(finalDF$rankingGDP)))
finalDF[order("rankingGDP", decreasing = TRUE)]
top_unique_sorted <- arrange(finalDF, desc(rankingGDP))
top_unique_sorted[13, 1: 3]


# 4) What is the average GDP ranking for the "High income: OECD" and 
# "High income: nonOECD" group?

# OECDnonOECD <- filter(top_unique_sorted, 
#                       Income.Group =="High income: OECD" | Income.Group== "High income: nonOECD")
# OECDnonOECD[, mean(rankingGDP, na.rm = TRUE)]

mean(subset(top_unique_sorted, Income.Group %in% "High income: OECD", 
            select = c(rankingGDP))$rankingGDP, na.rm = TRUE)

mean(subset(top_unique_sorted, Income.Group %in% "High income: nonOECD", 
            select = c(rankingGDP))$rankingGDP, na.rm = TRUE)


# 5) Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. How many countries are Lower middle income 
# but among the 38 nations with highest GDP?

library(Hmisc)
top_unique_sorted$rankingGDP = cut2(top_unique_sorted$rankingGDP, g = 5)
table(top_unique_sorted$Income.Group, top_unique_sorted$rankingGDP)
