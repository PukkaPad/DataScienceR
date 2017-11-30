## lapply
# applies a function to a list (or something coerced to a list)
# it returns a list

x <- list (a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- list (a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

x<- 1:4
lapply(x, runif)

x<- 1:4
lapply(x, runif, min = 0, max = 10)

# makes heavy use of anonymous functions
x<- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
lapply(x, function(elt) elt[,1])

## sapply
# simplies the results of lapply if possible

x <- list (a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
sapply(x, mean)
mean(x)


## apply
# evaluates a function over the margins of an array
# involves less typing
# 1st argument is an array (vector with dimension)
# 2nd is margin
# 3rd is a function

x <- matrix(rnorm(200), 20, 10) # 20 rows, 10 columns
apply (x, 2, mean) # eliminates the 1st dimension (rows), preserves the 2nd
apply(x, 1, sum) # preserves all the rows, collapse the columns

# to compute columns/rows sums and means
rowSum = apply(x, 1, sum)
rowMean = apply(x, 1, mean)
colSum = apply(x, 2, sum)
colMean = apply(x, 2, mean)

# to compute 25 and 75 percentile of row
x <- matrix(rnorm(200), 20, 10) 
apply (x, 1, quantile, probs = c(0.25, 0.75))

# average 2x2 matrix
a <- array (rnorm (2 * 2 * 10), c(2,2,10))
apply(a, c(1,2), mean)
rowMeans(a, dims = 2 )


## mapply
# multivariate apply
# applies a function in parallel over a set of args

mapply(rep, 1:4, 4:1) # it will crete a list that will repeat 1 4 times, 2 3 times, 3 2 times and 4 once

noise <- function (n, mean, sd) {
    rnorm(n, mean, sd)
}
noise(5, 1, 2)
noise(1:5, 1:5, 2) # doesnt work as expected. so:
mapply(noise, 1:5, 1:5, 2)

## tapply
# used to apply a function over subsets of a vector

x<- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
tapply(x, f, range)


## split
# takes a vector or other objects and splits it into groups determined by a factor or a list of factors
# always returns a list
x<- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
split(x, f)

# it's common to use lapply with split
lapply(split(x, f), mean)

# can be used to split a dataframe
library(datasets)
head(airquality)
# mean of ozone in each month:
# split the df into monthly pieces
s <- split(airquality, airquality$Month) # split air quality by month
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) # add the numbers to a matrix
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))

# splitting i=on more than one level
x <- rnorm(10)
f1 <- gl(2, 5) # 2 levels repeated 5 times 
f2 <- gl(5, 2) # 
f1
interaction(f1, f2)
str(split(x, list(f1, f2))) # list function automatically calls the interaction function
str(split(x, list(f1, f2), drop = TRUE)) # drops empty levels