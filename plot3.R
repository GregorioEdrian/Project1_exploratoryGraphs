# The data is in the folder of name "Data" the which is in the folder of the project current.

# Loading library for manipulate the data
library(dplyr)
library(tidyr)

# Loading data and filtering for the range necessary
DataPowerConsumption <- read.table("Data/household_power_consumption.txt", header = TRUE, sep=";")
DataPowerConsumption <- filter(DataPowerConsumption, Date=="1/2/2007" | Date == "2/2/2007")

# building the column in the "%Y-%m-%d %H-%M-%S" format from the Date and Time columns
DataPowerConsumption <- DataPowerConsumption %>% unite("Date/Time", c(1,2), sep = " ")
DataPowerConsumption$`Date/Time` <- strptime(DataPowerConsumption[,"Date/Time"], format ="%d/%m/%Y %H:%M:%S")

# converting to the data type needed for the graph and extracting the data needed for the graph
for (i in 6:8) { DataPowerConsumption[, i] <- as.numeric(DataPowerConsumption[,i])}
for (i in 6:8) { filter( DataPowerConsumption, !is.na(DataPowerConsumption[,i]) )}

# Generating the corresponding graph

plot(DataPowerConsumption[,1], DataPowerConsumption[,"Sub_metering_1"], type = "l", xlab = "", ylab ="Energy sub metering")
points(DataPowerConsumption[,1], DataPowerConsumption[,"Sub_metering_2"] , type = "l", col= "red")
points(DataPowerConsumption[,1], DataPowerConsumption[,"Sub_metering_3"] , type = "l", col= "blue")

names_leg <- c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
legend(x="topright", lty = c(1,1,1) , col = c("black", "red", "blue"), legend = names_leg, cex = 0.6, text.font = 4)
title(main = "Energy sub metering vs Date/Time")

dev.copy(png, file= "plot3.png")
dev.off()



