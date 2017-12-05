setwd("../../Assignment/week4")

outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
names(outcome)

# 1 . histogram of the 30-day death rates from heart attack (column 11)
hist(as.numeric(outcome[,11]), xlab = "Heart Attack Death", 
     main = "Histogram of the 30-day death rates from heart attack")

# 2. Finding the best hospital in a state
# see best.R

# 3. Ranking hospitals by outcome in a state
# see rankhospital.R

# 4. Ranking hospitals in all states
# see rankall.R