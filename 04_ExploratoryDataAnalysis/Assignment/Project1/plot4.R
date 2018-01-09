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

# I will generate and save the image applying the same method I did in plot3.R
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
with(jan_feb_07, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage (volt)", xlab="datetime")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="datetime")
})
dev.off()
