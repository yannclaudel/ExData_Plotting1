url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.txt"
if(!file.exists(filename)) {
    download.file(url, "dataset.zip")
    unzip("dataset.zip")
    unlink("dataset.zip")
}

# date 
date1<-as.Date("2007-02-01")
date2<-as.Date("2007-02-02")
# load data
init <- read.csv(filename,sep=";",header = TRUE,na.strings='?', nrows = 100)
classes <- sapply(init, class)
data <- read.csv(filename,sep=";",header = TRUE,na.strings='?',colClasses = classes)
data[,"Date"]<-as.Date(strptime(data[,"Date"], "%d/%m/%Y"))
data<-data[data[,"Date"]==date1 | data[,"Date"]==date2,]
data$tm<- strptime(paste(data[,"Date"],data[,"Time"]),"%Y-%m-%d %H:%M:%S")

# draw graph
par(mfrow = c(2, 2))
# graph 1
plot(data$tm,data$Global_active_power, type = "l", main = "", ylab = "Global Active Power (kilowatts)", xlab = "")
# graph 2
plot(data$tm,data$Voltage, type = "l", main = "", ylab = "Voltage", xlab = "datetime")
# graph 3
plot(data$tm,data$Sub_metering_1, type = "l", main = "", ylab = "Energy sub metering", xlab = "")
lines(data$tm,data$Sub_metering_2, col="red")
lines(data$tm,data$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red","blue"), legend = c("Sub_metering_1 ", "Sub_metering_2 ","Sub_metering_3 "),lty=c(1,1,1),bty='n')
# graph 4
plot(data$tm,data$Global_reactive_power, type = "l", main = "", ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png, file = "plot4.png")  
dev.off() 

