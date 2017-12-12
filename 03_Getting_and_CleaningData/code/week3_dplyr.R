# Week 3
Sys.setenv(TZ="Europe/London")
## Managing df with dplyr - Introduction

library(dplyr)

### select funtion
chicago <- readRDS("../data/chicago.rds")
dim(chicago)
str(chicago)
names(chicago)

head(select(chicago, city:dptp)) # selecting columns from city to dptp

head(select(chicago, -(city:dptp))) # not selecting columns from city to dptp

##### equivalent to the above:
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

### filter function
#used to subset rows based on conditions
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, 10)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f, 10)

### arrange function
#reorder the rows based on the values of the column
chicago <- arrange (chicago, date)
head(chicago)
tail(chicago)

chicago <- arrange(chicago, desc(date))
head(chicago)
tail(chicago)

### rename function
#rename a variable in R
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)

### mutate function
#used to transform or create variables
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm=TRUE))
head(select(chicago, pm25, pm25detrend))

### group_by function
#split df according to categorical variables
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
hotcold  

### summarise function
summarise(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

### special operator:  pipeline operator %>%
#allows chain operator together
chicago %>% mutate(month = 
                       as.POSIXlt(date)$year + 
                       1) %>% group_by(month) %>% summarise(pm25=
                                                                mean(pm25, na.rm = TRUE), 
                                                                                        o3 = max(o3tmean2), 
                                                                                        no2 = median(no2tmean2))














