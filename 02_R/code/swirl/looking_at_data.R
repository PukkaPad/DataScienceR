# Looking at Data

#  We'll be using a dataset constructed from 
# the United States Department of Agriculture's PLANTS Database
# (http://plants.usda.gov/adv_search.html).

plants <- read.csv('plants.csv')

# list variables in the workspace:
ls()
ls(plants)

# Check the class of the plants variable with class(plants)
class(plants)

# how many rows and columns
dim(plants) # (5166) is the number of rows (observations) and 
            # (10) is the number of columns (variables).

nrol(plants)
ncol(plants)

# how much space the dataset is occupying in memory
object.size(plants)

# return variable name
names(plants)

# preview top and tail of dataset
head(plants)
tail(plants)

# loads of NA
# check how variables are distributed and how much NA
summary(plants)

# R truncated the summary for Active_Growth_Period by including a catch-all category called 'Other'.
# Since it is a categorical/factor variable
table(plants$Active_Growth_Period)

# check the *str*ucture of the data
str(plants)






