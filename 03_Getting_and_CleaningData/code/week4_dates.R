# week4 - Working with dates

# date class

d1 = date()
d1
class(d1)

d2 = Sys.Date()
d2
class(d2)


# formatting dates
# %d = day as number
# %a = abbreviated weekday
# %A = unabbreviated weekday
# %m = month as number
# %b = abbreviated month
# %B = unabbreviated month
# %y = 2 digit year
# %Y = 4 digit year

format(d2, "%a %b %d")

# Creating dates
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
x
z = as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1]-z[2])

# Converting to Julian
weekdays(d2)

months(d2)

julian(d2)

library(lubridate)

ymd("20140108")

mdy("08/04/2013")

dmy("03-04-2013")

ymd_hms("2011-08-03 10:15:03")

ymd_hms("1986-02-17 06:06:06", tz="Pacific/Auckland")

?Sys.timezone

x = dmy(c("1jan1960", "2jan1960", "31mar1960", "30jul1960"))
wday(x[1])
wday(x[1], label=TRUE)




