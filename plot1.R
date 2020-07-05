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

# Open png file
png("plot1.png", height = 480, width = 480)
# Create the plot
with(data_final,hist(data_final$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency",col = "red"))
dev.off()
