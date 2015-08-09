## Install required libraries if they're not present
if (!require("lubridate")) {
    install.packages("lubridate")
}

## Load required library for date and time manipulation.
library(lubridate)

## Checks if the dataset is present or attempts to download it otherwise.
if (!file.exists("./household_power_consumption.txt")) {
    if (!file.exists("./exdata-data-household_power_consumption.zip")) {
        fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "exdata-data-household_power_consumption.zip")
        
    }
    unzip("exdata-data-household_power_consumption.zip")
}

## Read the data into a table
bigDT <- read.table("household_power_consumption.txt",
        sep = ";",
        header = TRUE,
        na.strings = "?",
        stringsAsFactors = FALSE,
        colClasses = c("character", "character", rep("numeric", 7)))

## Subsets the date to a 2-day period in February, 2007
smallDF <- subset(bigDT, Date == "1/2/2007" | Date == "2/2/2007")

## Convert dates and times and create a new DateTime property, useful
## for the plots.
smallDF$Date <- dmy(smallDF$Date)
smallDF$Time <- hms(smallDF$Time)
smallDF$DateTime <- smallDF$Date + smallDF$Time

## Open png device
png(filename = "plot1.png", width = 480, height = 480)

## Make plot
hist(smallDF$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

## Closes device
dev.off()
