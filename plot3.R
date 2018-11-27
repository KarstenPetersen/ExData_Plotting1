# plot #3
library(lubridate)

setwd("D:/Data/Karsten/R")
data <- read.table("household_power_consumption.txt",sep=";", header = T,stringsAsFactors = F)
data_backup <- data

str(data)
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data$Time <- strptime(data$Time,"%H:%M:%S")

# keep only time part of 'Time'
data$Time <- format(data$Time, format="%H:%M:%S")
#combine date and time in one variable
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# keep only required subset of data
data <- subset (data,Date=="2007-02-01" | Date=="2007-02-02")
table(data$Date)

# convert columns 3:8 to numeric
for (i in 3:8) data[,i] <- as.numeric(data[,i])

#are there NA's in data?
anyNA(data)

# plot 3
png("plot3.png",width=480,height=480,units="px")

plot (data$datetime,data$Sub_metering_1,type="n",ylab="Energy sub metering",xlab=" ")
lines(data$datetime,data$Sub_metering_1,col="black")
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")
legend("topright", legend=colnames(data)[7:9], col=c("black","red","blue"),ncol=1,cex=1,lty=1)
dev.off()
