library(data.table)

setwd("C:/Users/yagini/Documents/DataScienceCourse/eda2/ExData_Plotting1")  

powerDT <- fread("household_power_consumption.txt", na.strings = "?")

powerDT[, Date := as.Date(Date, format="%d/%m/%Y")]
powerDT[, Global_active_power := as.numeric(Global_active_power)]
powerDT[, Sub_metering_1 := as.numeric(Sub_metering_1)]
powerDT[, Sub_metering_2 := as.numeric(Sub_metering_2)]
powerDT[, Sub_metering_3 := as.numeric(Sub_metering_3)]
powerDT[, Voltage := as.numeric(Voltage)]
powerDT[, Global_reactive_power := as.numeric(Global_reactive_power)]

powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

powerDT[, dateTime := as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")]

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

plot(
  powerDT$dateTime, 
  powerDT$Global_active_power, 
  type = "l", 
  xlab = "", 
  ylab = "Global Active Power"
)

plot(
  powerDT$dateTime, 
  powerDT$Voltage, 
  type = "l", 
  xlab = "datetime", 
  ylab = "Voltage"
)

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

plot(
  powerDT$dateTime, 
  powerDT$Global_reactive_power, 
  type = "l", 
  xlab = "datetime", 
  ylab = "Global Reactive Power"
)

dev.off()

