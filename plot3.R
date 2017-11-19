#Loading the data and required packages
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="power.zip")
unzip("power.zip")
file.remove("power.zip")
power<-read.table("household_power_consumption.txt", header=TRUE, sep=";")
library(plyr)
library(dplyr)

#Shortening and formating
short<-filter(power, Date %in% c("1/2/2007", "2/2/2007"))
rm(power)
short <- mutate(short, date=paste(Date, Time))
short$date<-as.POSIXct(strptime(short$date, "%d/%m/%Y %H:%M:%S"))
short<-select(short, date, 3:9)
short[,2:7]<-lapply(short[,2:7],as.character)
short[,2:7]<-lapply(short[,2:7],as.numeric)

#Creating the graph
png(file="plot3.png")
plot(Sub_metering_1~date, data=short, xlab="", ylab="Energy sub metering", type="l")
with(short, points(date, Sub_metering_2, col="red", type="l"))
with(short, points(date, Sub_metering_3, col="blue", type="l"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
dev.off()