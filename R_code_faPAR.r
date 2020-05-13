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

###2nd day

setwd("C:/lab/")
load("faPAR.RData")

library(raster)
library(rasterdiv)

# the original faPAR from Copernicus is 2GB

#let's see how much space is needed for an 8bit set
#let's write a raster outside R
writeRaster(copNDVI, "copNDVI.tif")
#5.3 MB

library(rasterVis)

#exercise: make the levelplot of the faPAR
faPAR10 <- raster("faPAR10.tif")
levelplot(faPAR10)

