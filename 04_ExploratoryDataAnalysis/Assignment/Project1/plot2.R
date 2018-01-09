# Getting full dataset
electric <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                     nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
electric$Date <- as.Date(electric$Date, format="%d/%m/%Y")

# Subsetting the data
jan_feb_07 <- subset(electric, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(electric)

# Week days
week <- paste(as.Date(jan_feb_07$Date), jan_feb_07$Time)
jan_feb_07$Datetime <- as.POSIXct(week)

# Plot 2
#par(bg = 'light gray')
plot(jan_feb_07$Datetime, jan_feb_07$Global_active_power,
     xlab = "",ylab = "Global Active Power (kilowatts)", type = "l")

# Save
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()

