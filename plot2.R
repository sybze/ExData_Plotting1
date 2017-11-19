#Loading the data and packages
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
png(file="plot2.png")
plot(Global_active_power~date, data=short, xlab="", ylab="Global Active Power (kilowatts)", type="line")
dev.off()