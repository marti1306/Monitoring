###R_code_species_distribution_modelling.r

# install.packages("sdm")
# install.packages("rgdal")
library(sdm)
library(raster) #predictors - environmental factors affecting species distribution
library(rgdal) #to import layers- species

# species
file <- system.file("external/species.shp", package="sdm") #function to import file into the system
#it's a presence/absence dataset
species <- shapefile(file) #we use the graphical part of the file #shapefile 

species
species$Occurrence
plot(species)

plot(species[species$Occurrence == 1,],col='blue',pch=16)

points(species[species$Occurrence == 0,],col='red',pch=16)

# environmental variables
path <- system.file("external", package="sdm") #folder external within the package

lst <- list.files(path=path,pattern='asc$',full.names = T) #argument pattern: all the files having extension asc-
lst

preds <- stack(lst)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl) #vegetation index
points(species[species$Occurrence == 1,], pch=16)

# model
d <- sdmData(train=species, predictors=preds) #2 type of data in sdm: 1 is the  training dataset (measured in the fiels) and predictors
d

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods='glm') #glm=generalized linear model
#in models the equal is written with the tilde
#linear model - the most simple, usually it's used the logistic curve

#prediction
p1 <- predict(m1, newdata=preds) #predict function stands for prediction #newdata argument: the predictors

#final plot of probability distribution in space
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

#stack of the predictors
s1 <- stack(preds,p1)
plot(s1, col=cl)
