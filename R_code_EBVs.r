#essential biodiversity variables
#code to measure standard deviation as proxy of heterogeneity --> biodiversity 

setwd("C:/lab/")
library(raster)
#brick function import all the bands of the satellite image
snt <- brick("snt_r10.tif") #snt stands for sentinel
snt #4 different bands
plot(snt) #default colors of R
plotRGB(snt, 3, 2, 1, stretch="lin") #as human eye might see it
plotRGB(snt, 4, 3, 2, stretch="lin") #the NIR over the red component

#standard deviation can be measured only on one layer, not on many layers together --> it can be calculated for a whole raster by a moving window, that pixel by pixel calculate the st. dev. - in the central pixel)

pairs(snt) #the relationship between the various bands

library(RStoolbox) #for PCA --> PCA analysis is done to see which component can be used to calculate standard deviation
#PCA analysis
sntpca <- rasterPCA(snt)
sntpca #we can see how much information is carried by the first component, and conversely how much of the diversity isn't seen by the 1st component
summary(sntpca$model) #to see the importance of each component --> comp 1 = 0.70 --> 70% of information
plot(sntpca$map) 
plotRGB(sntpca$map, 1, 2, 3, stretch="lin") #to show the variability of the image in a "psychedelic way"

### diversity measurement
#first: set the moving window 
window <- matrix(1, nrow = 5, ncol = 5) 
window

sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd) #w stands for window #focal function: we're going to make calculation on a certain extent
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plot(std_sntr, col=cl)
plotRGB(sd_snt, 4, 3, 2, stretch="lin")











# plot(std_snt8bit, col=cl)

std_sntr1 <- focal(snt_r$prova5_.1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(std_sntr1, col=cl)

### PCA related sd
library(RStoolbox)
sntrpca <- rasterPCA(snt_r)

summary(sntrpca$model) 

clp <- colorRampPalette(c('dark grey','grey','light gray'))(100) # 
plot(sntrpca$map,col=clp)

plotRGB(sntrpca$map,1,2,3,stretch="lin")

std_sntrpca <- focal(sntrpca$map$PC1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(std_sntrpca, col=cl)

##############
