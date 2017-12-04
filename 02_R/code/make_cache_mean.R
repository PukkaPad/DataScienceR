## A pair of functions that cache the mean of a vector.

dir = getwd()
wd = file.path("Code","onlineCourses", "Coursera", "DataScience", "02_R", "Assignment", "week3")
setwd(file.path(dir, wd))

makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() 
        x
    setmean <- function(mean) 
        m <<- mean
    getmean <- function() 
        m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}


cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}

a <- makeVector(c(1,2,3,4))
a$get()
a$list # will return NULL
a$getmean() # will return NULL
# to compute the mean:
cachemean(a)
a$getmean() # the mean has been stored
a$set(c(10, 20, 30, 40))
a$getmean() # will return NULL
a$get() # a has changed
a$getmean() # will return NULL
cachemean(a)
