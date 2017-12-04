# A pair of functions that cache the inverse of a matrix.


## This function creates a matrix object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
    
    # it will:
    # 1. set the matrix
    # 2. get the matrix
    # 3. set the inverse of the matrix
    # 4. get the inverse of the matrix
    
    inverse_matrix <- NULL
    set <- function(new_matrix) {
        # it will assign new_matrix to x
        # << is used because x is in a different environment
        x <<- new_matrix
        inverse_matrix <<- NULL
    }
    get <- function() {
        x
    }
    setinverse <- function(inverse) 
        inverse_matrix <<- inverse
    getinverse <- function() 
        inverse_matrix
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
    
}


## This function computes the inverse of the matrix created by 
## makeCacheMatrix above. If the inverse has been calculated and the matrix is the same, 
## the inverse matrix will be retrieved from cache

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inverse_matrix <- x$getinverse()
    
    if(!is.null(inverse_matrix)) {
        # if the inverse has been calculated 
        # it will get the inverse from cache and skip the computation
        message("getting cached data")
        return(inverse_matrix)
    }
    
    # if the inverse has not been calculated it will do the computation
    data <- x$get()
    inverse_matrix <- solve(data, ...)
    
    # set the inverse in the cache using setinverse()
    x$setinverse(inverse_matrix)
    
    return(inverse_matrix)
}


# tests:
test_matrix <- makeCacheMatrix(matrix(1:4, 2, 2))
test_matrix$getinverse() # will return NULL
test_matrix$get()
cacheSolve(test_matrix)
cacheSolve(test_matrix) # will return the message as well as the cached matrix
test_matrix$getinverse()
ls(environment(test_matrix$set))

test_matrix$set(matrix(c(2, 2, 1, 4), 2, 2))
