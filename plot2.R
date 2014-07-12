# Project 1
# Set locale for english days
Sys.setlocale(category = "LC_TIME", locale = "C")
# Do download, if file does not exist.
myfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.zip")) {
  print ("Downloading File")
  download.file(myfile, destfile="household_power_consumption.zip", method="auto", mode="wb")
} else
{print ("Downloading File not needed")
}

# Do unzip, if unzipped file does not exist.
if (!file.exists("household_power_consumption.txt")) {
  print("unzipping")
unzip("household_power_consumption.zip")
} else
{ print ("Unzipping not needed")}

# Read data - Slow!
#data <- read.table("household_power_consumption.txt",sep=";", header=TRUE)
# Household power consumption for 01Feb 2007 and 02Feb 2007 only
#data2 <- data[as.character(data$Date) %in% c("1/2/2007", "2/2/2007"),]

# Read data - faster as only Household power consumption for 01Feb 2007 and 02Feb 2007
# data2 <- read.table("household_power_consumption.txt",sep=";", header=TRUE, skip=66637, nrow=2880)
# No idea, why Header = TRUE does not work.
data2 <- read.table("household_power_consumption.txt",sep=";", header=FALSE, skip=66637, nrow=2880)
names(data2)<-strsplit(readLines("household_power_consumption.txt",n=1),";")[[1]]

# Cat Date and Time variable
data2$dateTime <- paste(data2$Date, data2$Time)
# Convert to Date/Time
data2$dateTime <- strptime(data2$dateTime, "%d /%m/%Y %H:%M:%S")

# Plot 2
with(data2, plot(dateTime,Global_active_power,type="l", lwd=1, xlab="",ylab="Global Active Power (kilowatts)"))

# Save plot as png-file
dev.copy(png,"plot2.png", units="px", height=480, width=480)
dev.off()
