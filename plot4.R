library(plyr)
library(lubridate)
library(dplyr)

hh <- read.csv("~/Desktop/Quant College/Data Science Specialisation/Exploratory Data (4)/household_power_consumption.txt", header=FALSE, sep=";")
View(hh)

# Subsetting data for two given dates
a <- filter(hh, V1 == "1/2/2007")
b <- filter(hh, V1 == "2/2/2007")
hh <- rbind(a, b)
colnames(hh) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Converting columns to classes that I will find useful to work with 
hh$Date <- dmy(hh$Date)
hh$datetime <- paste(hh$Date, hh$Time)
hh$datetime <- strptime(hh$datetime, "%Y-%m-%d %H:%M:%S")

hh$Global_active_power <- as.numeric(as.character(hh$Global_active_power))
# I didn't know that as.numeric couldn't handle factors directly!
hh$Global_reactive_power <- as.numeric(as.character(hh$Global_reactive_power))
hh$Voltage <- as.numeric(as.character(hh$Voltage))
hh$Global_intensity <- as.numeric(as.character(hh$Global_intensity))
hh$Sub_metering_1 <- as.numeric(as.character(hh$Sub_metering_1))
hh$Sub_metering_2 <- as.numeric(as.character(hh$Sub_metering_2))
hh$Sub_metering_3 <- as.numeric(as.character(hh$Sub_metering_3))

#Alternative to this: select(hh, Global_active_power:Sub_metering_3) <- lapply(select(hh, Global_active_power:Sub_metering_3), as.character, as.numeric)

#Plot 4
png(file = "plot4.png")
par(mfrow = c(2,2), mar = c(4,4,4,4))
plot(hh$datetime, hh$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power")
plot(hh$datetime, hh$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(hh$datetime, hh$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = NA)
points(hh$datetime, hh$Sub_metering_1, type = "l", col = "black")
points(hh$datetime, hh$Sub_metering_2, type = "l", col = "red")
points(hh$datetime, hh$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = "---", col = c("black", "red", "blue"), cex = 0.6, bty = "n", xjust = 1)
plot(hh$datetime, hh$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()