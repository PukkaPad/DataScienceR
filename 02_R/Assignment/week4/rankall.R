# 4. Ranking hospitals in all states

rankall <- function (outcome, num = "best"){
    # find the best hospital in all state for a given outcome
    # as a function of 'outcome' and 'num'
    
    ## Read data
    outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    ## Check that state and outcome are valid   
    if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop("invalid outcome")
    }
    
    # get index
    col_number <- ifelse(outcome == "heart attack", 11, ifelse(outcome == "heart failure", 17, 23))
    # supress warnings
    suppressWarnings(outcome_data[, col_number] <- as.numeric(outcome_data[, col_number]))
    
    ## For each state, find the hospital of the given rank
    
    # get the unique state name
    states <- sort(unique(outcome_data$State))
    
    # order data
    outcome_data <- outcome_data[order(outcome_data$State, 
                                       outcome_data[col_number], outcome_data$Hospital.Name),]

    # create array to for hospital
    hospital <- rep ("", length(states))
    
    for (i in 1:length(states)) {
        # TRUE for outcome_data == "AL", for example
        #print(states[i])
        testData <- outcome_data[outcome_data$State==states[i], ]
        #print (head(testData))
        testDeath <- as.numeric(testData[,col_number])
        
        # best and worst
        if (num =="best"){
            nRank <- 1
        }
        
        else if (num == "worst") {
            nRank <- length(rank(testDeath, na.last=NA))
        }
        else (nRank = num)
        
        hospital[i] <- testData$Hospital.Name[order(testDeath, testData$Hospital.Name)[nRank]]
    }
    
   
    
    # return the hospital that corresponds to the rank
    return ( data.frame (hospital = hospital, state = states))
}

head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)
