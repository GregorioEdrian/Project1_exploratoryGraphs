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
DataPowerConsumption[, "Global_active_power"] <- as.numeric(DataPowerConsumption[,"Global_active_power"])
DataPowerConsumption <- DataPowerConsumption %>% select("Date/Time", "Global_active_power")%>% filter(!is.na(Global_active_power))

# Generating the corresponding graph
plot(DataPowerConsumption[,1], DataPowerConsumption[,2], type = "l", xlab = "", ylab ="Global Active Power (kilowatts)" )
title(main = "Global Active Power vs Date/Time")
dev.copy(png, file= "plot2.png")
dev.off()
