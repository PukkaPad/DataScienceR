# 3. Ranking hospitals by outcome in a state

rankhospital <- function (state, outcome, num = 'best'){
    
    ## read data
    outcome_data <- read.csv("outcome-of-care-measures.csv")
    
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
    
    # retun NA if num is greater than number of hospital in the location
    if (is.numeric(num) == TRUE) {
        if (length(outcome_data[,2]) < num) {
            return(NA)}
    }
    
    ## Return hospital name in that state with the given rank
    
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

    # outcome input is numeric
    subsetData[,col_number] <- as.numeric(as.character(subsetData[, col_number]))
    
    # hospital name is character
    subsetData[,2] <- as.character(subsetData[, 2])
    
    # order the subset
    rankedData <- subsetData[order(subsetData[, col_number], subsetData[,2], na.last = TRUE), ]
    rankedData <- rankedData[!is.na(rankedData[,col_number]), ]
    # best and worst
    if (num =="best"){
        nRank <- 1
    }
    
    else if (num == "worst") {
        nRank <- nrow(rankedData)
    }
    else (nRank = num)
    
    # return the hospital that corresponds to the rank
    return (rankedData[nRank, 2])
    
}

#source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)
