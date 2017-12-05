# Generating Random Numbers
# rnorm, dnorm, pnorm, rpois


# Normal distribution
dnorm(x, mean = 0, sd = 1, log = FALSE) # can evaluate the density (log should be set to TRUE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)

x <- rnorm(10)
x
summary(x)


x <- rnorm(10, 20, 2)
summary(x)


set.seed(1)
rnorm(5)


# Poisson distribution
rpois(10, 1) # 10 poisson random variables with a rate of 1 (mean is equal to the rate)
rpois(10, 2) # 10 poisson random variables with a rate of 2
rpois(10, 20)

ppois(2, 2) # Cumulative distribution: probability of poission random variable 
# is less than or equal to 2 if the rate is 2
ppois(4,2)
ppois(6, 2)
