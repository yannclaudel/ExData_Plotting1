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
par(mfrow = c(1, 1))
plot(data$tm,data$Sub_metering_1, type = "l", main = "", ylab = "Energy sub metering", xlab = "")
lines(data$tm,data$Sub_metering_2, col="red")
lines(data$tm,data$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red","blue"), legend = c("Sub_metering_1 ", "Sub_metering_2 ","Sub_metering_3 "),lty=c(1,1,1))

dev.copy(png, file = "plot3.png")  
dev.off() 

