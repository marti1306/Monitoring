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

##2 day
## FOCAL on Cladonia

setwd("C:/lab/")
library(RStoolbox)
library(raster) # two function - we can use 1.raster(import one single layer, one bend) 2.brick(import several layers)
# now we have three layers so we need brick function

clad <- brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad, 1,2,3, stretch="lin")

#to measure variability and selection of the PC
#first we select the extection of the window to pass on top of the image
# we create a window to analyze the standard deviation of a 3x3 matrix, and so 3x3 pixel
# number one is an arbitrary value
window <- matrix(1, nrow = 3, ncol = 3)
window

#PCA analysis to see which componenet is the best to compute st.dev. 
library(RStoolbox) #for PCA

cladpca <- rasterPCA(clad)
cladpca

summary(cladpca$model) #98% of image info is contained in the first component

plotRGB(cladpca$map, 1, 2, 3, stretch='Lin')


#focal function applied to PC1 to identify the standard deviation of all the neighbours cells 
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)

PC1_agg <- aggregate(cladpca$map$PC1, fact=10) #to accelerate the calculation by aggregating the pixels by a factor of 10
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)

cl <- colorRampPalette(c('yellow','violet','black'))(100)
par(mfrow = c(1, 2))
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

# plot the calculation 
#it is telling us how much complex is the organism, with the violet and pink 
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)

