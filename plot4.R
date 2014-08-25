# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

require(stringi)
require(ggplot2)
require(plyr)

if(!exists("NEI")) {NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")) {SCC <- readRDS("Source_Classification_Code.rds")}

dataSCC <- SCC[, c('SCC', 'EI.Sector')]

isCoalCombustionRelated <- function(sector){
  if (stri_sub(sector, 1, 12) == 'Fuel Comb - '){
    if (stri_sub(sector, -7, -1) == ' - Coal'){
      return(1)  
    } 
  }
  return(0)
}

dataSCC <- cbind(
  dataSCC,
  CCR=mapply(isCoalCombustionRelated, dataSCC$EI.Sector))
dataSCC <- dataSCC[, c('SCC', 'CCR')]

if(!exists("dataMerge")) {dataMerge <- merge(NEI, dataSCC)}

data <- dataMerge[dataMerge$CCR==1, ]
data <- data[, c('Emissions', 'year')]
dataSum <- ddply(data, .(year), colwise(sum))
dataSum$Emissions <- dataSum$Emissions / 10^3

png("plot4.png", height=500, width=700)
plot(dataSum,
     main="Coal Combustion-Related Emissions for USA", 
     ylab="Kilo (10^3) Tons of Emissions", 
     xlab="Year", 
     col="red",
     ylim=c(0, 750))
lines(dataSum,
      col="green")
abline(dataSum,
       col="blue")
dev.off()