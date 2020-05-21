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

### day 3
## regression model between faPAR and NDVI
## we have two variable (x,y), and we can see the relation between them
# y= bx+a 
#b= the slope, a= the point of intersection with y (intercept)

erosion <- c(12, 14, 16, 24, 26, 40, 55, 67) #ex. amount of erosion in a certain area
hm <- c(30, 100, 150, 200, 260, 340, 460, 600) #ex. amount of heavy metals
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals")

 # the function used is lm --> LINEAR MODEL -> function lm(y~x)
model1 <- lm(hm ~ erosion)
summary(model1) # to have all the information about the model
#--> R^2 ranges between 1 and 0, the higher the better the variables are significantly related = pattern we observe is not random. p-valus is small, the pattern is not random. 
#variables are related
# in this case the equation is hm= 9.2751*erosion + (-26.9888)
#pvalue= it tells how many time the result expresses a random situation, if p is lower than 0.01 means lower prob (1/100) that is random, so the variables are related

abline(model1) #line described by a and b  #line related to the erosion and number of heavy metals

## faPAR vs NDVI model
setwd("C:/lab/")
library(raster) #to recognize the picture of faPAR
library(rasterdiv)
faPAR10 <- raster("C:/lab/faPAR10.tif")
#see number of cells in the raster = ncells
plot(faPAR10)
plot(copNDVI)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE) #to remove values of water data

#we have 2 parameters and we want how the the variables are related
# RANDOM SAMPLES
# function to make a random sample
install.packages("sf")
library(sf) # to call st_* functions
random.points <- function(x,n) # x= raster file; n = number of random points
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <-random.points(faPAR10,1000) #ex. we select 1000 points from faPAR10 #extract data and put them on a point. for each point we have the value of the variable

copNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10,pts)

copNDVIp #see the values of the points chosen by random procedure. NA = points in the sea


# photosyinthesis vs biomass
model2 <- lm(faPAR10p ~ copNDVIp)

#regression model for the relationship between the two variables
plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")
#there are some parts with high biomass and high faPAR(near red line)
# but also points with high biomass but low photosynthesis so they are far from red line
