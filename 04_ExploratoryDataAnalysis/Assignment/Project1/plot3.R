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


# use the png driver as dev.copy is cutting the legend when I save it
png("plot3.png", width=480, height=480)

# Plot 3
#par(bg = 'light gray')
with (jan_feb_07, {
    plot(Datetime, Sub_metering_1,
         xlab = "",ylab = "Energy sub metering", type = "l")
    lines(Datetime, Sub_metering_2, type = "l", col = "red")
    lines(Datetime, Sub_metering_3, type = "l", col = "blue")
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1.5, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Save
#dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()

