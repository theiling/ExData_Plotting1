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
# No idea, why Header = TRUE does not work.
data2 <- read.table("household_power_consumption.txt",sep=";", header=FALSE, skip=66637, nrow=2880)
names(data2)<-strsplit(readLines("household_power_consumption.txt",n=1),";")[[1]]


# Cat Date and Time variable
data2$dateTime <- paste(data2$Date, data2$Time)
# Convert to Date/Time
data2$dateTime <- strptime(data2$dateTime, "%d /%m/%Y %H:%M:%S")

# Plot 4 - four separate Plots in one canvas
png("plot4.png", units="px", height=480, width=480)
par(mfrow=c(2,2),mar=c(4,4,2,2))
#first plot in canvas
with(data2,{
plot(dateTime,as.numeric(Global_active_power), type="l", xlab="",ylab="Global Active Power")
})

# second plot in canvas
with(data2,{
  plot(dateTime,as.numeric(Voltage), type="l", xlab="datetime",ylab="Voltage")
})

# third plot in canvas
with(data2,{plot(dateTime, as.numeric(as.character(Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering")
            lines(dateTime, as.numeric(as.character(Sub_metering_2)), col="red")
            lines(dateTime, as.numeric(as.character(Sub_metering_3)), col="blue")
            legend("topright", lty=1, cex=0.8, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
})

# fourth plot in canvas
with(data2,{
  plot(dateTime,as.numeric(Global_reactive_power), type="l", xlab="datetime",ylab="Global_reactive_power")
})
# Save plot as png-file
#dev.copy(png,"plot4.png", units="px", height=480, width=480)
dev.off()

# Set plot canvas back to default 1 plot and larger margins
par(mfrow=c(1,1))
par(mfrow=c(1,1),mar=c(5,4,4,2))
