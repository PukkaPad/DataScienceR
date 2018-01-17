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

if(!exists("mergeDataSCC")){
    mergeDataSCC <- merge(data, SCC, by = "SCC")
}

## Plot 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037")
## Which city has seen greater changes over time in motor vehicle emissions? 

# generate the df
motorBalt <- subset(mergeDataSCC, fips == '24510' & type == 'ON-ROAD')
head(motorBalt, 3)
motorCalif <- subset(mergeDataSCC, fips == '06037' & type == 'ON-ROAD')
head(motorCalif, 3)

# compute sum of emission by year, create city column
motorEmissionBalt <- aggregate(Emissions~year, motorBalt, sum)
motorEmissionBalt$city <- paste(rep('Baltimore', length(motorEmissionBalt$year)))
head(motorEmissionBalt)
motorEmissionCalif <- aggregate(Emissions~year, motorCalif, sum)
motorEmissionCalif$city <- paste(rep('California', length(motorEmissionCalif$year)))
head(motorEmissionCalif)

df <- as.data.frame(rbind(motorEmissionBalt, motorEmissionCalif))
df

# generate and save plot
png("plot6.png", width = 480, height = 480)

ggplot(df, aes(year, Emissions, color = city)) + 
    geom_point(aes(color = city)) + geom_line() + xlab("Year") +
    ylab ("Total Emission [tons]") + 
    ggtitle(expression ('Plot 6 - Total PM'[2.5]*' Motor Vehicle Emission in Baltimore City vs California ')) +
    labs( subtitle = "1999 to 2008") +
    theme(plot.title = element_text(hjust = 0.5), 
          plot.subtitle=element_text(hjust=0.5), 
          legend.background = element_rect(fill="gray90")) + 
    scale_color_discrete(name="City") + 
    scale_x_continuous(breaks = seq(from = 1999, to = 2009, by = 1))
dev.off()


