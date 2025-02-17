
library(data.table)


setwd("C:/path/to/your/repository")  


powerDT <- fread("household_power_consumption.txt", na.strings = "?")


powerDT[, Date := as.Date(Date, format="%d/%m/%Y")]
powerDT[, Global_active_power := as.numeric(Global_active_power)]
powerDT[, Sub_metering_1 := as.numeric(Sub_metering_1)]
powerDT[, Sub_metering_2 := as.numeric(Sub_metering_2)]
powerDT[, Sub_metering_3 := as.numeric(Sub_metering_3)]


powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]


powerDT[, dateTime := as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")]

png("plot3.png", width = 480, height = 480)


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
  lty = 1
)


dev.off()

