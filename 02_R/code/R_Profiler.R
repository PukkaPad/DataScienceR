# Profiling R Code
# Rprof(), system.time()
# do not use system.time() and Rprof() together!!!!

# user time: time the computer experiences
# elapsed time: time I experience
# they are usually close

# if elapse time > user time: CPU spends a lot of time waiting around
# if elapsed time < user time: machine has multiple cores/processors

#system.time()

# Elapsed time > user time
# reading off a remote server
system.time(readLines("https://www.jhsph.edu/index.html"))

# Elapsed time < user time
hilbert <- function(n) {
    i <- 1:n
    1 / outer(i - 1, i , "+")
}

# svd = singular time decomposition
x <- hilbert(1000)
system.time(svd(x))


# timing longer expressions
system.time({
    n <- 1000
    r <- numeric(n)
    for (i in 1:n) {
        x <- rnorm(n)
        r[i] <- mean(x)
        }
})

# summaryRprof()
# by.total: divides time spend in each function by the total run time
# by.self: same, but it will frist substract out time spent in functions bove in the call stack