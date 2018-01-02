library(lubridate)

# help:
help(package = lubridate)

# today's date
this_day <- today()

year(this_day)

wday(this_day)

wday(this_day, label = TRUE)

# date and time combinations
this_moment <- now()

hour(this_moment)

# parsing date-times
my_date <- ymd("1989-05-17")
my_date
class(my_date)

ymd("1989 May 17")

# pretend you are in New York City and you are planning to visit a friend in Hong
# Kong. You seem to have misplaced your itinerary, but you know that your flight departs
# New York at 17:34 (5:34pm) the day after tomorrow. You also know that your flight is
# scheduled to arrive in Hong Kong exactly 15 hours and 50 minutes after departure.
# Let's reconstruct your itinerary from what you can remember, starting with the full
# date and time of your departure. We will approach this by finding the current date in
# New York, adding 2 full days, then setting the time to 17:34.
# To find the current date in New York, we'll use the now() function again. This time,
# however, we'll specify the time zone that we want: "America/New_York". Store the result
# in a variable called nyc.

nyc <- now(tzone = "America/New_York")
depart <- nyc + days(2)

# Use update() to add the correct hours (17) and minutes (34) to depart. 
# Reassign the result to depart.
depart <- update(depart, hours = 17, minutes = 34)

# Your friend wants to know what time she should pick you up from the airport in Hong
# Kong. Now that we have the exact date and time of your departure from New York, we can
# figure out the exact time of your arrival in Hong Kong.
# The first step is to add 15 hours and 50 minutes to your departure time. Recall that
# nyc + days(2) added two days to the current time in New York. Use the same approach to
# add 15 hours and 50 minutes to the date-time stored in depart. Store the result in a
arrive <- depart + hours(15) + minutes(50) 

# Use with_tz() to convert arrive to the "Asia/Hong_Kong" time zone. Reassign the result
# to arrive, so that it will get the new value.
arrive <- with_tz(arrive, tzone = "Asia/Hong_Kong")

# Fast forward to your arrival in Hong Kong. You and your friend have just met at the
# airport and you realize that the last time you were together was in Singapore on June
# 17, 2008. Naturally, you'd like to know exactly how long it has been.
last_time <- mdy("June 17, 2008", tz = "Singapore")
how_long <- interval(last_time, arrive)
as.period(how_long)

# This is where things get a little tricky. Because of things like leap years, leap
# seconds, and daylight savings time, the length of any given minute, day, month, week,
# or year is relative to when it occurs. In contrast, the length of a second is always
# the same, regardless of when it occurs.
# To address these complexities, the authors of lubridate introduce four classes of time
# related objects: instants, intervals, durations, and periods. These topics are beyond
# the scope of this lesson, but you can find a complete discussion in the 2011 Journal of
# Statistical Software paper titled 'Dates and Times Made Easy with lubridate'.
