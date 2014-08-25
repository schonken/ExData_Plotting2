# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

require(plyr)

if(!exists("NEI")) {NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")) {SCC <- readRDS("Source_Classification_Code.rds")}

data <- NEI[NEI$fips == 24510 & NEI$type=='ON-ROAD', c('Emissions', 'year')]
dataSum <- ddply(data, .(year), colwise(sum))

png("plot5.png", height=500, width=700)
plot(dataSum,
     main="Motor Vehicle Related Emissions for Baltimore City, Maryland", 
     ylab="Tons of Emissions", 
     xlab="Year", 
     col="red",
     ylim=c(0, 500))
lines(dataSum, col="green")
dev.off()