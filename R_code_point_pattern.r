

#first function of 8th of April
setwd("C:lab")

load(point_pattern_analysis)

library(spatstat)

#let's plot the density map (D)

plot(d)

#points function show ppints on the top of previous map--> to see how much dense are the points in space

points(covids)

#now we start to upload geographyca info --> points, lines, ...

#we use coastlines file, we need gdal library

install.packages("rgdal")

library(rgdal)

#now we import the coastline file, we assign a function to the object
#let's input vector lines (x0y0, x1y1y...)


coastlines <- readOGR("ne_10m_coastline.shp")

#now we have let R speak with the outside, that is our computer.. we must check that everything is correct everytime we do this 

#argument add: means that add the lines to the previous plot
plot(coastlines, add=T)

#we got a density map with geographical info, how the density vary in space

#now we change the aspect, the colour of this map
#to change the colour, we say that we're making a palette
#the function is colorRampPalette
#we say within the parenthesis the colour we want--> we make a cluster of colour that is identified by "c"
#we can add an additional parenthesis for a separate argument --> ex. (100) it means that from yellow to orange there are 100 colours, the same from orange to red
cl <- colorRampPalette(c("yellow","orange","red"))(100)
plot(d,col=cl)
points(covids)
plot(coastlines,add=T)

#all these commands are necessary to specify to R that we want to change the colours of that specific plot

##EXERCISE: new colour ramp palette

cl1 <- colorRampPalette(c("green","yellow","red"))(50)

plot(d,col=cl1)
points(covids)
plot(coastlines,add=T)

#change the title to plot function
#using "main" argument

cl1 <- colorRampPalette(c("green","yellow","red"))(50)
plot(d,col=cl1, main="Densities of Covid-19")
points(covids)
plot(coastlines,add=T)

#let's see how to export the map, or any graph from R
#let's make a pdf into the lab folder
pdf("covid_density.pdf")

#now copy all the functions used to plot everything
cl1 <- colorRampPalette(c("green","yellow","red"))(50)
plot(d,col=cl1, main="Densities of Covid-19")
points(covids)
plot(coastlines,add=T)

#now we have to close the file, called device (but continuing to work in R)

dev.off()

#if we prefer to have a png file (an image) instead of pdf, the function is #png("covid_density.png")

#####that's a good example of how to  study ecosystems from a spatial point of view
#in this case it's not a study with time as a variable, since there is no time dimension in this plot




