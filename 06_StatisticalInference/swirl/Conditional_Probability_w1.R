# Swirl
# Statistical Inference
# Conditional Probability

# If you were given a fair die and asked what the probability of rolling a 3 is, 
# what would you reply?
# 1/6

# Suppose the person who gave you the dice rolled it behind your back and told 
# you the roll was odd. Now what is the probability that the roll was a 3?
# 1/3
# The probability of this second event is conditional on this new information, 
# so the probability of rolling a 3 is now one third

# We represent the conditional probability of an event A given that B has 
# occurred with the notation P(A|B). More specifically, we define the 
# conditional probability of event A, given that B has occurred with the following.
# P(A|B) = P(A & B)/ P(B)
# P(A|B) is the probability that BOTH A and B occur divided by the probability that B occurs.

# Back to our dice example. Which of the following expressions represents P(A&B), 
# where A is the event of rolling a 3 and B is the event of the roll being odd?
# P(odd) = 3/6 = 1/2
# P(3) = 1/3    
# Here A is a subset of B so the probability of both A AND B happening is the 
# probability of A happening.
# 1/6

# Continuing with the same dice example. Which of the following expressions 
# represents P(A&B)/P(B), where A is the event of rolling a 3 and B is the event 
# of the roll being odd?
P_A_given_B <- (1/6) / (1/2)

# we can write P(A&B) = P(A|B) * P(B)
# P(B|A) = P(B&A)/P(A) = P(A|B) * P(B)/P(A)
# This is a simple form of Bayes' Rule which relates the two conditional probabilities.

# Suppose we don't know P(A) itself, but only know its conditional probabilities, 
# that is, the probability that it occurs if B occurs and the probability that 
# it occurs if B doesn't occur. These are P(A|B) and P(A|~B), respectively. 
# We use ~B to represent 'not B' or 'B complement'.
# We can then express P(A) = P(A|B) * P(B) + P(A|~B) * P(~B) 
# and substitute this is into the denominator of Bayes' Formula.
# P(B|A) = P(A|B) * P(B) / ( P(A|B) * P(B) + P(A|~B) * P(~B) )

# Suppose we know the accuracy rates of the test for both the positive case 
# (positive result when the patient has HIV) and negative (negative test result 
# when the patient doesn't have HIV). These are referred to as test sensitivity 
# and specificity, respectively.
# Let 'D' be the event that the patient has HIV, and let '+' indicate a positive 
# test result and '-' a negative. What information do we know? 
# Recall that we know the accuracy rates of the HIV test.
# P(+ | D), P(- | ~D)

# Suppose a person gets a positive test result and comes from a population with 
# a HIV prevalence rate of .001. We'd like to know the probability that he really 
# has HIV. Which of the following represents this?
# P(D) = 0.001
# P(D | +)    

# By Bayes' Formula, P(D|+) = P(+|D) * P(D) / ( P(+|D) * P(D) + P(+|~D) * P(~D) )
# We can use the prevalence of HIV in the patient's population as the value for 
# P(D). Note that since P(~D)=1-P(D) and P(+|~D) = 1-P(-|~D) we can calculate 
# P(D|+). In other words, we know values for all the terms on the right side of 
# the equation. 
# Disease prevalence is .001. Test sensitivity (+ result with disease) is 
# 99.7% and specificity (- result without disease) is 98.5%.
P_D_positive <- (0.997 * 0.001) / (0.997 * 0.001 + (1 - 0.985) * (1 - 0.001))
# So the patient has a 6% chance of having HIV given this positive test result. 

# The expression P(D|+) is called the positive predictive value. 
# Similarly, P(~D|-), is called the negative predictive value, the probability 
# that a patient does not have the disease given a negative test result.

# The diagnostic likelihood ratio of a positive test, DLR_+, is the ratio of the 
# two + conditional probabilities, one given the presence of disease and the 
# other given the absence. Specifically, DLR_+ = P(+ | D) / P(+ | ~D). Similarly, the 
# DLR_- is defined as a ratio. Which of the following do you think represents 
# the DLR_-?
# The signs of the test in both the numerator and denominator have to agree as 
# they did for the DLR_+
# DLR_- = P(- | D) / P(- | ~D)

# Recall that P(+|D) and P(-|~D), (test sensitivity and specificity respectively) 
# are accuracy rates of a diagnostic test for the two possible results. They 
# should be close to 1 because no one would take an inaccurate test. 
# Since DLR_+ = P(+|D) / P(+|~D) we recognize the numerator as test sensitivity 
# and the denominator as the complement of test specificity.

# Recall that DLR_- = P(-|D) / P(-|~D). Here the numerator is the complement of 
# sensitivity and the denominator is specificity.

# Recall Bayes Formula. P(D|+) = P(+|D) * P(D) / ( P(+|D) * P(D) + P(+|~D) * P(~D) ) 
# and notice that if we replace all occurrences of 'D' with '~D', the denominator 
# doesn't change. This means that if we formed a ratio of P(D|+) to P(~D|+) 
# we'd get a much simpler expression (since the complicated denominators would 
# cancel each other out).
# P(D|+) / P(~D|+) = P(+|D) * P(D) / (P(+|~D) * P(~D)) = P(+|D)/P(+|~D) * P(D)/P(~D).

# The left side of the equation represents the post-test odds of disease given a 
# positive test result. The equation says that the post-test odds of disease 
# equals the pre-test odds of disease (that is, P(D)/P(~D) ) times
# the DLR_+

# In other words, a DLR_+ value equal to N indicates that the hypothesis of 
# disease is N times more supported by the data than the hypothesis of no disease.

# Taking the formula above and replacing the '+' signs with '-' yields a formula 
# with the DLR_-. Specifically, P(D|-) / P(~D|-) = P(-|D) / P(-|~D) * P(D)/P(~D). 
# As with the positive case, this relates the odds of disease post-test, 
# P(D|-) / P(~D|-), to those of disease pre-test, P(D)/P(~D).
# The equation P(D|-) / P(~D|-) = P(-|D) / P(-|~D) * P(D)/P(~D) says what about 
# the post-test odds of disease relative to the pre-test odds of disease given
#  negative test results?
# DLR_- is small (less than 1). 
# Post-test odds = Pre-test odds * DLR_- so post-test odds are a fraction of the 
# pre-test odds.)
# post-test odds are less than pre-test odds

# Two events, A and B, are independent if they have no effect on each other. 
# Formally, P(A&B) = P(A)*P(B). It's easy to see that if A and B are independent, 
# then P(A|B)=P(A). The definition is similar for random variables X and Y.

# We've seen examples of independence in our previous probability lessons. Let's 
# review a little. What's the probability of rolling a '6' twice in a row using 
# a fair die?
P_six_twice = (1/6) * (1/6)

# You're given a fair die and asked to roll it twice. What's the probability that 
# the second roll of the die matches the first?
P_secind <- 1/6

# If the chance of developing a disease with a genetic or environmental component 
# is p, is the chance of both you and your sibling developing that disease p*p?
# NO, the events arent independent.









