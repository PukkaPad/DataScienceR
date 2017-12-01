# Debugging Tools
# useful for figuring out what's wrong once I have discovered I have a problem

printmessage <- function (x) {
    if (x >0)
        print ("x is greater than zero")
    else 
        print ("x is less than or equal to zero")
    
    invisible(x)
}

printmessage(7)
printmessage(NA) # error!

printmessage2 <- function(x) {
    if(is.na (x))
        print("x is a missing value!")
    else if (x>0)
        print("x is greate than zero")
    else 
        print ("x is less than or equal to zero")
    invisible(x)
}
printmessage2(7)
printmessage2(NA)
x <- log (-1)
printmessage2(x)

# Tools for debugging
# traceback, debug, browser, trace, recover
rm(list = ls.str(mode = 'numeric'))

# traceback
mean(x)
traceback()

lm(y~x)
traceback()

# debug
debug(lm)
lm(y~x) # this will print out the whole code of the function and start Browse prompt
# type n (for next) on the Browser so it runs the 1st and subsequently lines
# you get to the line that the error occurs

# recover
options(error = recover)
read.csv("nousuchfile")


















