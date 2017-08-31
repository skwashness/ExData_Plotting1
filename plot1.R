#Clean Environment & Perform Garbage Cleanup
rm(list=ls())
gc()

getwd()
setwd("C:/users/kchibanda002/R/Coursera/Exploratory_Analysis/Week_1/")

library(data.table)
library(lubridate)
library(plyr)
library(dplyr)

# Read data into R 

power <- read.table("household_power_consumption.txt", sep = ";", header = T)
str(power)

#Change Date format
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")


# Subset to only include Feb 1 and 2, 2007
power <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02",]

str(power)

#Change Time Format
power$Time <- format(strptime(power$Time, format="%H:%M:%S"), format = "%H:%M:%S")

######################Change remaining into numerics vector

#First assign column names to be changed into a
cols.num <- c("Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
              "Sub_metering_1", "Sub_metering_2")

# Using for loop, assign as numeric (need to assign as character first to avoid indexing)
for (i in colnames(power)[3:8]){
  power[,i] <- as.numeric(as.character(power[,i]))
}
  
# Create plot, with main and x axis title, as well as coloured bars
png(filename = "plot1.png", units="px", width = 480, height = 480)
hist(power$Global_active_power, main = "Global Active Power", 
     xlab= "Global Active Power (kilowatts)", col = "red")
dev.off()

