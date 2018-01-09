# Getting full dataset
electric <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
               nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
electric$Date <- as.Date(electric$Date, format="%d/%m/%Y")

# Subsetting the data
jan_feb_07 <- subset(electric, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(electric)

# Plot 1
#par(bg = 'light gray')
hist(jan_feb_07$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Save
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()

