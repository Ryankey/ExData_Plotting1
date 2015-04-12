plot2 <- function(){
  sample.data <- ReadData()
  png(filename = "plot2.png",width=480,height=480)
  plot(sample.data$Time,sample.data$Global_active_power,type="l",xlab="",ylab="Global Active Power (killowatts)")
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