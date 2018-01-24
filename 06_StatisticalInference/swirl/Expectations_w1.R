# Swirl
# Statistical Inference
# Expectations

library(ggplot2)

# The expected value of a random variable X, E(X), is a measure of its central 
# tendency

# For a discrete random variable X with PMF p(x), E(X) is defined as a sum, 
# over all possible values x, of the quantity x*p(x). E(X) represents the center 
# of mass of a collection of locations and weights, {x, p(x)}.

# Consider the random variable X representing a roll of a fair dice. 
# By 'fair' we mean all the sides are equally likely to appear.
# What is the expected value of X?
p <- 1/6
Expected_dice <- 1 * p + 2 * p + 3 * p + 4 * p + 5 * p + 6 * p

dice_fair <- c(1/6,1/6,1/6,1/6,1/6,1/6)
sum(c(1:6) * dice_fair)

# We've defined a function for you, expect_dice, which takes a PMF as an input. 
# For our purposes, the PMF is a 6-long array of fractions. The i-th entry in 
# the array represents the probability of i being the outcome of a dice roll. 
expect_dice <- function(pmf){ mu <- 0; for (i in 1:6) mu <- mu + i*pmf[i]; mu}
# We've also defined PMFs for three dice, dice_fair, dice_high and dice_low. 
# The last two are loaded, that is, not fair. 
dice_fair <- c(1/6,1/6,1/6,1/6,1/6,1/6)
dice_high <- c(1/21,2/21,3/21,4/21,5/21,6/21)
dice_low <- c(6/21,5/21,4/21,3/21,2/21,1/21)

# Using the function expect_dice with dice_high as its argument, calculate the 
# expected value of a roll of dice_high.
expect_dice(dice_high)

# See how the expected value of dice_high is higher than that of the fair dice. 
# Now calculate the expected value of a roll of dice_low.
expect_dice(dice_low)

# You can see the effect of loading the dice on the expectations of the rolls. 
# For high-loaded dice the expected value of a roll (on average) is 4.33 and for 
# low-loaded dice 2.67. We've stored these off for you in two variables, edh and edl
edh <- expect_dice(dice_high)
edl <- expect_dice(dice_low)

# One of the nice properties of the expected value operation is that it's linear. 
# This means that, if c is a constant, then E(cX) = c*E(X). Also, if X and Y are 
# two random variables then E(X+Y)=E(X)+E(Y). It follows that E(aX+bY)=aE(X)+bE(Y).

# Suppose you were rolling our two loaded dice, dice_high and dice_low. 
# You can use this linearity property of expectation to compute the expected value 
# of their average. Let X_hi and X_lo represent the respective outcomes of the 
# dice roll. The expected value of the average is 
# E((X_hi + X_lo)/2) or .5 *( E(X_hi)+E(X_lo) ). 
e<- 0.5 * (edh + edl)
# The dice were loaded in opposite ways so their average should be fair

# For a continuous random variable X, the expected value is defined analogously 
# as it was for the discrete case. Instead of summing over discrete values, 
# however, the expectation integrates over a continuous function.
# It follows that for continuous random variables, E(X) is the area under the 
# function t*f(t), where f(t) is the PDF (probability density function) of X. 
# This definition borrows from the definition of center of mass of a continuous body.
# Here's a figure from the slides. It shows the constant (1) PDF on the left 
# and the graph of t*f(t) on the right.
par(mfrow = c(1, 2))
plot(c(-0.25, 0, 0, 1, 1, 1.25), c(0, 0, 1, 1, 0, 0), type = "l", lwd = 3, frame = FALSE, xlab="", ylab = ""); title('f(t)')
plot(c(-0.25, 0, 1, 1, 1.25), c(0, 0, 1, 0, 0), type = "l", lwd = 3, frame = FALSE, xlab="", ylab = ""); title('t f(t)')

# Knowing that the expected value is the area under the triangle, t*f(t), 
# what is the expected value of the random variable with this PDF?
# 0.5

# For the purposes of illustration, here's another figure using a PDF from our 
# previous probability lesson. It shows the triangular PDF f(t) on the left and 
# the parabolic t*f(t) on the right. The area under the parabola between 0 and 2 
# represents the expected value of the random variable with this PDF.
par(mfrow = c(1, 2))
plot(c(-0.25, 0, 2, 2, 2.25), c(0, 0, 1, 0, 0), type = "l", lwd = 3, frame = FALSE, xlab="", ylab = ""); title('f(t)')
my_x <- seq(0,2,by=.1)
my_y <- my_x^2/2
plot(my_y ~ my_x, type = "l", lwd = 3, frame = FALSE, xlab="", ylab = ""); title('t f(t)')
abline(v=2.0, lwd=3)

# To find the expected value of this random variable you need to integrate the 
# function t*f(t). Here f(t)=t/2, the diagonal line. (You might recall this from 
# the last probability lesson.) The function you're integrating over is therefore 
# t^2/2. We've defined a function myfunc for you representing this. You can use 
# the R function 'integrate' with parameters myfunc, 0 (the lower bound), and 2
# (the upper bound) to find the expected value.
myfunc <- function(x){x^2/2}
integrate(myfunc, 0, 2)

# As all the examples have shown, expected values of distributions are useful in 
# characterizing them. The mean characterizes the central tendency of the 
# distribution. However, often populations are too big to measure, so we have to 
# sample them and then we have to use sample means. That's okay because sample 
# expected values estimate the population versions. We'll show this first with 
# a very simple toy and then with some simple equations.

# We've defined a small population of 5 numbers for you, spop.
spop <- c(1,4,7,10,13)
mean(spop)

# Suppose spop were much bigger and we couldn't measure its mean directly and 
# instead had to sample it with samples of size 2. There are 10 such samples, 
# right? We've stored this for you in a 10 x 2 matrix, allsam. 
sam0 <- c(1,4)
sam1 <- c(1,7)
sam2 <- c(1,10)
sam3 <- c(1,13)
sam4 <- c(4,7)
sam5 <- c(4,10)
sam6 <- c(4,13)
sam7 <- c(7,10)
sam8 <- c(7,13)
sam9 <- c(10,13)
allsam <- matrix(c(sam0,sam1,sam2,sam3,sam4,sam5,sam6,sam7,sam8,sam9),nrow=10,ncol=2,byrow=TRUE)
allsam
# Each of these 10 samples will have a mean
# We can use the R function apply to calculate the mean of each row of the 
# matrix allsam
smeans <- apply(allsam,1,mean) # the second argument, 1, tells 'apply' to apply the third
                               # argument 'mean' to the rows of the matrix
smeans
# You can see from the resulting vector that the sample means vary a lot, 
# from 2.5 to 11.5
mean(smeans)
# The result is the same as the mean of the original population spop. This is not 
# because the example was specially cooked. It would work on any population. 
# The expected value or mean of the sample mean is the population mean. 
# What this means is that the sample mean is an unbiased estimator of the 
# population mean.

# Formally, an estimator e of some parameter v is unbiased if its expected value 
# equals v, i.e., E(e)=v. 

# Here's another figure from the slides. It shows how a sample mean and the mean 
# of averages spike together. The two shaded distributions come from the same 
# data. The blue portion represents the density function of randomly generated 
# standard normal data, 100000 samples. The pink portion represents the density 
# function of 10000 averages, each of 10 random normals. (The original data was 
# stored in a 10000 x 10 array and the average of each row was taken to generate 
# the pink data.)
nosim <- 10000; n <- 10
dat <- data.frame(
    x = c(rnorm(nosim), apply(matrix(rnorm(nosim * n), nosim), 1, mean)),
    what = factor(rep(c("Obs", "Mean"), c(nosim, nosim))) 
)
np <- ggplot(dat, aes(x = x, fill = what)) + geom_density(size = 2, alpha = .2); 
print(np)

# Here's another figure from the slides. Rolling a single die 10000 times yields 
# the first figure. Each of the 6 possible outcomes appears with about the same 
# frequency. The second figure is the histogram of outcomes of the average of 
# rolling two dice. Similarly, the third figure is the histogram of averages of 
# rolling three dice, and the fourth four dice. As we showed previously, the 
# center or mean of the original distribution is 3.5 and that's exactly where 
# all the panels are centered.
dat <- data.frame(
    x = c(sample(1 : 6, nosim, replace = TRUE),
          apply(matrix(sample(1 : 6, nosim * 2, replace = TRUE), 
                       nosim), 1, mean),
          apply(matrix(sample(1 : 6, nosim * 3, replace = TRUE), 
                       nosim), 1, mean),
          apply(matrix(sample(1 : 6, nosim * 4, replace = TRUE), 
                       nosim), 1, mean)
    ),
    size = factor(rep(1 : 4, rep(nosim, 4))))
g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(alpha = .20, binwidth=.25, colour = "black") 
g <- g + facet_grid(. ~ size)
print(g)

# Let's recap. Expected values are properties of distributions. The average, or 
# mean, of random variables is itself a random variable and its associated 
# distribution itself has an expected value. The center of this distribution is 
# the same as that of the original distribution.

# Expected values are properties of what?
# distributions

# A population mean is a center of mass of what?
# a population

# A sample mean is a center of mass of what?
# observed data

# True or False? A population mean estimates a sample mean.
# False

# True or False? A sample mean is unbiased. 
# (The sample mean is the population mean, so by definition it's unbiased.)
# True

# True or False? The more data that goes into the sample mean, the more 
# concentrated its density / mass function is around the population mean.
# True























































































