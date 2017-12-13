# Manipulating Data with dplyr
# dplyr supplies five 'verbs' that cover most fundamental data manipulation tasks: 
# select(), filter(), arrange(), mutate(), and summarize()


#library(swirl)
#install_from_swirl("Getting and Cleaning Data")
Sys.setenv(TZ="Europe/London")
Sys.getenv("TZ")

library(dplyr)

# We'll be working with the CRAN log from July 8, 2014, which contains
# information on roughly 225,000 package downloads.
# the variable called path2csv, which contains the full file path to the dataset. 
# Call read.csv() with two arguments, path2csv and stringsAsFactors = FALSE, 
# and save the result in a new variable called mydf

mydf = read.csv("../../data/mydf.csv")
dim(mydf)
head(mydf)

# The first step of working with data in dplyr is to load the data 
# into what the package authors call a 'data frame tbl' or 'tbl_df'
# The main advantage to using a tbl_df over a regular data frame is the printing
cran <- tbl_df(mydf)
rm("mydf")

# 1) select only the ip_id, package, and country variables from the cran dataset
select(cran, ip_id, package, country)

# 2) select all columns starting from r_arch and ending with country
select(cran, r_arch:country)

# 3) omit the time column
select(cran, -time)

# 4) select all rows for which the package variable is equal to "swirl"
filter(cran, package =="swirl")

# 5) return all rows of cran corresponding to downloads from users in the US
# running R version 3.1.1
filter(cran, r_version == "3.1.1", country == "US")

# 6) Edit your previous call to filter() to instead return rows 
# corresponding to users in "IN" (India) running an R version 
# that is less than or equal to "3.0.2"
filter(cran, r_version <= "3.0.2", country == "IN")
#str(cran)

# 7) all rows for which the country variable equals either "US" or "IN"
filter(cran, country == "US" | country == "IN")

# 8) use filter() to fetch all rows for which size is strictly greater than 100500
# AND r_os equals "linux-gnu"
filter(cran, size > 100500, r_os == "linux-gnu")

# 9) get only the rows for which the r_version is not missing
filter(cran, !is.na(r_version))

# 10) select() all columns from size through ip_id and store the result in cran2
cran2 <- select(cran, size:ip_id)

# 11) order the ROWS of cran2 so that ip_id is in ascending order
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id)) # descending order

# 12) arrange data by package and ip_id
arrange(cran2, package, ip_id)

# 13) Arrange cran2 by the following three variables, in this order: 
# country (ascending), r_version (descending), and ip_id (ascending)
arrange(cran2, country, desc(r_version), ip_id)

# 14) Use select() to grab 3 columns from cran -- 
# ip_id, package, and size (in that order) -- and store the result
# in a new variable called cran3
cran3 <- select(cran, ip_id, package, size)

# 15) add a column called size_mb that contains the download size in megabytes
mutate(cran3, size_mb = size / 2^20)

# 16) create a third column size_gb, all in the same line of code
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)

# 17) Pretend we discovered a glitch in the system that provided the original
# values for the size variable. All of the values in cran3 are 1000 bytes less 
# than they should be. Using cran3, create just one new column called correct_size 
# that contains the correct size.
mutate(cran3, correct_size = size + 1000)

# 18) the average download size
summarize(cran, avg_bytes = mean(size))
