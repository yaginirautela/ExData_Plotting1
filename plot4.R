# Load necessary libraries
library(data.table)

# Set the working directory (adjust to your file location)
setwd("C:/path/to/your/repository")  # Update path as needed

# Read in the data
powerDT <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Date' to Date type and relevant columns to numeric
powerDT[, Date := as.Date(Date, format="%d/%m/%Y")]
powerDT[, Global_active_power := as.numeric(Global_active_power)]
powerDT[, Sub_metering_1 := as.numeric(Sub_metering_1)]
powerDT[, Sub_metering_2 := as.numeric(Sub_metering_2)]
powerDT[, Sub_metering_3 := as.numeric(Sub_metering_3)]
powerDT[, Voltage := as.numeric(Voltage)]
powerDT[, Global_reactive_power := as.numeric(Global_reactive_power)]

# Filter data for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Combine Date and Time into a POSIXct column
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")]

# Create the PNG file for the plot
png("plot4.png", width = 480, height = 480)

# Set up the 2x2 plotting space
par(mfrow = c(2, 2))

# Plot 1: Global Active Power
plot(
  powerDT$dateTime, 
  powerDT$Global_active_power, 
  type = "l", 
  xlab = "", 
  ylab = "Global Active Power"
)

# Plot 2: Voltage
plot(
  powerDT$dateTime, 
  powerDT$Voltage, 
  type = "l", 
  xlab = "datetime", 
  ylab = "Voltage"
)

# Plot 3: Energy sub metering
plot(
  powerDT$dateTime, 
  powerDT$Sub_metering_1, 
  type = "l", 
  xlab = "", 
  ylab = "Energy sub metering", 
  col = "black"
)
lines(
  powerDT$dateTime, 
  powerDT$Sub_metering_2, 
  col = "red"
)
lines(
  powerDT$dateTime, 
  powerDT$Sub_metering_3, 
  col = "blue"
)
legend(
  "topright", 
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
  col = c("black", "red", "blue"), 
  lty = 1, 
  cex = 0.7
)

# Plot 4: Global Reactive Power
plot(
  powerDT$dateTime, 
  powerDT$Global_reactive_power, 
  type = "l", 
  xlab = "datetime", 
  ylab = "Global Reactive Power"
)

# Close the PNG file
dev.off()

