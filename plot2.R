plot.2 <- function(file.name = "household_power_consumption.txt"){
    
    # Check if needed libraries are loaded
    
    if ("dplyr" %in% rownames(installed.packages()) == FALSE){
        install.packages("dplyr")
    }
    if ("lubridate" %in% rownames(installed.packages()) == FALSE){
        install.packages("lubridate")
    }
    library(dplyr)
    library(lubridate)
    
    # Check if there are correct file
    
    file.name <- "./household_power_consumption.txt"
    if(!file.exists(file.name)){
        if(file.exists("./exdata.zip")){
            unzip("./exdata.zip")
        }else{
            stop("Missed files")
        }
    }
    
    # Load data
    
    electric.data <- read.table(file.name, header = TRUE, sep = ";", 
                                na.strings = "?", stringsAsFactors = FALSE)
    electric.data$Date <- as.Date(electric.data$Date, "%d/%m/%Y")
    electric.data <- filter(electric.data, Date >= "2007-02-01" & 
                                Date <= "2007-02-02")
    electric.data <- mutate(electric.data, Date_Time = 
                                paste(Date, Time, sep = " "))
    electric.data$Date_Time <- ymd_hms(electric.data$Date_Time)
    
    # Create Plot
    
    png(filename = "plot2.png")
    with(electric.data, plot(Date_Time, Global_active_power, type = "l", 
                             main = "",  
                             xlab = "", 
                             ylab = "Global Active Power (kilowatts)"))
    dev.off()
}