# Course Project 2
# Week 4

if(!exists("data")){
    data <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}


## Plot 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)

head(data)
unique(data$Pollutant)
summary(data$Pollutant)
tail(data$Pollutant)

head(SCC)

# Merge both data sets
mergeDataSCC <- merge(data, SCC, by = "SCC")
head(mergeDataSCC, 3)

# subset by Short.Name and create df with coal
coal <- grepl("coal", mergeDataSCC$Short.Name, ignore.case = TRUE)

coalEmission <- mergeDataSCC[coal, ]
head(coalEmission)

# compute sum of emission by year
coalEmission <- aggregate(Emissions ~ year, coalEmission, sum)
head(coalEmission)

# generate and save plot
png("plot4.png", width = 480, height = 480)

ggplot(coalEmission, aes(year, Emissions)) + 
    geom_point(aes()) + geom_line() + xlab("Year") +
    ylab ("Total Emission [tons]") + 
    ggtitle(expression ('Plot 4 - Total PM'[2.5]*' Coal Emission in the United States')) +
    labs( subtitle = "1998 to 2008") +
    theme(plot.title = element_text(hjust = 0.5), 
          plot.subtitle=element_text(hjust=0.5), 
          legend.position='none') + 
    scale_color_discrete(name="Sources") + 
    scale_x_continuous(breaks = seq(from = 1999, to = 2009, by = 1))
dev.off()


