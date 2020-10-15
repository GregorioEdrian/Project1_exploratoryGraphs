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

# converting to data type necessary for the graph
DataPowerConsumption[, 2] <- as.numeric(DataPowerConsumption$Global_active_power)

# Generating the corresponding graph
hist(DataPowerConsumption$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.copy(png, file= "plot1.png")
dev.off()
