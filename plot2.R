#Reading the data 
data <- read.table("household_power_consumption.txt",header = TRUE, sep = ";",stringsAsFactors = FALSE)
library(dplyr)
library(lubridate)
data1 <- data %>% select(Date,Time,Global_active_power)
data1$Global_active_power <- as.numeric(data1$Global_active_power)

#Converting Date variable to Date class
data1$Date <- as.Date(parse_date_time(data1$Date,"dmy"))
str(data1)

#Filter out data corresponding to dates:- 01-02-2007 and 02-02-2007
data_final <- data1 %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

# Combine date and time and change the format to time class
day <- as.POSIXct(paste(data_final$Date,data_final$Time), format = "%Y-%m-%d %H:%M:%S")
final <- data_final %>% mutate(day)

# Open png file
png("plot2.png",height = 480,width = 480)
#Create plot
with(final,{
        plot(final$day,final$Global_active_power,type = "n",xlab = "",ylab = "Global Active Power (kilowatts)")
        lines(final$day,final$Global_active_power)
})
dev.off()
