plot4 <- function(){
  sample.data <- ReadData()
  png(filename = "plot4.png",width=480,height=480)
  par(mfcol = c(2,2))
  
  # Plot 1
  plot(sample.data$Time,sample.data$Global_active_power,type="l",xlab="",ylab="Global Active Power")
  
  # Plot 2
  plot(sample.data$Time,sample.data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
  lines(sample.data$Time,sample.data$Sub_metering_2,col="red")
  lines(sample.data$Time,sample.data$Sub_metering_3,col="blue")
  legend(x = "topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
         ,lty=c(1,1,1),col=c("black","red","blue"))
  
  # Plot 3
  plot(sample.data$Time,sample.data$Voltage,type="l",xlab="datetime",ylab="Voltage")
  
  # Plot 4  
  plot(sample.data$Time,sample.data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
  
  dev.off()
}

ReadData <- function(){
  data.types <- c("character","character",rep("numeric",times=7))
  data <- read.table(file = "household_power_consumption.txt",header = TRUE,quote = "",sep=";",nrows=70000,na.strings = "?",colClasses = data.types)
  data$Time <- strptime(paste(data[,"Date"],data[,"Time"]),"%d/%m/%Y %H:%M:%S", tz="")
  data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
  valid.dates <- sapply(FUN = as.Date,c("2007-02-01","2007-02-02"),"%Y-%m-%d")
  sample.data <- data[data[,"Date"] %in% valid.dates,]
  sample.data
}