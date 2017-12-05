# Simulation
# Each probability distribution in R has an r*** function (for "random"), 
# a d*** function (for "density"), 
# a p*** (for "probability"), and q*** (for "quantile")

# sapmle()
# simulate rolling a 4 six-sided dice
sample(1:6, 4, replace=TRUE)
sample(1:6, 4, replace=TRUE)

# sample 10 numbers between 1 and 20, WITHOUT replacement
sample(1:20, 10)

# permutate letters of the English alphabet
sample(LETTERS)


# Now, suppose we want to simulate 100 flips of an unfair two-sided coin. 
# This particular coin has a 0.3 probability of landing 'tails' 
# and a 0.7 probability of landing 'heads'
# Let the value 0 represent tails and the value 1 represent heads
flips <- sample(c(0,1), 100, replace=TRUE, prob=c(0.3, 0.7))
sum(flips) # number 0f 1 - it should be around 70%

# A coin flip is a binary outcome (0 or 1).
# so we can use rbinom() to simulate a binomial random variable
# A binomial random variable represents the number of 'successes' (heads) 
# in a given number of independent 'trials' (coin flips)
# generate a single random variable that represents the number of heads in 100 flips
# and a 0.7 probability of landing 'heads'
rbinom(1, size = 100, prob = 0.7)
# Equivalently, if we want to see all of the 0s and 1s, we can request 100 observations, each of size 1
flips2 <- rbinom(size = 1, n= 100, prob = 0.7)

# Generate 5 random values from a Poisson distribution with mean 10
rpois(n = 5, lambda  = 10 )
# use replicate to perform the above operation 100 times
my_pois <- replicate(100, rpois(5, 10))
my_pois # replicate() created a matrix, 
        # each column of which contains 5 random numbers generated 
        # from a Poisson distribution with mean 10
# find the mean of each column in my_pois
cm <- colMeans(my_pois)
# check distribution of cm
hist(cm)






