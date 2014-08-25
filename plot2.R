# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

require(plyr)

if(!exists("NEI")) {NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")) {SCC <- readRDS("Source_Classification_Code.rds")}

data <- NEI[NEI$fips == 24510, c('Emissions', 'year')]
dataSum <- ddply(data, .(year), colwise(sum))
dataSum$Emissions <- dataSum$Emissions

png("plot2.png", height=500, width=700)
plot(dataSum,
     main="Emissions for Baltimore City, Maryland", 
     ylab="Tons of Emissions", 
     xlab="Year", 
     col="red",
     ylim=c(0, 5000))
lines(dataSum,
      col="green")
abline(dataSum,
       col="blue")
dev.off()