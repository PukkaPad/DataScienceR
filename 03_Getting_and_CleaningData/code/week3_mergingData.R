# Week 3
cat("\014")
Sys.setenv(TZ="Europe/London")

## Merging data
#http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895
### dowloading peer review data
if (!file.exists("../data")){dir.create("../data")}
fileURL1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileURL2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileURL1, destfile = "../data/reviews.csv", method = "curl")
download.file(fileURL2, destfile = "../data/solutions.csv", method = "curl")

reviews <- read.csv("../data/reviews.csv")
solutions <- read.csv("../data/solutions.csv")
head(reviews,2)
head(solutions,2)

names(reviews)
names(solutions)
# solution_id in the reviews df and if in the solutions df

mergeData = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
head(mergeData)

# default - merge ll common column names
intersect(names(solutions), names(reviews))
mergedData2 = merge(reviews, solutions, all=TRUE)
head(mergedData2)

# using join in the plyr package
df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1, df2), id)

# for multiple df
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)
