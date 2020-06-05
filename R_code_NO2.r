#NO2 levels over Italy pre- and during- Covid 19

setwd("C:/lab/NO2")
library(raster)

#import NO2 data with lapply function
no2list <- list.files(pattern="EN")
no2list

import <- lapply(rlist, raster)
EN <- stack(import)
cl <- colorRampPalette(c('red','orange','light blue'))(100) 
plot(EN, col=cl)
    
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)
dev.off() #to cancel the par

#plot the image 001. 007 and 013 with the RGB system: in this way if the values of 001 are higher the color will be red (as we assign  to the 001 image the red band)(and the same for the other colors and bands)
plotRGB(no2.multitemp, r=1, g=7, b=13, stretch="lin") #nice graph! #RGB space is one of the best way to view spatial data with colors

##difference map: difference between last image and first image: 013 and 001 #but not always the last and the first images are the best way to see the differences 
dif <- EN$EN_0013- EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dif, col=cld)

#quantitative estimate #boxplot
boxplot(EN)

#to remove the outliers
boxplot(EN,outline=F)

#to put the boxplot horizontally and with the axis shown
boxplot(EN,outline=F, horizontal=T, axes=T)

#plot the data of first image and last one
plot(EN$EN_0001, EN$EN_0013)
#now we put the 1 to 1 line: ab line --> it's the y=x axis (the one at 45°)
plot(EN$EN_0001, EN$EN_0013)
abline(0,1,col="red") #manyvalues are below the line: it means that there has been a decrease of values between the 2 images
