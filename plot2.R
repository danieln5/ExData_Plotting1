# Script to generate plot 2

library(lubridate)

# Download the data set zip file, unless it already exists in the working directory
zipfilename <- "dataset.zip"
if (!file.exists(filename)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile=zipfilename, method="curl")
}

filename <- "household_power_consumption.txt"
# Unzip the file, unless data set text file is already present
if (!file.exists(filename)) { 
  unzip(zipfilename) 
}

# Read the data set from the respective file
data <- read.table(filename, sep=";", header=TRUE, na.strings="?")
# Convert Date and Time variables to R Date/Time classes
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
datetime <- paste(data$Date, data$Time)
data$Time <- strptime(datetime, format = "%Y-%m-%d %H:%M:%S")

# Use data only from the dates 2007-02-01 and 2007-02-02
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Plot directly to file to avoid formatting issues
png(file = "plot2.png", width = 480, height = 480)

# Construct plot to match Plot 2 in instructions
with(data, plot(Time, Global_active_power, type="l" , xlab="", ylab = "Global Active Power (kilowatts)"))

dev.off()
