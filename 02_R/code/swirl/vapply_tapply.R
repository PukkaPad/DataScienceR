# vapply and tapply
# vapply() allows you to specify it explicitly the format of the result
# the result doesn't match the format you specify, vapply() will throw an error
# vapply() is 'safer' than sapply(), since it requires you to specify the format of the output
# in advance, instead of just allowing R to 'guess' what you wanted

# tapply() is used to split the data into groups based on the value of some variable
# then a function is applied to the members of each group

# CSV
flags <- read.csv('flags.csv')

# do "you expect each element of the result to be a numeric vector of length 1"
vapply(flags, unique, numeric(1))

# to be explicit about the format of the result we expect each column
# 'character(1)' argument tells R that we expect the class function 
# to return a character vector of length 1 when applied
# to EACH column of the flags dataset
vapply(flags, class, character(1))

# How many countries fall in each landmass group?
# landmass group takes values between 1 and 6
table(flags$landmass) # gives the how many fall in each group

# how many flags contain an animate image
table(flags$animate) # 39 flags contain an animate object (animate = 1) and 155 do not (animate = 0)
# get the mean function to the animate for each 6 landmass group
tapply(flags$animate, flags$landmass, mean)
# the first landmass group (landmass = 1) contains the highest proportion of flags with an animate image (0.4194).

# summary population values (in round millions) for countries with and without the colour red on their flag
tapply(flags$population, flags$red, summary)

# look at a summary of population values for each of the six landmasses
tapply(flags$population, flags$landmass, summary)




