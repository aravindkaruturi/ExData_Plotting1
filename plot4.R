#Reading the data 
data <- read.table("household_power_consumption.txt",header = TRUE, sep = ";",stringsAsFactors = FALSE)
library(dplyr)
library(lubridate)
#data1 <- data %>% select(Date,Time,Global_active_power,Sub_metering_1,Sub_metering_2,Sub_metering_3)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
str(data)

#Converting Date variable to Date class
data$Date <- as.Date(parse_date_time(data$Date,"dmy"))
str(data)

#Filter out data corresponding to dates:- 01-02-2007 and 02-02-2007
data_final <- data %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

# Combine date and time and change the format to time class
day <- as.POSIXct(paste(data_final$Date,data_final$Time), format = "%Y-%m-%d %H:%M:%S")
final <- data_final %>% mutate(day)

#Open png file
png("plot4.png",height = 480,width = 480)
#Create plot
par(mfrow= c(2,2))
with(final,{
        plot(final$day,final$Global_active_power,type = "n",xlab = "",ylab = "Global Active Power (kilowatts)")
        lines(final$day,final$Global_active_power)
})

with(final,{
        plot(final$day,final$Voltage,type = "l",xlab = "datetime",ylab = "Voltage")
})

with(final,{
        plot(final$day,final$Sub_metering_1,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")
        lines(final$day,final$Sub_metering_1)
        lines(final$day,final$Sub_metering_2,col = "red")
        lines(final$day,final$Sub_metering_3,col = "blue")
        legend("topright",pch = "-",cex = 0.6,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})

with(final,{
        plot(final$day,final$Global_reactive_power,type = "n",xlab = "datetime",ylab = "Global Reactive Power (kilowatts)")
        lines(final$day,final$Global_reactive_power)
})
dev.off()

         
         
         
         
