# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header=TRUE)
unlink(temp)

data2007 <- data[grep("^[12]/2/2007$", data$Date),]
data2007 <- transform(data2007,
                      Date = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
                      Global_active_power = as.numeric(Global_active_power),
                      Global_reactive_power = as.numeric(Global_reactive_power),
                      Voltage = as.numeric(Voltage),
                      Global_intensity = as.numeric(Global_intensity),
                      Sub_metering_1 = as.numeric(Sub_metering_1),
                      Sub_metering_2 = as.numeric(Sub_metering_2),
                      Sub_metering_3 = as.numeric(Sub_metering_3))

par(mfrow = c(2,2))

hist(data2007$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (killowatts)",
     ylim = c(0, 1.2e3))

plot(data2007$Date, data2007$Global_active_power,
     main = "Global Active Power",
     ylab = "Global Active Power (killowatts)",
     xlab = "",
     type = "l")

plot(data2007$Date, data2007$Sub_metering_1, type="n", xlab="",
     ylab="Energy sub metering")
points(data2007$Date, data2007$Sub_metering_1, type="l", col="black")
points(data2007$Date, data2007$Sub_metering_2, type="l", col="red")
points(data2007$Date, data2007$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data2007$Date, data2007$Global_reactive_power,
     ylab = "Global Reactive Power (killowatts)",
     xlab = "datetime",
     type = "l")

dev.copy(png, "plot4.png", 480, 480)
dev.off()