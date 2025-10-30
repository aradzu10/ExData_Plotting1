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

png(filename="plot1.png", width=480, height=480)
hist(
    as.numeric(data$Global_active_power),
    col="red",
    main="Global Active Power",
    xlab="Global Active Power (kilowatts)",
    ylab="Frequency", breaks=12)
dev.off()
