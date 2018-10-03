library(dplyr)
library(lubridate)

# 2 million lines - 9 variables ~ 64 bytes - memory usage estimate 1.150 MB
power <- read.csv("household_power_consumption.txt",sep=";")
object.size(power[0]) # check memory estimation

# select subset of power consumption on specific dates
power$Date <- as.Date(power$Date,format="%d/%m/%Y")
p <- filter(power,Date=="2007-02-01"|Date=="2007-02-02")


# clean data - text to datetime and numeric

p <- mutate(p,DateTime = ymd_hms(paste(Date,Time)))
p$Global_active_power <- as.numeric(as.character(p$Global_active_power))

# create plot2

png("plot2.png") # default size is 480 x 480
with(p,plot(DateTime,Global_active_power,type="l", y_lab = "Global Active Power (kilowatts)"))
dev.off()

