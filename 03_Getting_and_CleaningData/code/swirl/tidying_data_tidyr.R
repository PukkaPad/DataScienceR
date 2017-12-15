# Tidying Data with tidyr

library(dplyr)
library(tidyr)
library(readr)

# 1) all of the following are characteristics of messy data, EXCEPT...

# 1: Multiple variables are stored in one column
# 2: Variables are stored in both rows and columns
# 3: Multiple types of observational units are stored in the same table
# 4: Every column contains a different variable
# 5: Column headers are values, not variable names
# 6: A single observational unit is stored in multiple tables

# Answer: 4

# 2) The first problem is when you have column headers that are values, not variable names
students = read.csv("../../data/students.csv")
View(students)
# This dataset actually has three variables: grade, sex, and count
# The first variable, grade, is already a column, so that should remain as it is. 
# The second variable, sex, is captured by the second and third column headings. 
# The third variable, count, is the number of students for each combination of 
# grade and sex.
# To tidy the students data, we need to have one column for each of these three variables
gather(students, sex, count, -grade) # Note the minus sign before grade, 
                                     # which says we want to gather all columns EXCEPT grade

# 3) second messy data case we'll look at is when multiple variables are 
# stored in one column. 
students2 = read.csv("../../data/students2.csv")
# This dataset is similar to the first, except now there are two separate classes, 
# 1 and 2, and we have total counts for each sex within each class
res <- gather(students2, sex_class, count, -grade)
# That got us half way to tidy data, but we still have two different variables, 
# sex and class, stored together in the sex_class column
separate(data = res, col = sex_class, into = c("sex", "class"))
# just like with dplyr, you can use the %>% operator to chain 
# multiple function calls together.

# script1.R

# 4) A third symptom of messy data is when variables are stored in 
# both rows and columns. students3 provides an example of this
students3 = read.csv("../../data/students3.csv")
# The first variable, name, is already a column and should remain as it is. 
# The headers of the last five columns, class1 through class5, are all 
# different values of what should be a class variable. The values
# in the test column, midterm and final, should each be its own variable 
# containing the respective grades for each student.

# script2.R

# script3.R

# 5) Lastly, we want the values in the class column to simply be 1, 2, ..., 5 
# and not class1, class2, ..., class5. We can use the parse_number() function 
# from readr to accomplish this

# script4.R

# 6) The fourth messy data problem we'll look at occurs when multiple 
# observational units are stored in the same table. students4 presents 
# an example of this
students4 = read.csv("../../data/students4.csv")
# notice that each id, name, and sex is repeated twice, which
# seems quite redundant

# solution will be to break students4 into two separate tables -- 
# one containing basic student information (id, name, and sex) and the other 
# containing grades (id, class, midterm, final)

# script5.R
# script6.R
# script7.R

# 7) The fifth and final messy data scenario that we'll address is when a 
# single observational unit is stored in multiple tables.
passed = read.csv("../../data/passed.csv")
failed = read.csv("../../data/failed.csv")

# add a new column to the passed table
passed <- mutate(passed, status = "passed")
passed

# do the same for the failed table
failed <- mutate(failed, status = "failed")
failed

# pass as arguments the passed and failed tables (in order) to the 
# dplyr function bind_rows(), which will join them together into a single unit
bind_rows(passed, failed)

# 8) sat.csv, which contains data on all college-bound seniors who 
# took the SAT exam in 2013.
sat = read.csv("../../data/sat.csv")

# script8.R
# script9.R