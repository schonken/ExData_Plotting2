# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?

require(ggplot2)
require(plyr)

if(!exists("NEI")) {NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")) {SCC <- readRDS("Source_Classification_Code.rds")}

data <- NEI[NEI$fips == 24510 & NEI$type=='ON-ROAD', c('Emissions', 'year')]
dataSumB <- ddply(data, .(year), colwise(sum))

data <- NEI[NEI$fips == "06037" & NEI$type=='ON-ROAD', c('Emissions', 'year')]
dataSumL <- ddply(data, .(year), colwise(sum))

Baltimore <- function(year){
  return('Baltimore City, Maryland')
}

LosAngeles <- function(year){
  return('Los Angeles County, California')
}

dataSumB <- cbind(dataSumB, City=mapply(Baltimore, dataSumB$year))
dataSumL <- cbind(dataSumL, City=mapply(LosAngeles, dataSumL$year))
dataSum <- rbind(dataSumB, dataSumL)

png("plot6.png", height=500, width=700)
p <- qplot(year, 
           Emissions, 
           data=dataSum,
           main='Motor Vehicle Related Emissions comparison between Baltimore and Los Angeles',
           ylab="Tons of Emissions", 
           xlab="Year", 
           color=City) +
  guides(colour=FALSE) +
  geom_line(aes( year, Emissions)) + 
  facet_grid(City ~ ., scales="free") +
  theme(strip.text.y = element_text(size = 14))
print(p)
dev.off()