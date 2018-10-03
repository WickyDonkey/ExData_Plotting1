library(dplyr)

# 2 million lines - 9 variables ~ 64 bytes - memory usage estimate 1.150 MB
power <- read.csv("household_power_consumption.txt",sep=";")
object.size(power[0]) # check memory estimation

# select subset of power consumption on specific dates
power$Date <- as.Date(power$Date,format="%d/%m/%Y")
p <- filter(power,Date=="2007-02-01"|Date=="2007-02-02")


# clean data - text to numeric

p$Global_active_power <- as.numeric(as.character(p$Global_active_power))

# plot 1

png("plot1.png") # default size is 480 x 480
with(p,hist(Global_active_power,col="red",main="Global Active Power",x_lab = "Global Active Power (kilowatts)", y_lab = "Frequency"))
dev.off()

