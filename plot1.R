library(data.table)

setwd("C:/Users/yagini/Documents/DataScienceCourse/eda1/ExData_Plotting1")

powerDT <- fread("household_power_consumption.txt", na.strings="?")

powerDT[, Global_active_power := as.numeric(Global_active_power)]
powerDT[, Date := as.Date(Date, format="%d/%m/%Y")]

powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

powerDT <- powerDT[!is.na(Global_active_power)]

head(powerDT)

png("plot1.png", width=480, height=480)

hist(
  powerDT$Global_active_power, 
  main="Global Active Power", 
  xlab="Global Active Power (kilowatts)", 
  ylab="Frequency", 
  col="red"
)

dev.off()

