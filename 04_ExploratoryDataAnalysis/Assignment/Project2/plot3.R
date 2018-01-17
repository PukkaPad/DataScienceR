# Course Project 2
# Week 4

if(!exists("data")){
    data <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

if(!exists("SCC")){
    Maryland <- subset(data, fips == '24510')
}

## Plot 3
## Of the four types of sources indicated by the type 
## seen decreases in emissions from 1999–2008 for Baltimore City?
## (point, nonpoint, onroad, nonroad) variable, which of these four sources have
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

# compute sum of emission by year
aggMaryland <- aggregate(Emissions ~ year + type, Maryland, sum)
head(aggMaryland)

# generate and save plot
png("plot3.png", width = 480, height = 480)
ggplot(aggMaryland, aes(year, Emissions, color = type)) + 
    geom_point(aes(color = type)) + geom_line() + xlab("Year") +
    ylab ("Total Emission [tons]") + 
    ggtitle(expression ('Plot 3 - Total PM'[2.5]*' Emission in Baltimore City, Maryland')) +
    labs( subtitle = "From all sources - 1999 to 2008") +
    theme(plot.title = element_text(hjust = 0.5), 
          plot.subtitle=element_text(hjust=0.5), 
          legend.background = element_rect(fill="gray90")) + 
    scale_color_discrete(name="Sources") +
    scale_x_continuous(breaks = seq(from = 1999, to = 2009, by = 1)) +
    scale_y_continuous(breaks = seq(from = 0, to = 3500, by = 500))
dev.off()
    
