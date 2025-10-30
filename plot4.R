# Begin - Download data
filename <- "household_power_consumption.txt"
zipname <- "household_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(filename)) {
  if (!file.exists(zipname)) {
    download.file(url, zipname, mode = "wb")
  }
  unzip(zipname)
}
# End - Download data

data <- read.table(
    filename, sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2, 2))

# Top-left
plot(
    data$Datetime,
    as.numeric(data$Global_active_power),
    type="l",
    xlab="",
    ylab="Global Active Power"
)

# Top-right
plot(
    data$Datetime,
    as.numeric(data$Voltage),
    type="l",
    xlab="datetime",
    ylab="Voltage"
)

# Bottom-left
plot(
    data$Datetime,
    as.numeric(data$Sub_metering_1),
    type="l",
    xlab="",
    ylab="Energy sub metering"
)
lines(data$Datetime, as.numeric(data$Sub_metering_2), col="red")
lines(data$Datetime, as.numeric(data$Sub_metering_3), col="blue")
legend(
    "topright",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col=c("black", "red", "blue"),
    lty=1,
    bty="n")

# Bottom-right
plot(
    data$Datetime,
    as.numeric(data$Global_reactive_power),
    type="l",
    xlab="datetime",
    ylab="Global_reactive_power")

dev.off()
