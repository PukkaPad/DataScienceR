# Grouping and Chaining with dplyr
# summarize(), is most powerful when applied to grouped data
# The main idea behind grouping data is that you want to break up the dataset 
# into groups of rows based on the values of one or more variables. 
# The group_by() function is reponsible for doing this.

# Chaining allows you to string together multiple function calls in a way that 
# is compact and readable,while still accomplishing the desired result. 


library(dplyr)

mydf = read.csv("../../data/mydf.csv")

cran <- tbl_df(mydf)
rm(mydf)

# 1) Group cran by the package variable and store the result in a new object called by_package.
by_package <- group_by(cran, package)

# ow any operation we apply to the grouped data will take place on a per package basis.

# 2) apply mean(size) to the grouped data
summarize(by_package, mean(size))

# 3) eidt summarize1.R
# The 'count' column, created with n(), contains the total number of rows 
# (i.e. downloads) for each package. The 'unique' column, created with 
# n_distinct(ip_id), gives the total number of unique downloads
# for each package, as measured by the number of distinct ip_id's. 
# The 'countries' column, created with n_distinct(country), provides the number 
# of countries in which each package was downloaded. And finally, the 'avg_bytes' 
# column, created with mean(size), contains the mean download size (in bytes) 
# for each package.

# 4) Naturally, we'd like to know which packages were most popular on the day 
# these data were collected (July 8, 2014). Let's start by isolating the top 
# 1% of packages, based on the total number of downloads as measured by the 
# 'count' column

# We need to know the value of 'count' that splits the data into the top 1% 
# and bottom 99% of packages based on total downloads
quantile(pack_sum$count, probs = 0.99)

# Now we can isolate only those packages which had more than 679 total downloads
top_counts <- filter (pack_sum, count > 679)

# 5) View all 61 rows with View(top_counts)
View(top_counts)

# 6) arrange() the rows of top_counts based on the 'count' column 
# and assign the result to a new object called top_counts_sorted.
top_counts_sorted <- arrange(top_counts, desc(count))

# 7) Perhaps we're more interested in the number of *unique* downloads on this 
# particular day. In other words, if a package is downloaded ten times in one 
# day from the same computer, we may wish to count that as only one download.
# find the 0.99, or 99%, quantile for the 'unique' variable 
quantile(pack_sum$unique, probs = 0.99)

# 8) Apply filter() to pack_sum to select all rows corresponding to values 
# of 'unique' that are strictly greater than 465. Assign the result to 
# a object called top_unique.
top_unique <- filter(pack_sum, unique > 465)

# 9) Now arrange() top_unique by the 'unique' column, in descending order
# Assign the result to top_unique_sorted.
top_unique_sorted <- arrange(top_unique, desc(unique))


# 10) Our final metric of popularity is the number of distinct countries 
# from which each package was downloaded

# summarize2.R
# It's worth noting that we sorted primarily by country, but used avg_bytes 
# (in ascending order) as a tie breaker. This means that if two packages were 
# downloaded from the same number of countries, the package
# with a smaller average download size received a higher ranking.

# 11) accomplish the same result as the last script, but avoid saving 
# intermediate results.
# This requires embedding function calls within one another.

#summarize3.R

#summarize4.R
# In this script, we've used a special chaining operator, %>%, which was 
# originally introduced in the magrittr R package and has now become a key 
# component of dplyr. You can pull up the related documentation with ?chain. 
# The benefit of %>% is that it allows us to chain the function calls in a
# linear fashion. The code to the right of %>% operates on the result from 
# the code to the left of %>%.

# So, the results of the last three scripts are all identical. 
# But, the third script provides a convenient and concise alternative to the 
# more traditional method that we've taken previously, which involves
# saving results as we go along.

# 12) build a chain of dplyr commands one step at a time, 
# starting with the script I chain1.R
# add to the chain (chain2.R)
# more (chain3.R)
# finish (chain4.R)








