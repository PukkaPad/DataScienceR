# Random Sampling
# sample()

set.seed(1)
sample(1:10, 4) # sampling 4 of the 1 to 10
sample(letters, 5)

sample(1:10) # this gives me permutation in random order

sample(1:10, replace=TRUE) # this allows repeated numbers
