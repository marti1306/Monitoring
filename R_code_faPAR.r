##we're dealing on how to look at chemical cycling from satellite data

##on IOL there is the first part of the code on how to aggregate pixels of a copernicus image 

#the file that we use has been aggregated by the prof in order to reduce its size of download (aggregation by factor of 10)

library(raster)
library(rasterVis) #to make the levelplot
library(rasterdiv)

setwd("C:/lab/")


faPAR10 <- raster("faPAR10.tif") #function to import the data
pdf("faPAR.pdf")
levelplot(faPAR10) #in north emisphere the fapar is not that high as NDVI --> we're considering with this indicator not only biomass but also carbon intake

dev.off()
