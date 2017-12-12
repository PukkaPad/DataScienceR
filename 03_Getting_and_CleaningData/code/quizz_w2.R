# quiz week2


library(httr)
library(RJSONIO)
library(data.table)
#install.packages("sqldf")
library(sqldf)
# 1
# 
# Register an application with the Github API here:
#     
#     https://github.com/settings/applications.
# Access the API to get information on your instructors repositories, hint: this is the url you want:
#     
#     https://api.github.com/users/jtleek/repos
# Use this data to find the time that the datasharing repo was created. What time was it created?
#     
#     This tutorial may be useful:
#     
#     https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
# You may also need to run the code in the base R package and not R studio.

# Find OAuth settings for github:
# http://developer.github.com/v3/oauth/


# 2
# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.

# Download the American Community Survey data and load it into an R object called

# acs

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "../data/acs.csv", method = "curl") # method curl is necessary because of MAC
list.files("../data")
dateDownloaded <- date()
dateDownloaded

acs <-  data.table (read.csv("../data/acs.csv", sep = ",", header = TRUE))
head(acs)
detach("package:RMySQL", unload=TRUE) # need to load the RMySQL library when using sqldf, 
                                      # since I have already read the data into memory
q1 <- sqldf("select pwgtp1 from acs where AGEP < 50")

# 3
# Using the same data frame you created in the previous problem, 
# what is the equivalent function to unique(acs$AGEP)
q2 <- unique(acs$AGEP)

test1 <- sqldf("select distinct pwgtp1 from acs")

ans = identical(q2, test1)
ans

test2 <- sqldf("select distinct AGEP from acs")

ans = identical(q2, test2)
ans

test3 <- sqldf("select unique AGEP from acs")
ans = identical(q2, test3)
ans


# Question 4
# 
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
#     
#     http://biostat.jhsph.edu/~jleek/contact.html
# 
# (Hint: the nchar() function in R may be helpful)
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

# Question 5
# 
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# 
# (Hint this is a fixed width file format)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n = 10)
# val width for each column.
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
# space = filler
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])
