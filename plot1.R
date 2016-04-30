## Download the data file
filePath <- getwd()
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip DataSet to the data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Read the dataset
data <- read.table(file.path(filePath, "data", "household_power_consumption.txt"),sep =";",header=T, na.strings = "?")

## Subset the dataset
newdata <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]

## Draw a histogram
hist(newdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Save the histogram as a .png file
dev.copy(png, file = paste0(filePath, "/data/plot1.png"))
dev.off()

