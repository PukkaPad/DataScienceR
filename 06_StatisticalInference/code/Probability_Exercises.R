# Statistical Inference
# Probability

# Exercises
# 1. Can you add the probabilities of any two events to get the probability of 
# at least one occurring?

# Only if they are not mutually exclusive, i.e., they cannot simultaneously occur.
# If they are mutually exclusive, then the probability is given by P(A or B) = P(A) + P(B)
# If they are not mutually exclusive, the probability then is given by
# P(A or B) = P(A) + P(B) - P(A and B)
# Note that:
# or  = union
# and = intersection

# 2. I define a PMF, p so that for x = 0 and x=1 we have p(0) = -0.1 and p(1) = 1.1. 
# Is this a valid PMF?

# No. To be a valid pmf, a function p must always be larger than or equal to 0.

# 3.What is the probability that 75% or fewer calls get answered in a randomly 
# sampled day from the population distribution from this chapter?
pbeta(0.75, 2, 1) # 56%

# 4.The 97.5th percentile of a distribution is?

# It means that 97.5% of the population are below it and 2.5% above.

# 5. Consider influenza epidemics for two parent heterosexual families. 
# Suppose that the probability is 15% that at least one of the parents has 
# contracted the disease. The probability that the father has contracted 
# influenza is 10% while that the mother contracted the disease is 9%. What is 
# the probability that both contracted influenza expressed as a whole number 
# percentage? 

# P(A or B) = 15%
# P(A) = 10%
# P(B) = 9%
# P(A and B) = ?
# P(A or B) = P(A) + P(B) - P(A and B)
# 0.15 = 0.1 + 0.09 - P(A and B)
# P(A and B) = 0.04 = 4%

# 6. A random variable, X, is uniform, a box from 0 to 1 of height 1. 
# (So that it’s density is f(x) = 1 for 0 < = x <= 1.) What is it’s median 
# expressed to two decimal places? 

x <- c(0, 1, 1, 1, 1, 0, 0)
y <- c(0, 0, 1, 0, 1, 1, 0)
plot(x, y, lwd = 3, frame = FALSE, type = "l")

# area = 1
# 0.50  

