# Download and unzip data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip")
unzip("./data.zip")

# Read data
dat <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, skip = 66637, nrows = 69517 - 66637)
names(dat) <- names(read.csv2("household_power_consumption.txt", nrows = 1))
dat$Time <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")

# Open a new png file device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Draw plots
par(mfrow = c(2,2))

plot(dat$Time, dat$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

plot(dat$Time, dat$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")

plot(dat$Time, dat$Sub_metering_1, type = "s", ylab = "Energy sub metering", xlab = "")
points(dat$Time, dat$Sub_metering_2, type = "s", col = "red")
points(dat$Time, dat$Sub_metering_3, type = "s", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dat$Time, dat$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "s")

# Close the png file device
dev.off()