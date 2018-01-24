# Statistical Inference
# Probability

# Example of Implementing Probability Calculus

# The National Sleep Foundation (www.sleepfoundation.org) reports that around 3% 
# of the American population has sleep apnea. They also report that around 10% 
# of the North American and European population has restless leg syndrome. 
# Does this imply that 13% of people will have at least one sleep problems of 
# these sorts? In other words, can we simply add these two probabilities?

# Answer: No, the events can simultaneosly occur and so they are not mutually exclusive
# Events that cannot simultaneously occur are mutually exclusive and the probability
# of at least one of the 2 occuring is given by the sum of their respective propabilities
# So:
# A1 = {sleep apnea}
# A2 = {RLS}
# P(A1 U A2) = P(A1) + P(A2) - P(A1  intersection A2)
# = 0.13 - Probability of having both

# Probability density functions
# Suppose that the proportion of help calls that get addressed in a random day 
# by a help line is given by f(x) = 2 x  for 1 > x > 0 , 0 otherwise
x <- c(-0.5, 0, 1, 1, 1.5)
y <- c(0, 0, 2, 0, 0)
plot(x, y, lwd = 3, frame = FALSE, type = "l")
# is this a valid pdf?
# Conditions are:
# 1. It must be larger or equal to zero anywhere
# 2. The total area under it must be one
# Checking:
# 1. All positive - ok
# 2. area = (base * height) / 2 = 1 - ok

# What's the probability that 75% or fewer calls get addressed?
plot(x, y, lwd = 3, frame = FALSE, type = "l")
polygon(c(0, .75, .75, 0), c(0, 0, 1.5, 0), lwd = 3, col = "lightblue")
# area = (0.75 * 1.5) / 2 = 0.5625
pbeta(0.75, 2, 1) # beta distribution

# CFD and survival function
# CDF is the probability that the random variable'X' is less than or equal to 'x'.
# the distribution function can then be writen:
# F(x) = P(X < = x)
# The survival function of a random variable 'X' is the probability that the
# random variable is greater than 'x'.
# S(x) = P(X > x)
# S(x) = 1 - F(x)
# From the previous example:
# F(x) = P(X < = x) = (x * 2x) /2 = x^2
# The survival function:
# S(x) = 1 - x^2
# What would be the values for F(0.4), F(0.5) and F(0.6)?
# F(0.4) = 0.4 * 0.8 / 2 = 0.16
# F(0.5) = 0.5 * 1 / 2 = 0.25
# F(0.6) = 0.6 * 1.2 / 2 = 0.36
plot(x, y, lwd = 3, frame = FALSE, type = "l")
polygon(c(0, .6, .6, 0), c(0, 0, 1.2, 0), lwd = 3, col = "white")
polygon(c(0, .5, .5, 0), c(0, 0, 1, 0), lwd = 3, col = "lightgreen")
polygon(c(0, .4, .4, 0), c(0, 0, 0.8, 0), lwd = 3, col = "yellow")

pbeta(c(0.4, 0.5, 0.6), 2, 1)
pbeta(c(0.4, 0.5, 0.6), 2, 1, lower.tail = FALSE) # for survival function

# Quantiles
# What is the median of the distribution of the example below:
plot(x, y, lwd = 3, frame = FALSE, type = "l")
# area = 0.5
# 0.5 = F(x) = x^ 2
# median = sqrt(0.5) = 0.707
# 50% of the days, 70% of the calls, or fewer get answer. 
# And 50% of the 70% of the calls or more get answered
qbeta(0.5, 2, 1)
