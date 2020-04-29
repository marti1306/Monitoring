## assessing the biomass through NDVI in order to see the potential in terms of ecosystem functions of analyzed ecosystems

#code to view biomass over the world and calculate changes in ecosystem functions

##energy, chemical cycling
##LUCC: land use and climate changes

#raster data are all data based on pixel

#we're going to show the medium value of biomass for several years (1999-2017)

install.packages("rasterdiv")
install.packages("rasterVis")

library(rasterdiv)
library(rasterVis)

data(copNDVI) #it's the NDVI of Copernicus

plot(copNDVI)

#we are going to reclassify the data because some of them are referred to the water-->  we removed the water
#cbind delate the values within the brackets

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

#levelplot
levelplot(copNDVI)
#we got the mean biomass over 30 years
#the pixels are 8km square

#close to the poles there are no plants so the NIR values are low, while on the contraries in forests we have high NIR and so hig DVI
#ecosystem functions and services in the deserts are very few
#latitude is controlling biomass
#the graph on the right (of the previous levelplot) is a plot with on x axis mean DVI values and on y axis the latitude
#similar is for the upper part graph, where on the x axis there are mean DVI values, while on y axis longitude

copNDVI10 <- aggregate(copNDVI, fact=10) #we increase the pixel dimension of factor ten
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100) 
