# Dates and times

datestring <- c("February 10, 2012 11:11", "January 27, 2011 10:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)

x <- as.Date("2010-01-01")
y <- strptime("9 Jan 2011  11:34:10", "%d %b %Y %H:%M:%S")
# If i try to subtract them I get an error because they are not the same data objects
x - y
# to solve
x <- as.POSIXlt(x)
x
x - y

#it keeps track of leap years:
x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x-y

# it keeps track of change in the time zone
x <- as.POSIXct("2012-10-25 01:00:00", tz = "NZ")
y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT")
x - y
