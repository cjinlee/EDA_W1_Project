## Download the data file
filePath <- getwd()
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip DataSet to the data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Read the dataset
data <- read.table(file.path(filePath, "data", "household_power_consumption.txt"),
                   sep =";",header=T, na.strings = "?")

## Subset the dataset
newdata <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]
newtime <- strptime(paste(newdata$Date,newdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
totaldat <- cbind(newtime,newdata)

## Set loacation
Sys.setlocale("LC_ALL", "English")

## Open .png file
png(filename = paste0(filePath, "/data/plot4.png"), width = 480, height = 480)

## Draw a plot
par(mfrow = c(2,2), mar = c(5.1, 4.5, 2, 2.1))
plot(totaldat$newtime, totaldat$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab="")
plot(totaldat$newtime, totaldat$Voltage, type = "l", 
     ylab = "Voltage", xlab="datetime")
plot(totaldat$newtime, totaldat$Sub_metering_1, ylab = "Energy sub metering", xlab = "", 
     type = "l", col = "black")
par(new = T)
plot(totaldat$newtime, totaldat$Sub_metering_2, ann = F, xaxt = "n", yaxt = "n", 
     type = "l", col = "red", ylim = c(0,30))
par(new = T)
plot(totaldat$newtime, totaldat$Sub_metering_3, ann = F, xaxt = "n", yaxt = "n", 
     type = "l", col = "blue", ylim = c(0,30))
labs <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", bty = "n", legend = labs, col = c("black", "red", "blue"), 
       lty = "solid", cex = 0.5)
plot(totaldat$newtime, totaldat$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab="datetime", ylim = c(0.0,0.5))

## Close the file
dev.off()