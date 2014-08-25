# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

require(plyr)

if(!exists("NEI")) {NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")) {SCC <- readRDS("Source_Classification_Code.rds")}

data <- NEI[, c('Emissions', 'year')]
dataSum <- ddply(data, .(year), colwise(sum))
dataSum$Emissions <- dataSum$Emissions / 10^3

png("plot1.png", height=500, width=700)
plot(dataSum,
         main="Emissions for USA", 
         ylab="Kilo (10^3) Tons of Emissions", 
         xlab="Year", 
         col="red",
         ylim=c(0, 8000))
lines(dataSum,
      col="green")
abline(dataSum,
       col="blue")
dev.off()