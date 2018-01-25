plot.3 <- function(file.name = "household_power_consumption.txt"){
    if ("dplyr" %in% rownames(installed.packages()) == FALSE){
        install.packages("dplyr")
    }
    if ("lubridate" %in% rownames(installed.packages()) == FALSE){
        install.packages("lubridate")
    }
    library(dplyr)
    library(lubridate)
    electric.data <- read.table(file.name, header = TRUE, sep = ";", 
                                na.strings = "?", stringsAsFactors = FALSE)
    electric.data$Date <- as.Date(electric.data$Date, "%d/%m/%Y")
    electric.data <- filter(electric.data, Date >= "2007-02-01" & 
                                Date <= "2007-02-02")
    electric.data <- mutate(electric.data, Date_Time = 
                                paste(Date, Time, sep = " "))
    electric.data$Date_Time <- ymd_hms(electric.data$Date_Time)
    png(filename = "plot3.png")
    with(electric.data, plot(Date_Time, Sub_metering_1, type = "l", main = "",
                             xlab = "", ylab = "Energy sub metering"))
    with(electric.data, points(Date_Time, Sub_metering_2, type = "l", 
                               col = "red"))
    with(electric.data, points(Date_Time, Sub_metering_3, type = "l", 
                               col = "blue"))
    legend("topright", names(electric.data[, 7:9]), col = c("black", "red", "blue"), lty = 1)
    dev.off()
}