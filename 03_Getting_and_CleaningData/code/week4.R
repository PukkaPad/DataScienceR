# Week 4

## Editing Text Variables
# tolower, toupper, strsplit, sub, gsub, grep, grepl, nchar

if (!file.exists("../data")){dir.create("../data")}
cameraData <- read.table("../data/cameras.csv", sep = ",", header = TRUE)
names(cameraData)

tolower(names(cameraData)) # all names are lower case

splitNames = strsplit(names(cameraData), "\\.") # variables separated by .
splitNames[[5]]
splitNames[[6]]

mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
mylist[1] # subset by 1st element of the list
mylist$letters # subset by the name of the variable
mylist[[1]]# subset by the vector, just taking the 1st element of the list

# fixing character vector - sapply
splitNames[[6]][1]

firstElement <- function(x) {x[1]}
sapply(splitNames, firstElement)

# Peer review data
reviews <- read.csv("../data/reviews.csv")
solutions <- read.csv("../data/solutions.csv")
head(reviews, 2)
head(solutions, 2)
names(reviews) 
sub("_", "", names(reviews))

testName <- "this_is_a_test"
sub("_","",testName)
gsub("_", "", testName)

# finding values
grep("Alameda", cameraData$intersection) # all the intersection that incudes all "alameda"
table(grepl("Alameda", cameraData$intersection)) # returns a vector TRUE when it appears
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),] # subset if alameda doesnt appear

grep("Alameda", cameraData$intersection, value = TRUE) # returns the value where alameda appears

grep("JeffStreet", cameraData$intersection)

length(grep("JeffStreet", cameraData$intersection))

library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1,7)
paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek") # pasting with no space
str_trim("Jeff        ")
