# 2. Finding the best hospital in a state

best <- function (state, outcome) {
    # find the best hospital in a state with a given rank
    # as a function of 'state', 'outcome' and 'num'
    
    ## read data
    outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = 'character')
    
    ## Check state and outcome are valid
    
    # get states
    # create the factor variable
    # get the levels
    states <- levels(factor(outcome_data$State))
    
    # get the outcome
    # upon reading "Hospital_REvised_Flatfiles.pdf"
    # "day risk-adjusted mortality and readmission measures for 
    # heart attack, heart failure and pneumonia (...)." 
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    # stop if state input does not exist in the data frame
    # trow an error message
    if ((state %in% states) == FALSE) {
        stop("invalid state")
        }
     
    # stop if outcome input does not exist in the data frame
    # trow an error message 
    if ((outcome %in% outcomes) == FALSE) {
        stop("invalid outcome")
    } 
    

    ## Return hospital name in that state with lowest 30-day death rate
    
    # define columns for each outcome
    # the number of each column is know by inspecting the data
    col_number <- if (outcome == "heart attack"){
        col_number <- 11
    }
    else if (outcome == "heart failure") {
        col_number <- 17
    }
    else {col_number <- 23}
    col_number
    
    # subset the data on the state input
    subsetData <- subset(outcome_data, State == state)
    # outcome input in numeric
    subsetData [, col_number] <- suppressWarnings(as.numeric(subsetData[,col_number]))
    subsetData <- subsetData[order (subsetData [,col_number], na.last = TRUE), ]
    subsetData <- na.omit(subsetData)
    #print (head(subsetData))
    #print (tail(subsetData))
    #print(dim(subsetData))
     
    # get the position of the min for the outcome
    minval <- as.numeric(min(subsetData[,col_number], na.rm = TRUE))
    # #print (minval)
    # get the row number for the min
    idx <- which (grepl(minval, subsetData[,col_number]))
    # #print (idx)
    # # it might print move than one
    hospitals <- subsetData[idx, 2]
    hospitlas <- sort(hospitals)
    #print (str(hospitals))
    # stop printing Levels info
    return (levels(factor(hospitals[1])))
}

#source("best.R")
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")
