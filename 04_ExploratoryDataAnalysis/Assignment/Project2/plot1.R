# Course Project 2
# Week 4

data <- readRDS("./data/summarySCC_PM25.rds")
head(data)
SCC <- readRDS("./data/Source_Classification_Code.rds")
head(SCC, 3)
names(SCC)


## Plot 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

# compute sum of emission by year
aggEmission <- aggregate(Emissions ~ year, data, sum)
head(aggEmission)
sapply(aggEmission, class)

# Convert integer to numeric
aggEmission <- transform(aggEmission, year = as.numeric(year))
sapply(aggEmission, class)

summary(aggEmission)

# generate and save plot
png("plot1.png", width = 480, height = 480)
range(aggEmission$Emissions)
options(scipen=10)
#at <- seq(from = 0, to = 8000000, by = 1000000)
barplot(height = aggEmission$Emissions, names.arg = aggEmission$year,
        ylab = "Total Emission [tons]", xlab = "Year", 
        main = expression ('Plot 1 - Total PM'[2.5]*' Emission'),
        col = "blue", ylim = c(0, 8000000))
#axis(side = 2, at = at)
mtext("From all sources - 1999 to 2008")
dev.off()
        