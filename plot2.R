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
## Change a data format
newtime <- strptime(paste(newdata$Date,newdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
totaldat <- cbind(newtime,newdata)

## Set loacation
Sys.setlocale("LC_ALL", "English")

## Plot a line graph
plot(totaldat$newtime, totaldat$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab="") 

## Save the graph as a .png file
dev.copy(png, file = paste0(filePath, "/data/plot2.png"))
dev.off()
