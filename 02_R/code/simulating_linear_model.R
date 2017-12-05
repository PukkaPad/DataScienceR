# Generating Random Numbers From a Linear Model

set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2) # random noise
y <- 0.5 + 2 * x + e
summary (y)
plot(x, y)


# what if x is binary?
set.seed(10)
x <- rbinom(100, 1, 0.5) # binomial distribution 
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary (y)
plot(x, y)

# Count variables instead of coninuos variables
# Poisson model where:
# Y ~ Poisson(mu)
# log mu = intercept + slope * x
# intercept = 0.5, slope = 0.3
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)
