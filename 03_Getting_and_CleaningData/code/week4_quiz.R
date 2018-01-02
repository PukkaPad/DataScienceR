# Quiz Week 4

packages <- c("data.table", "quantmod")
sapply(packages, require, character.only = TRUE, quietly = TRUE)

# 1. The American Community Survey distributes downloadable data about United States 
# communities. Download the 2006 microdata survey about housing for the state of 
# Idaho using download.file() from here:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
    
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?

if (!file.exists("../data")){dir.create("../data")}
fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "../data/Idaho.csv", method = "curl")

idaho <- reviews <- read.csv("../data/Idaho.csv")
var <- names(idaho)
variableSplit <- strsplit(var, "wgtp")
variableSplit[[123]]

# 2. Load the Gross Domestic Product data for the 190 ranked countries in this 
# data set:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average?
    
# Original data sources:
    
# http://data.worldbank.org/data-catalog/GDP-ranking-table

if (!file.exists("../data")){dir.create("../data")}
fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileURL, destfile = "../data/GDP190.csv", method = "curl")

gdp <- reviews <- data.table(read.csv("../data/GDP190.csv", 
                                      skip = 4, nrows = 215, stringsAsFactors = F))
gdp <- gdp[X != ""]
gdp <- gdp[, list(X, X.1, X.3, X.4)]
names (gdp)
setnames(gdp, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "GDP"))
gdpOnly <- as.numeric(gsub(",", "", gdp$GDP))
gdpOnly
meanGDP <- mean(gdpOnly, na.rm =T)
meanGDP

# 3. In the data set from Question 2 what is a regular expression that would allow 
# you to count the number of countries whose name begins with "United"? Assume 
# that the variable with the country names in it is named countryNames. How many 
# countries begin with United?
united <- grepl("^United", gdp$Long.Name)
summary(united)


# 4. Load the Gross Domestic Product data for the 190 ranked countries in this data set:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

# Load the educational data from this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Match the data based on the country shortcode. 
# Of the countries for which the end of the fiscal year is available, how many 
# end in June?
    
#    Original data sources:
    
#    http://data.worldbank.org/data-catalog/GDP-ranking-table

# http://data.worldbank.org/data-catalog/ed-stats

fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileURL, destfile = "../data/education.csv", method = "curl")

edu <- reviews <- data.table(read.csv("../data/education.csv"))

dataframe <- merge(gdp, edu, all = T, by = c("CountryCode"))

fiscalYear <- grepl("fiscal year end: june", tolower(dataframe$Special.Notes))
table(fiscalYear)


# 5. You can use the quantmod (http://www.quantmod.com/) package to get historical 
# stock prices for publicly traded companies on the NASDAQ and NYSE. Use the 
# following code to download data on Amazon's stock price and get the times the 
# data was sampled.

# library(quantmod)
# amzn = getSymbols("AMZN",auto.assign=FALSE)
# sampleTimes = index(amzn)

# How many values were collected in 2012? How many values were collected on 
# Mondays in 2012?

#install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

#timeDT <- data.table::data.table(timeCol = sampleTimes)
timeDF <- index(amzn)
addmargins(table(year(timeDF), weekdays(timeDF)))
