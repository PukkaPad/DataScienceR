# lapply and sapply
#Throughout this lesson, we'll use the Flags dataset from the UCI Machine Learning Repository. 
# This dataset contains details of various nations and their flags. More information may be found here:
# http://archive.ics.uci.edu/ml/datasets/Flags

# CSV
flags <- read.csv('flags.csv')

# preview first 6 lines
head(flags)

# check dimensions
dim(flags) # 194 observations and 30 columns (variables)

# what's the format the variables have been stored
class(flags) # dataframe - it doesnt answer the question 
# because it checks the class of the whole thing instead of the class of each variable
# The lapply() function takes a list as input, applies a function to each element of the list, 
# then returns a list of the same length as the original one. 
# Since a data frame is really just a list of vectors (as.list(flags)), 
# we can use lapply() to apply the class() function to each column of the flags dataset. 
cls_list <- lapply(flags, class)
cls_list
class(cls_list)
length(cls_list)

# to simplify cls_list to a character vector
as.character(cls_list)
# sapply() allows you to automate this process by calling lapply() behind the scenes, 
# but then attempting to simplify (hence the 's' in 'sapply') the result for you
cls_vect <- sapply(flags, class)
class(cls_vect)


# columns 11 to 17 are indicators variables of colours
# find out the number of countries with the orange colour on their flags
sum(flags$orange)
# do the same for each column in the datset
flag_colours <- lapply(flags[,11:17], sum)
sapply(flags[,11:17], sum)
sapply(flags[,11:17], mean)

# columns 19 to 23 are indicators shapes
flag_shapes <- lapply(flags[,19:23], as.numeric)
class(flag_shapes$quarters)
lapply(flag_shapes, range)
shape_mat <- sapply(flag_shapes, range)
class(shape_mat)

# We want to know the unique values for each variable in the flags dataset
unique_vals <- lapply(flags, unique)
sapply(unique_vals, length)
sapply(flags, unique)

# Pretend you are interested in only the second item from each element of the unique_vals list that you just created.
lapply(unique_vals, function(elem) elem[2])












