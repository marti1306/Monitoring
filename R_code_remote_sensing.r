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

