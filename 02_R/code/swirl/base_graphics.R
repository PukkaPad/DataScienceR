# Base Graphics


data(cars)
cars

head(cars)
tail(cars)
dim(cars)
names(cars)
summary(cars)


plot(cars)
plot(cars$speed, cars$dist)
plot(cars$speed, cars$dist, xlab = "Speed", ylab = "Stopping Distance", 
     main = "My Plot", sub = "My Plot Subtitle", col = 2, pch = 2)
 # for pch, see ?points

data(mtcars)
head(mtcars)
tail(mtcars)
dim(mtcars)
names(mtcars)
summary(mtcars)

boxplot(mpg ~ cyl, data = mtcars)
hist(mtcars$mpg)
