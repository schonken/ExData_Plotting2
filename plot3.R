# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for 
# Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 
# plotting system to make a plot answer this question.

require(ggplot2)
require(plyr)

if(!exists("NEI")) {NEI <- readRDS("summarySCC_PM25.rds")}
if(!exists("SCC")) {SCC <- readRDS("Source_Classification_Code.rds")}

data <- NEI[NEI$fips == 24510, c('Emissions', 'year', 'type')]
dataSum <- ddply(data, .(year,type), colwise(sum))

png("plot3.png", height=500, width=700)
p <- qplot(year, 
           Emissions, 
           data=dataSum,
           main='Emissions per Emission Source for Baltimore City, Maryland',
           ylab="Tons of Emissions", 
           xlab="Year", 
           color=type) +
  scale_colour_discrete(name = "Emission Source") +
  geom_line(aes( year, Emissions)) +
  theme(legend.title=element_text(size=14), legend.text=element_text(size=12))
  print(p)
dev.off()