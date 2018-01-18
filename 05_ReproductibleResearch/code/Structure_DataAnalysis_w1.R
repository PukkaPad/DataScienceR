# Reproducible Research
# Structure of a Data Analysis
# Week 1

# http://search.r-project.org/library/kernlab/html/spam.html


## Can I automatically detect email that are SPAM or not?

library(kernlab)
data(spam)
str(spam[, 1:5])

# Perform the subsampling
set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5) # probability of 0.5 will 
                                                    # separate the dataset in 2 pieces
table(trainIndicator)

trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

# 1) Exploratory data analysis:
# Look at summaries of the data
# Check for missing data
# Create exploratory plots
# Perform exploratory analyses

names(trainSpam)
head(trainSpam) # each row shows the frequency the word (column name) occur in a 
                # given email

table(trainSpam$type) 
# 1381 are classifed as spam

plot(trainSpam$capitalAve ~ trainSpam$type)
# data is highly skewed. It might be easier to look at the log
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type)
# + 1 because there are a lot of zeros, and log 0 is not a real number
# spam has higher rate of capital letters

plot(log10(trainSpam[ , 1:4] + 1)) # some are not correlated

hCluster = hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)

hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)

# 2) Statistical prediction/modelling
trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x, y) sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)
for (i in 1:55){
    lmFormula = reformulate(names(trainSpam)[i], response= "numType")
    glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
    cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

# which predictor with minimum cross-validated error?
names(trainSpam)[which.min(cvError)]

# get a measure of uncertainty
# use the best model from the group
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)
# get predictions on the test set
predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonspam", dim(testSpam)[1])
# classify as 'spam' for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] = "spam"
# classification table
table(predictedSpam, testSpam$type)
# error table
(61 + 458) / (1346 + 458 + 61 + 449)

# 3) Interpret results
# a fraction of characters that are dollar sign can be used to predict if an email is Spam
# more $ = more Spam
# error rate of test set was 22.4%


