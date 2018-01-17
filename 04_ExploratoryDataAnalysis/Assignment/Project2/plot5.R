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
    

## Plot 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# subset by Short.Name and Maryland and create df with motor
motor <- subset(mergeDataSCC, fips == '24510' & type == 'ON-ROAD')
head(motor)

# compute sum of emission by year
motorEmission <- aggregate(Emissions~year, motor, sum)
head(motorEmission)

# generate and save plot
png("plot5.png", width = 480, height = 480)

ggplot(motorEmission, aes(year, Emissions)) + 
    geom_point(aes()) + geom_line() + xlab("Year") +
    ylab ("Total Emission [tons]") + 
    ggtitle(expression ('Plot 5 - Total PM'[2.5]*' Motor Vehicle Emission in Baltimore City, Maryland')) +
    labs( subtitle = "1999 to 2008") +
    theme(plot.title = element_text(hjust = 0.5), 
          plot.subtitle=element_text(hjust=0.5), 
          legend.position='none') + 
    scale_color_discrete(name="Sources") + 
    scale_x_continuous(breaks = seq(from = 1999, to = 2009, by = 1))
dev.off()