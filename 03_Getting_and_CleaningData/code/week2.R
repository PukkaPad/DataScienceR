# week 2

## mySQL
# install.packages("RMySQL")

# UCSC database
# http://genome.ucsc.edu/
# http://genome.ucsc.edu/goldenPath/help/mysql.html

library(RMySQL)

ucscDb <- dbConnect(MySQL(), user = "genome",
                    host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;")
dbDisconnect(ucscDb)

result

# Connecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(), user="genome", db ="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

# get dimensions of a specific table (affyU133Plus2)
# it will list all the columns names
dbListFields(hg19, "affyU133Plus2")

# to know how many rows
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# read from the table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
# to get only the top 10 data
affyMisSmall <- fetch(query, n=10)
dbClearResult(query)
dim(affyMisSmall)

dbDisconnect(hg19)

## HDF5
# to install in R:
#source("http://bioconductor.org/biocLite.R")
#biocLite("rhdf5")
library(rhdf5)
created = h5createFile("../data/example.h5")
created

# create groups
created = h5createGroup("../data/example.h5", "foo")
created = h5createGroup("../data/example.h5", "baa")
created = h5createGroup("../data/example.h5", "foo/foobaa")
h5ls("../data/example.h5")

# write to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A, "../data/example.h5", "foo/A") # write A, to file example.h5 to the group foo/A
B = array(seq(0.1, 2.0, by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
B
h5write(B, "../data/example.h5", "foo/foobaa/B")
h5ls("../data/example.h5")

# write a data set
df = data.frame(1L:5L, seq(0,1, length.out=5),
                c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
head(df)
h5write(df, "../data/example.h5", "df")
h5ls("../data/example.h5")

# reading data
readA = h5read("../data/example.h5", "df")
readA

readA = h5read("../data/example.h5", "foo/A")
readA

readA = h5read("../data/example.h5", "foo/foobaa/B")
readA

# writing and reading chunks
h5write(c(12, 13, 14), "../data/example.h5", "foo/A", index=list(1:3,1))
h5read( "../data/example.h5", "foo/A")
