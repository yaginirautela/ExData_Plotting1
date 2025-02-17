# Load necessary libraries
library(data.table)
library(lubridate)

# Set the working directory (adjust the path accordingly)
setwd("C:/Users/yagini/Documents/DataScienceCourse/eda1/ExData_Plotting1")

# Read in the data, treating '?' as missing values
powerDT <- fread("household_power_consumption.txt", na.strings="?")

# Convert 'Date' to Date type and 'Global_active_power' to numeric
powerDT[, Date := as.Date(Date, format="%d/%m/%Y")]
powerDT[, Global_active_power := as.numeric(Global_active_power)]

# Filter the data for the required dates (2007-02-01 to 2007-02-02)
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Check if there's any data left after filtering
if (nrow(powerDT) == 0) {
  stop("No data left after filtering the required dates.")
}

# Convert 'Date' and 'Time' into a single dateTime column
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")]

# Check the cleaned data (you can skip this if no issues are found)
print(head(powerDT))

# Create the PNG file for the plot
png("plot2.png", width = 480, height = 480)

# Create the line plot
plot(
  powerDT$dateTime, 
  powerDT$Global_active_power, 
  type = "l", 
  xlab = "", 
  ylab = "Global Active Power (kilowatts)"
)

# Close the PNG file
dev.off()

