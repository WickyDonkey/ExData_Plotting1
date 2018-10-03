library(dplyr)
library(lubridate)

# read input file
power <- read.csv("household_power_consumption.txt",sep=";")


# select subset of power consumption on specific dates
power$Date <- as.Date(power$Date,format="%d/%m/%Y")
p <- filter(power,Date=="2007-02-01"|Date=="2007-02-02")


# clean data - convert text to datetime and numeric

p <- mutate(p,DateTime = ymd_hms(paste(Date,Time)))
p$Global_active_power <- as.numeric(as.character(p$Global_active_power))
p$Global_reactive_power <- as.numeric(as.character(p$Global_reactive_power))
p$Sub_metering_1 <- as.numeric(as.character(p$Sub_metering_1))
p$Sub_metering_2 <- as.numeric(as.character(p$Sub_metering_2))
p$Sub_metering_3 <- as.numeric(as.character(p$Sub_metering_3))
p$Voltage <- as.numeric(as.character(p$Voltage))


# create plot4

png("plot4.png") # default size is 480 x 480

par(mfrow =c(2,2))

with(p,plot(DateTime,Global_active_power,type="l"))

with(p,plot(DateTime,Voltage,type="l"))

with(p,plot(DateTime,Sub_metering_1,xlab="", ylab="Energy sub metering",type="n" ))
with(p,points(DateTime,Sub_metering_1,col="black",type="l"))
with(p,points(DateTime,Sub_metering_2,col="red",type="l"))
with(p,points(DateTime,Sub_metering_3,col="blue",type="l"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty=1)

with(p,plot(DateTime,Global_reactive_power,type="l"))
dev.off()

