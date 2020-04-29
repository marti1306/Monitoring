##REMOTE SENSING

install.packages(c("raster","RStoolbox"))

setwd("C:/lab/")

library(raster) #package used for remote sensing

#brick function is importing a compact set of different bands (each bands represents the reflectance of different pixels in a particular wavelenght)
#grd extension is an image, it's a grid (as a network of pixels)

p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)
#vegetation is reflecting the NIR and the green. 
#Bands of LANDSAT
# B1: blue
# B2: green
# B3: red
# B4: near infrared (nir) 
# B5: medium infrared
# B6: thermal infrared
# B7: medium infrared

#let's plot the image with a different colour ramp palette

cl<- colorRampPalette(c("black","grey","light grey"))(100)

#exercise, plot the data with the new RampPalette
plot(p224r63_2011, col=cl)
#the 4th band highly reflects the nir (image is light grey)

#to make a multiframe of different plots all together we use the function par
#mfrow stands for multiframe row, c(2,2) means that we use 2 columns and 2 rows

par(mfrow=c(2,2)) #we make a graph with 4 bands

#B1: blue
clb<- colorRampPalette(c("dark blue","blue","light blue"))(100)
#dollar is used to link the band to the spectral image
plot(p224r63_2011$B1_sre, col=clb)

#B2: green

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(p224r63_2011$B2_sre, col=clg)


#B3: red
clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(p224r63_2011$B3_sre, col=clr)

#B4: NIR
cln <- colorRampPalette(c("red","orange","yellow"))(100)
plot(p224r63_2011$B4_sre, col=cln)

#####

#let's make a graph with 4 row and just 1 column
par(mfrow=c(4,1))

#B1: blue
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
#dollar is used to link the band to the spectral image
plot(p224r63_2011$B1_sre, col=clb)

#B2: green

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(p224r63_2011$B2_sre, col=clg)


#B3: red
clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(p224r63_2011$B3_sre, col=clr)

#B4: NIR
cln <- colorRampPalette(c("red","orange","yellow"))(100)
plot(p224r63_2011$B4_sre, col=cln)


dev.off()

#RGB -- there are 3 components (red,green,blue), we show the satellite image with natural colours
#plot by RGB function, we associate the red (B3), green(B2) blue (B1)bands with the corresponding colours
#stretch in order to see colours better --> it's linear
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #the numbers stands for the number of the bands (B3,B2,B1)

#now we see the image as our human eye could see it from the satellite
#plant reflect a lot the NIR, so now we introduce the NIR (B4), we can decide to  put it in the red component (al posto di B3) shifting all the band and in this way deleting the B1

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#so here the NIR band is on the top of the red component of the RGB
#we see better the water in the forest and new areas that are being opened within the forest

#exercise: put the NIR on top of the Green component of the RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#now we see perfectly the water
#we see the bare soil in violet

#let's put the NIR in the blue component
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#the bare soil is in yellow colour


###### SECOND DAY

setwd("C:/lab/")
load("rs.RData")
library(raster)
p224r63_1988 <- brick("p224r63_1988_masked.grd")

p224r63_1988
plot(p224r63_1988)

#so now we want to compare the images of different years
#exercise: plot in visible RGB 321 both images
par(mfrow=c(2,1))

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#exercise: plot in RGB 432

par(mfrow=c(2,1))

plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

##let's see the real noises in these images -- hot to enhance the noise
##it enhance the level of noise (like presence of clouds--> noise due to evapotranspiration of the environment)
par(mfrow=c(2,1))

plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist") #hist stands for histogram: it stretches the noise
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#the level of noise is a powerful ecological indicator of the evapotranspirative level of the forest! 
#in the 1988 there is more noise--> the amazon forest was more alive, there was more humidity

#Bands of LANDSAT
# B1: blue
# B2: green
# B3: red: B3_sre (spectrum reflectance)
# B4: near infrared (nir) 

##we want to see the DVI: NIR-RED

dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
cl <- colorRampPalette(c("darkorchid3", "light blue", "lightpink4"))(100)
plot(dvi2011,col=cl)
#the image that we got has th DVI not homogenous--> due to the presence of water, streams within the forest

#exercise: DVI for 1988
dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
cl <- colorRampPalette(c("darkorchid3", "light blue", "lightpink4"))(100)
plot(dvi1988,col=cl)


#to make the difference between the 2 years
diff <- dvi2011-dvi1988
plot(diff)
#green values represent where the DVI difference was higher

#it's important at the scale on which we make the analysis .. because we may acquire or loose info by changing the scale
#to change the scale we modify the grain (for RS it's the same or resolution: the dimension of pixels)
#so now let's change it--> we use the aggregate function: it aggregates pixels in order to 
#the higher is the dimension of pixel (coarser grain), the lower is the capability to see objects --> so smaller pixel have a higher resolution.
#high resolution data can provide infos as tree heights or tree temperature --> it can be used to study microclimate

#fact argument stands for the amount of time we want ot increase the pixel dimension (from 30 to 90, the factor is 3)

p224r63_2011res <- aggregate(p224r63_2011, fact=10) #res stands for resembling (the dimension of pixels)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)


par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

#LANDSAT images have a resolution of 30mx30m (--> size of the pixels: medium resolution)


#### THIRD DAY: Rcode DVI deforestation

#download defor1 and defor2 images. 

setwd("C:/lab/)

library(raster)

defor1 <- brick("defor1_.jpg")
#let's brick the 2nd raster
defor2 <- brick("defor2_.jpg")

#let's plot the 2 rasters in RGB space
#we put the NIR on top of the Red, the Red on top of the Green and the Green band on top of the Blue band
#band1:NIr  defor1_.1
#band2:red  defor1_.2
#band3:green
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin") #we stretch in order to allow all the colors to be seen
#this plot show the amazon forest patch before agriculture came. 

plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#par function to create a multiframe
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2 ##to calculate the dvi of the first image, we made the difference between the NIR band and the RED band
dvi2 <- defor2$defor2_.1 - defor2$defor2_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2,col=cl)

difdvi <- dvi1 - dvi2 #difference of dvi

dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)
# the plot that we got shows in red the areas with high difference of dvi, 

hist(difdvi) #to make histogram of the difference of dvi

##so with this exercise we saw how to visualizev the difference of an indicator over time
