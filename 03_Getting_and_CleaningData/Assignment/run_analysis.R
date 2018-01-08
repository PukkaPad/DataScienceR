# Peer-graded Assignment: Getting and Cleaning Data Course Project

# setwd("Assignment")
library(data.table)

# create data directory, download data and unzip it
if (!file.exists("./data")){dir.create("./data")}
fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/SGalaxy.zip", method = "curl")
dateDownloaded <- date()
dateDownloaded

unzip("./data/SGalaxy.zip")

# read all train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# read all test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
Subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# read data description
variable_names <- read.table("./UCI HAR Dataset/features.txt")

# read activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merge the training and the test sets to create one data set.
X_all <- rbind(X_train, X_test)
Y_all <- rbind(Y_train, Y_test)
Subj_all <- rbind(Subj_train, Subj_test)

# Extract only the mean and standard deviation for each measurement.
selected_var <- variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
X_all <- X_all[,selected_var[,1]]

# Name the activities in the data set
colnames(Y_all) <- "activity"
Y_all$activitylabel <- factor(Y_all$activity, 
                              labels = as.character(activity_labels[,2]))
activitylabel <- Y_all[,-1]

# Label data set with descriptive variable names.
colnames(X_all) <- variable_names[selected_var[,1],2]

# From the data set above, create the tidy data set with the average
# of each variable for each activity and each subject.
colnames(Subj_all) <- "subject"
total <- cbind(X_all, activitylabel, Subj_all)
library(magrittr)
library(dplyr)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "./UCI HAR Dataset/tidy.txt", row.names = FALSE, col.names = TRUE)
