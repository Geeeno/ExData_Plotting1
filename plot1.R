plot.1 <- function(file.name = "household_power_consumption.txt"){
    if ("dplyr" %in% rownames(installed.packages()) == FALSE){
        install.packages("dplyr")
    }
    library(dplyr)
    electric.data <- read.table(file.name, header = TRUE, sep = ";", 
                                na.strings = "?", stringsAsFactors = FALSE)
    electric.data$Date <- as.Date(electric.data$Date, "%d/%m/%Y")
    electric.data <- filter(electric.data, Date >= "2007-02-01" & 
                                Date <= "2007-02-02")
    png(filename = "plot1.png")
    with(electric.data, hist(Global_active_power, col = "red", 
                               main = "Global Active Power", 
                               xlab = "Global Active Power (kilowatts)", 
                               ylab = "Frequency"))
    dev.off()
}