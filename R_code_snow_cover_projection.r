#R_code_snow.r #using Copernicus data #snow as environmental indicator
#aim of this code: make future projections!

setwd("C:/lab/")

library(ncdf4)
library(raster)

#to import the file:
#2 functions: raster (uploads only one layer), brick (import several layers at a time-ex satellite image with different bands)

snowmay <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")

#let's plot the data
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snowmay, col=cl)

snowmay #to see the number of pixels

####
#download the data snow.zip
#it contains several datasets
#to import all the data together: create a folder into lab and put all the snow files there 

##how to import the data:
#1. slow manner to import the set: setting the working directory not any more into lab but to snow
#1. setwd("C:/lab/snow/")
snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")

par(mfrow=c(2,3))
plot(snow2000,col=cl)
plot(snow2005,col=cl)
plot(snow2010,col=cl)
plot(snow2015,col=cl)
plot(snow2020,col=cl)

#2. fast way to import data:
#lapply function: it applies a certain function (in this case raster in order to import several layers) to several elements

rlist <- list.files(pattern="snow") #make a list of the files in a certain place. Need to write the pattern (common letters in the name of the files) that all the elements share 
#this is the list to which we want to apply a certain function specified by lapply

import <- lapply(rlist, raster) #now we imported all the files

#now we do a stack: we take different layers and put together in a single object! -->  easier to work with rather than many different files
snow.multitemp <- stack(import)
snow.multitemp

plot(snow.multitemp, cl) 
#this method of importing data (using lapply function) is faster, less lines of code
#this method is important because monitoring need several data as it monitors changes in time

###let's make now predictions! given current Temperature let's see how the snow cover will change
#to make prediction it has to be specified the prediction function that connect the data and gives the data of the future: ex. it could be linear or exponential
## prediction:
source("prediction.r") #source is a function to launch the whole code! --> time saving

#####the prediction code 
#library(raster)
#library(rgdal)

# define the extent
#ext <- c(-180, 180, -90, 90)
#extension <- crop(snow.multitemp, ext)
    
# make a time variable (to be used in regression)
#time <- 1:nlayers(snow.multitemp)

# run the regression - linear model 
#fun <- function(x) {if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 
#predicted.snow.2025 <- calc(extension, fun) # time consuming: make a pause!
#predicted.snow.2025.norm <- predicted.snow.2025*255/53.90828


###2nd day
setwd("C:/lab/snow/")
library(raster)

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)

#to see the prediction map
load("name.RData")

#or
prediction <- raster("predicted.2025.norm.tif") #raster function as it is only a single image 
plot(prediction, col=cl)

#how to export the output:
writeRaster(prediction, "final.tif") #within quotes there is the title that you give to the output

#let's make  a final stack with all the images, including the prediction
final.stack <- stack(snow.multitemp, prediction)

#export the R Graph
pdf("my_final_graph.pdf") #it can be done also with png extension using png function instead of pdf
plot(final.stack, col=cl)
dev.off()







