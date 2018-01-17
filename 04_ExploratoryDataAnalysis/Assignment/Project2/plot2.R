# Course Project 2
# Week 4

if(!exists("data")){
    data <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

## Plot 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips =="24510")
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# subset Maryland data
head(data)
Maryland <- subset(data, fips == '24510')

# compute sum of emission by year
aggMaryland <- aggregate(Emissions ~ year, Maryland, sum)
head(aggMaryland)

# generate and save plot
png("plot2.png", width = 480, height = 480)
range(aggMaryland$Emissions)
options(scipen=10)
barplot(height = aggMaryland$Emissions, names.arg = aggMaryland$year,
        ylab = "Total Emission [tons]", xlab = "Year", 
        main = expression ('Plot 2 - Total PM'[2.5]*' Emission in Baltimore City, Maryland'),
        col = "blue", ylim = c(0, 3500))
mtext("From all sources")
dev.off()