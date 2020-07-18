###########R_code_exam.r

#INDEX:
#1. R first code
#2. R_code_multipanel.r
#3. R_code_spatial.r
#4. R_code_point_pattern.r
#5. R_code_multivar.r
#6. R_code_remote_sensing.r
#7. R_code_PCA_ remote_sensing.r
#8. R_code_ecosystem_functions.r
#9. R_code_radiance.r
#10. R_code_faPAR.r
#11. R_code_EBVs.r
#12. R_code_NO2.r
#13. R_code_snow_cover_projection.r
#14. R_code_interpolation.r
#15. R_code_species_distribution_modelling.r
#16. R_code_crop.r


###1. R first code
install.packages("sp") #function to install packages #sp stands for Spatial Data #quotes because we call something out of the R software
library(sp) #library function explains to R that we're going to use that package #require function will do the same job
data(meuse) #function to use data

# Let's see how the meuse dataset is structured:
meuse

# let's look at the first row of the set
head(meuse)

# let's see of the zinc concentration is related to that of copper
attach(meuse)

# lets' plot two variables
plot(zinc,copper)

plot(zinc,copper,col="green") #col stands for colour, the colour name need to be quoted

plot(zinc,copper,col="green",pch=19) #pch is point character - each number corrisponds to a symbol

plot(zinc,copper,col="green",pch=19,cex=2) #cex is character exageration

####################################################################

###2. R_code_multipanel.r
### Multipanel in R

install.packages("GGally") #this package is used only to use the function ggpair 
library (GGally)
library(sp) #require(sp) will do the same job, it's a similar function

data(meuse)
#how to attach meuse to use its variables

attach(meuse)

#EXERCISE: see the names of the variables and plot cadmium versus zinc
#there are two ways to see the names variables 
names(meuse)
head(meuse)
#to make the plot
plot(cadmium,zinc)

plot(cadmium,zinc,pch=15,col="red")

#EXERCISE: make all the possible pairwise plots of the variables of the dataset 
#plot is not a good idea
pairs(meuse) #pairs function returns a plot matrix, consisting of scatterplots for each variable-combination of a data frame.

#how to reduce the amount of variables
# ~ this is called tilde
pairs(~cadmium+copper+lead+zinc, data=meuse)
#in this case we hilight the fact that we want the plots of the pairs of a subset of variables

#la virgola dopo la parentesi dice "inizia da", i numeri s riferiscono al numero di colonna (il numero relativo alle variabili di interesse)
pairs(meuse[,3:6])

#EXERCISE: prettify this graph
pairs(meuse[,3:6],pch=15,col="violet",cex=1.5)

#GGally will prettify the graph
ggpairs(meuse[,3:6])
###########################################################################################

###3. R_code_spatial.r
#R code for spatial view of points

#1st of all: showing the points of the last time, (sp library) to visualise them in a map
library(sp)

data(meuse)
#in all the functions that will do,always write the dataset that we're using--> meuse

#now we look at the data, not all, but just few lines to have an idea of the set
head(meuse)
#we can see that these data are spatial, the variables consider that the points (x,y) are in a space

#coordinates: they are X and Y--> we use tilde ~ to tell R that the coordinates are x, y
coordinates(meuse)=~x+y

#now R knows that we're thinking spatially

#plot function shows the points measured on the field with the two coordinates
plot(meuse)

#spplot is the function that opens the plot of the sp package --> open brackets and write which dataset we're using.. and then the variable that we want to see)
spplot(meuse, "zinc")

#we can see from the graph that zinc is concentrated in the northern part (yellow colour, each colour define a specific range of concentration) because the prof knows that there is a river there

#EXERCISE: plot the spatial amount of copper
spplot(meuse, "copper")

#now we change the title, main argument
spplot(meuse,"copper",main="copper concentration")

#function bubble: bubble one variable--> the same info of the previous map but instead of using colours we use the size of the points, and each size relate to a specific concentration
bubble(meuse, "zinc")

#let's change the title
bubble(meuse, "zinc", main="Zinc concentration")

#EXERCISE: bubble copper in red
bubble(meuse, "copper", col="red")

#now we're going to take some data from the outside! once downloaded the data (Covid_agg.csv)
#put the Covid_agg.csv file into the lab folder

#setting the working directly in R: lab --> function setwd
#for Windows users
setwd("C:/lab")

#now we import the data. First we give a name of the dataset that we want to use

#name: covid; now we link the object to a function, this is done by "<-" that should be an arrow

#the function is read.table, the dataset is covid_agg.csv but it's outside R so we need to use the quotes
covid<-read.table("covid_agg.csv")

#we should state into the command that there is a header (the first row, that are the names of the variables) in the dataset--> the dataset doesn't start directly with data --> head=T
covid<-read.table("covid_agg.csv", head=T)

head(covid)

#now let's make a plot (non saptial) that show the number of cases
#but first attach function--> now R is ready to use covid 
attach(covid)
plot(country,cases)

#but we cannot see all the countries, so we change the plot--> let's use las, that is labels
plot(country,cases, las=0) #to make parallel labels in the x axis respect the y axis labels

plot(country, cases, las=1) #to make horizontal labels in x axis

plot(country, cases, las=2) #to make perpendicular labels in x axis

plot(country, cases, las=3) #to make vertical labels in both axis

plot(country, cases, las=2, cex.axis=0.5) #to exagerate the character

#let's plot these data spatially--> we make use of ggplot package--> good package to make nice graphs

#to use ggplot we need three components: data, aesthetic mappings (the variables composing the aesthetics of this graph), and geometrical function (by which we want to show the data)

#ggplot2 package for visualising data by graphs
install.packages("ggplot2")
library(ggplot2)

##2nd day
setwd("C:/lab/") #to set working directory
load(".RData")
ls() #to list the files used previously in R

#covid ggplot
library(ggplot2) #require(ggplot2) will do the same job

data(mpg)
head(mpg)

#key components: data,aes, geometry. Aes indicates the variables that we want to plot. Geometry is apart
ggplot(mpg, aes(x=displ,y=hwy))+geom_point()

#let's change the geometry, put lines connecting the points
ggplot(mpg,aes(x=displ,y=hwy))+geom_line()

#now put polygon connecting points
ggplot(mpg,aes(x=displ,y=hwy))+geom_polygon()

#let's use data from covid, already uploaded
head(covid)

#we're going to exagerate the points size by number of cases
ggplot(covid,aes(x=lon,y=lat,size=cases))+geom_point()
####################################################################################

###4. R_code_point_pattern
#important to study populations distribution
#typical point pattern distributions are: clumped, uniform, random

setwd("C:/lab/")
library(spatstat) #package for analysing spatial point patterns

attach(covid)
head(covid) 

#let's explain x and y variables and the range for the numbers with c, that is concatenate function
covids <- ppp(lon, lat, c(-180,180), c(-90,90)) # ?ppp (planar point pattern) creates an object of class "ppp" representing a point pattern dataset in the two-dimensional plane

# density of the covids object that we created before
d <- density(covids)

#let's plot the density map (d)
plot(d)

points(covids)
#points function show points on the top of previous map--> to see how much dense are the points in space
#each info attached to each point in the point pattern is called a mark variable


### Second lesson
setwd("C:/lab/")
library(spatstat)

load(point_pattern_analysis) #function to load load the work previously done and saved

#let's plot the density map (D)
plot(d)

points(covids)

#now we start to upload geographical info --> points, lines, ...

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
############################################################################################

###5. R_code_multivar.r
### R code for MULTIVARIATE ANALYSIS--> many variables
#how to monitor population and communities changes in time

setwd("C:/lab/")
library(vegan) #vegan stands for vegetation analysis

#now we assign a function (naming it "biomes") to an object (the dataset we want to use); the argument head stands for the header (in the dataset the first row and column are header, not data)
#sep argument stands for separator: R will read that the separator is a comma, so each time there is a comma R knows that there is a new column or row
biomes <- read.table("biomes.csv",head=T,sep=",") 

#function head to view the dataset
head(biomes)

#MULTIVARIATE ANALYSIS
#decorana stands for detrended correspondence analysis --> we're going to detrend the 2 dimensions that we have (20 plots) into just 2 dimensions
# we assign a name to a function that corresponds to decorana analysis applied to the dataset
multivar <- decorana(biomes) #decorana: multivariate technique to find main gradients in large , species rich but usually sparse data matrices that typify ecological community data

plot(multivar)

multivar #it will show the analysis output

#Eigenvalues- it tells how much the 2 dimensions explains the whole system (the multidimension system) --> in this case is 0.52 of DCA1 and 0.30 of DCA2--> we're seeing the 80% of the system

#we use the additional table to associate the plots with the biomes --> to see how they're linked 
biomes_types <- read.table("biomes_types.csv",header=T,sep=",")
head(biomes_types)

#we're going to link one point to the other to see if the different biomes can be seen in the graph
attach(biomes_types)

#ordiellipse function : it draws ellipses connecting the plots of the same biomes
#its second argument declare the column of the second dataset that we're going to use
#col stands for colours that can be referred as numbers, and they will be the colours of the ellipses
#kind argument stands for the type of graph, in this case we use ehull
#lwd is line dimension
ordiellipse(multivar, type, col=1:4, kind="ehull", lwd=3)

#ordispider function: it draws a 'spider' diagram where each point is connected to the group centroid with segments
ordispider(multivar,type,col=1:4,label=TRUE)

##so within the ellipses there are the species of the same biomes that are functionally related to each other
#the biomes are overlapping --> it means that there are species that live in both
#we can say that if we remove one species within the ellipse the whole related biome could be endangered 

#let's keep in mind the fact that with this graph obtained we see only the 80% (Eigenvalues) of the info in the dataset, 
#so if there are species that are outside the ellipses it means that we're looking at the dataset in a specific way (defined by the 2 dimensions) but there could be other ways to look at it
#for example,by adding more dimensions (DCA), we add more infos and this time the species that was previously outside the ellipse may be now inside.
############################################################################################

######6. R_code_remote_sensing.r
##REMOTE SENSING
#images are matrices of numbers translated into colours #sensors measure how much an object reflect the electromagnetic spectrum, and which part of it

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
# B4: near infrared (nir) #one of the most powerful band to monitor ecosystems
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
#stretch in order to see colours better --> it's linear #it stretches the original data (example: if they go from 50 to 100, after stretch they will go from 0 to 100)
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
#EXERCISE: plot in visible RGB 321 both images
par(mfrow=c(2,1))

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#EXERCISE: plot in RGB 432
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
#to change the scale we modify the grain (for RS it's the same of resolution: the dimension of pixels)
#so now let's change it--> we use the aggregate function: it aggregates pixels in order to 
#the higher is the dimension of pixel (coarser grain), the lower is the capability to see objects --> so smaller pixel have a higher resolution.
#high resolution data can provide infos as tree heights or tree temperature --> it can be used to study microclimate

#fact argument stands for the amount of time we want to increase the pixel dimension (from 30 to 90, the factor is 3)
#aggregate function:it aggregates pixels to make a coarser grain, fact is the argument that indicates the factor of increase of the pixels.
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #res stands for resembling (the dimension of pixels)
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")

#LANDSAT images have a resolution of 30mx30m (--> size of the pixels: medium resolution)

####3rd DAY: Rcode DVI deforestation

#download defor1 and defor2 images. 

setwd("C:/lab/)
library(raster)
library(rasterdiv)

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

#par function to create a multiframe by rows= 1 line, 2 columns
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
##so with this exercise we saw how to visualize the difference of an indicator over time
############################################################################################

###7. R_code_PCA_ remote_sensing.r

setwd("C:/lab/")

p224r63_2011 <- brick("p224r63_2011_masked.grd")

plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") ##used the 5,4,3, bands

#same plot but with ggplot
library(ggplot2)
ggRGB(p224r63_2011, 5,4,3) #a bit smoother

#do the same with 1988 image
p224r63_1988 <- brick("p224r63_1988_masked.grd")

plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")

names(p224r63_2011) #to see the names of the different bands

dev.off()

plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre) #to see if the 2 bands are correlated

p224r63_2011_res <- aggregate(p224r63_2011, fact=10) #to reduce the resolution-->for 100 pixel we have now 1 pixel
#this is necessary to do the PCA

p224r63_2011_pca <- rasterPCA(p224r63_2011_res) #PCA analysis

cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) 
plot(p224r63_2011_pca$map, col=cl)

summary(p224r63_2011_pca$model) #to see the output of the model

pairs(p224r63_2011)

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

#1988 image
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res) 
plot(p224r63_1988_pca$map, col=cl)

summary(p224r63_1988_pca$model)
pairs(p224r63_1988)

#let's make the difference of the 2 images for each component
difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(difpca)

cldif <- colorRampPalette(c('blue','black','yellow'))(100) 

plot(difpca$PC1,col=cldif) #the image show the highest possible variation of the 2 images, in yellow the sites where there has been major variation
##most of the variation is carried out by the principal component (PC1) - we saw it on model

###so we compacted the many dimensions of the bands making pca analysis!
############################################################################################

###8. R_code_ecosystem_functions.r

## assessing the biomass through NDVI in order to see the potential in terms of ecosystem functions of analyzed ecosystems
#code to view biomass over the world and calculate changes in ecosystem functions

##energy, chemical cycling
##LUCC: land use and climate changes

#raster data are all data based on pixel
#we're going to show the medium value of biomass for several years (1999-2017)

install.packages("rasterdiv") #it provides functions to calculate indices of diversity
install.packages("rasterVis") # it's a package that implements visualization methods for rasters 

library(rasterdiv)
library(rasterVis)

data(copNDVI) #it's the NDVI of Copernicus
plot(copNDVI)

#we are going to reclassify the data because some of them are referred to the water-->  we remove the water values (253 to 255)
#cbind delate the values within the brackets
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

#function levelplot: it draws levelplot
levelplot(copNDVI)
#we got the mean biomass over 30 years
#the pixels are 8km square

#close to the poles there are no plants so the NIR values are low, while on the contraries in forests we have high NIR and so hig DVI
#ecosystem functions and services in the deserts are very few
#latitude is controlling biomass
#the graph on the right (of the previous levelplot) is a plot with on x axis mean DVI values and on y axis the latitude
#similar is for the upper part graph, where on the x axis there are mean DVI values, while on y axis longitude

copNDVI10 <- aggregate(copNDVI, fact=10) #we increase the pixel dimension by a factor of ten
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100) 
############################################################################################

###9. R_code_radiance.r
###how to code ecosystem reflectance

library(raster)

#let's create a raster with 2 rows and 2 columns
#and then assign casual values (it's just an example) to the raster

toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c(1.13,1.44,1.55,3.4) #important to put 2 decimals --> they give a large amount of info

plot(toy)
text(toy, digits=2)

#we want to reduce the amount of bits
#stretch function - min value and max value
toy2bits <- stretch(toy,minv=0,maxv=3)
storage.mode(toy2bits[])="integer" #to ensure that we make use of integer

plot(toy2bits)
text(toy2bits, digits=2)

#4 bits = 16 combinations
toy4bits <- stretch(toy,minv=0,maxv=15)
storage.mode(toy4bits[])="integer"

plot(toy4bits)
text(toy4bits, digits=2)

#8bits
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[])="integer"
plot(toy8bits)
text(toy8bits, digits=2)

#if we increase the amount of bit the pixels might appear more and more different from each other, as the range has increased

#let's plot all the images
par(mfrow=c(1,4)

plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2)

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)

#so we transformed radiant values into bits --> digital numbers
############################################################################################

###10. R_code_faPAR.r

##we're dealing on how to look at chemical cycling from satellite data
##on IOL there is the first part of the code on how to aggregate pixels of a copernicus image 
##the file that we use has been aggregated by the prof in order to reduce its size of download (aggregation by factor of 10)

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

###3rd day

## regression model between faPAR and NDVI
## we have two variable (x,y), and we want to see the relation between them
# y= bx+a 
#b= the slope, a= the point of intersection with y (intercept)


# example: erosion vs heavy metal 
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

#we have 2 parameters and we want to know how the variables are related
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
############################################################################################

###11. R_code_EBVs.r
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
plotRGB(sntpca$map, 1, 2, 3, stretch="lin") #to show the variability of the image in a psychedelic way

### diversity measurement
#first: set the moving window 
window <- matrix(1, nrow = 5, ncol = 5) 
window

sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd) #w stands for window #focal function applied to PC1 to identify the standard deviation of all the neighbours cells
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) 
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plot(std_sntr, col=cl)
plotRGB(sd_snt, 4, 3, 2, stretch="lin")

# plot(std_snt8bit, col=cl)

std_sntr1 <- focal(snt_r$prova5_.1, w=window, fun=sd)
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) 
plot(std_sntr1, col=cl)

### PCA related sd
library(RStoolbox)
sntrpca <- rasterPCA(snt_r)

summary(sntrpca$model) 

clp <- colorRampPalette(c('dark grey','grey','light gray'))(100) 
plot(sntrpca$map,col=clp)
plotRGB(sntrpca$map,1,2,3,stretch="lin")

std_sntrpca <- focal(sntrpca$map$PC1, w=window, fun=sd)
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) 
plot(std_sntrpca, col=cl)

##############

##2nd day
## FOCAL on Cladonia

setwd("C:/lab/")
library(RStoolbox)
library(raster) # two function - we can use 1.raster(import one single layer, one band) 2.brick(import several layers)
# now we have three layers so we need brick function

clad <- brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad, 1,2,3, stretch="lin")

#to measure variability and selection of the PC
#first we select the extection of the window to pass on top of the image
#we create a window to analyze the standard deviation of a 3x3 matrix, and so 3x3 pixel
#number one is an arbitrary value
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
cl <- colorRampPalette(c('yellow','violet','black'))(100) 
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)
############################################################################################

###12. R_code_NO2.r
#NO2 levels over Italy pre- and during- Covid 19

setwd("C:/lab/NO2")
library(raster)

#import NO2 data with lapply function that is applied for operations on list objects and returns a list object of same length of original set.
no2list <- list.files(pattern="EN") #list.files function produce a character vector of the names of files or directories 
no2list

import <- lapply(rlist, raster) #lapply function: it applies a certain function (in this case raster in order to import several layers) to several elements
EN <- stack(import)
cl <- colorRampPalette(c('red','orange','light blue'))(100) 
plot(EN, col=cl)
    
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)
dev.off() #to cancel the par

#plot the image 001. 007 and 013 with the RGB system: in this way if the values of 001 are higher the color will be red (as we assign to the 001 image the red band)(and the same for the other colors and bands)
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
abline(0,1,col="red") #many values are below the line: it means that there has been a decrease of values between the 2 images
############################################################################################

###13. R_code_snow_cover_projection.r

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

#####
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
############################################################################################

###14. R_code_interpolation.r

setwd("C:/lab/")

library(spatstat)

#Foreste Casentinesi dataset
inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)
head(inp)

#we do an estimate of the canopy cover all over the area basing on the points that we have
attach(inp) #now we're working with the dataset, in this way we can work directly with column names instead of using the dollar
plot(X,Y)

#when you see ferns it means that there is high humidity --> high amount of shadow!

#ppp function: planar point pattern, with this we explain which are the coordinates (x,Y) and which is their range in this dataset
summary(inp) #to see the min and max values of X and Y
inppp <- ppp(x=X,y=Y, c(716000,718000),c(4859000,4861000))

#marks function in order to label the points with the canopy cover data
marks(inppp) <- Canopy.cov #we can directly write the name of the column on which we're interested

#now we make an estimation of the values of the canopy cover in the points where we have no data, this estimate is done considering the distance between the points for which we have the values

canopy <- Smooth(inppp) #Smooth function
plot(canopy)
points(inppp, col="green")

#the same but for lichens
marks(inppp) <- cop.lich.mean
lichs <- Smooth(inppp)
plot(lichs)

par(mfrow=c(1,2))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=")
points(inppp)
##the pattern is not similar so it seems like canopy is negatively correlated with lichen covering.

##################

###psammophilous dataset
inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)
attach(inp.psam)
head(inp.psam)
plot(E,N) #east and north are the x and Y
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))
marks(inp.psam.ppp) <- C_org
C <- Smooth(inp.psam.ppp)
plot(C)
points(inp.psam.ppp)
############################################################################################

###15. R_code_species_distribution_modelling.r

# install.packages("sdm") #sdm package for developing species distribution models
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
d <- sdmData(train=species, predictors=preds) #2 type of data in sdm: 1 is the  training dataset (measured in the field) and 2nd are the predictors
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
############################################################################################

###16. R_code_crop.r
#how to crop satellite images 

setwd("C:/lab/")
library(raster)
library(ncdf4) 

snow <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow, col=cl)

ext <- c(0, 20, 35, 50)
zoom(snow, ext=ext) #zoom function allow to draw a rectangle to zoom on a certain image

# crop function allows to crop and to create a new image
snowitaly <- crop(snow, ext) 
plot(snowitaly, col=cl) 

# zoom(snow, ext=drawExtent())
# crop(snow, drawExtent())


############################################################################################
############################################################################################

##R_code_exam_project

#1st step: Visualization of data by plotRGB
#2nd step: Spectral Transformations: NDVI, NDWI, TasseledCap

setwd("C:/lab/exam")
install.packages("RColorBrewer")
library(RColorBrewer)
library(rasterVis) #levelplot
library(ggplot2)
library(raster)
library(rgdal) #readOGR function
library(RStoolbox) #to calculate NDVI with SpectralIndices function #to use tasseledCap function

###1995 image
#import the image 1995
aug1995 <-list.files (pattern="LT05_L1TP_192029_19950802_20180214_01_T1_sr_band")
import1995 <- lapply(aug1995, raster)
rs_1995 <- stack(import1995)

##crop the  1995 image with mugello shp
crop_extent <- readOGR(dsn="C:/lab", layer="ammi_uc_mugello_linee")
crop_extent
#matching CRS 
myExtent <- spTransform(crop_extent, CRS("+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 "))
myExtent 

mugello1995 <- crop (rs_1995, myExtent)

###2011 image
#import 2011 image 
aug2011 <-list.files (pattern="LT05_L1TP_192029_20110814_20161007_01_T1_sr_band")
import2011 <- lapply(aug2011, raster)
rs_2011 <- stack(import2011)

#crop 2011 image
mugello2011 <- crop(rs_2011, myExtent)
plot(mugello2011)

#####1st step: visualize data
###plot RGB --> natural color
plotRGB(mugello1995, r=3, g=2, b=1, stretch="Lin", main="1995")
plot(myExtent, add=T, lwd=3, col="red")

rgblin <- plotRGB(mugello2011, r=3, g=2, b=1, stretch="Lin", main="2011")
plot(myExtent, add=T, lwd=3, col="red")

###plotRGB --> with NIR component
png("mugellostretchlin1995.png")
plotRGB(mugello1995, r=4, g=3, b=2, stretch="Lin")
plot(myExtent, add=T, lwd=3)
dev.off ()

png("mugellostretchlin2011.png")
plotRGB(mugello2011, r=4, g=3, b=2, stretch="Lin")
plot(myExtent, add=T, lwd=3)
dev.off()

#plotRGB --> to enhance the noise
png("mugellostretchhist.png")
par(mfrow=c(1,2))
plotRGB(mugello1995, r=4, g=3, b=2, stretch="hist", axes=TRUE, main="1995") 
plot(myExtent, add=T, lwd=3)
plotRGB(mugello2011, r=4, g=3, b=2, stretch="hist", axes=TRUE, main="2011")
plot(myExtent, add=T, lwd=3)
dev.off()

####2nd step: spectral transformations

##a.NDVI CALCULATION
#1995
mugello1995_NDVI <- spectralIndices(mugello1995,red="LT05_L1TP_192029_19950802_20180214_01_T1_sr_band3", nir="LT05_L1TP_192029_19950802_20180214_01_T1_sr_band4", indices="NDVI")
summary(mugello1995_NDVI)

clr <- colorRampPalette(c("red","green"))(50)
mugello1995_NDVIstr <-stretch(mugello1995_NDVI, minv=-1, maxv=1)

#2011
mugello2011_NDVI <- spectralIndices(mugello2011,red="LT05_L1TP_192029_20110814_20161007_01_T1_sr_band3", nir="LT05_L1TP_192029_20110814_20161007_01_T1_sr_band4", indices="NDVI")
summary(mugello2011_NDVI)
mugello2011_NDVIstr <-stretch(mugello2011_NDVI, minv=0, maxv=1)

par(mfrow=c(1,2))
plot(mugello1995_NDVIstr, col=clr, axes=FALSE, main="1995 NDVI")
plot(myExtent, add=T)
plot(mugello2011_NDVIstr, col=clr, axes=FALSE, main="2011 NDVI")
plot(myExtent, add=T)
dev.off()

#NDVI difference
mugello_NDVIdif <- mugello2011_NDVI - mugello1995_NDVI
summary(mugello_NDVIdif)

#plot
png("NDVI difference.png")
cldif <- colorRampPalette(c("dark blue","blue", "white", "yellow"))(50)
plot(mugello_NDVIdif, col=cldif, main="NDVI difference", axes=FALSE, legend=FALSE)
plot(mugello_NDVIdif, col=cldif, main="NDVI difference", axes=FALSE, legend.only=TRUE, legend.args=list(text="ΔNDVI"))
plot(myExtent, add=T)
dev.off()

#histogram
png("NDVI difference histogram.png")
hist(mugello_NDVIdif, main="NDVI difference distribution", xlab=NULL, yaxt="n", breaks=50, col="violet", binwidth=100)
dev.off()


##b. NDWI calculation
mugello1995_NDWI <- spectralIndices(mugello1995, green="LT05_L1TP_192029_19950802_20180214_01_T1_sr_band2", nir="LT05_L1TP_192029_19950802_20180214_01_T1_sr_band4", indices="NDWI")
mugello2011_NDWI <- spectralIndices(mugello2011, green="LT05_L1TP_192029_20110814_20161007_01_T1_sr_band2", nir="LT05_L1TP_192029_20110814_20161007_01_T1_sr_band4", indices="NDWI")
clndwi <- colorRampPalette(c("coral4","coral","darkorchid1","deepskyblue","darkblue"))(100)
summary(mugello1995_NDWI)
summary(mugello2011_NDWI)

#NDWI difference
mugello_NDWIdif <- mugello2011_NDWI - mugello1995_NDWI

#plot
png("NDWIdifference.png")
plot(mugello_NDWIdif, col=clndwi, main="NDWI difference", axes=FALSE, legend=FALSE)
plot(mugello_NDWIdif, col=clndwi, main="NDWI difference", axes=FALSE, legend.only=TRUE, legend.args=list(text="ΔNDWI"))
plot(myExtent, add=T)
dev.off()

#histogram
png("NDWIhist.png")
diffndwi <- hist(mugello_NDWIdif, main="NDWI difference distribution", xlab=NULL, yaxt="n", breaks=50, col="springgreen")
dev.off()

##c. moving window --> NDVI and NDWI variance
window <- matrix(1, nrow=7, ncol=7)
mugello_NDVIdif <- focal(mugello_NDVIdif, w=window, fun=var)
mugello_NDWIdif <- focal(mugello_NDWIdif, w=window, fun=var)

cl2 <- colorRampPalette(c('dark blue', 'light blue', 'green','yellow','orange','red'))(100) 

png("NDVI variance.png")
plot(mugello_NDVIdif, col=cl2, main="NDVI variance")
plot(myExtent, add=T)
dev.off()

png("NDwI variance.png")
plot(mugello_NDWIdif, col=cl2, main="NDWI variance")
plot(myExtent, add=T)
dev.off()

##d. TasseledCap tranformation
#1995
tascap1995 <- tasseledCap(mugello1995, "Landsat5TM")
summary(tascap1995)

png("tsbrightness1995.png")
mapTheme1 <- rasterTheme(region=brewer.pal(5,"Oranges"))
plt1 <- levelplot(tascap1995$brightness, margin=F, par.settings=mapTheme, main="1995 brightness", contour=FALSE)
plt1 + latticeExtra::layer(sp.lines(myExtent, col="gray30", lwd=0.5))
dev.off()

png("tsgreenness1995.png")
mapTheme2 <- rasterTheme(region=brewer.pal(5,"Greens"))
plt2 <- levelplot(tascap1995$greenness, margin=F, par.settings=mapTheme2, main="1995 greenness")
plt2 + latticeExtra::layer(sp.lines(myExtent, col="gray30", lwd=0.5))
dev.off()
summary(tascap1995$greenness)

png("tswetness1995.png")
mapTheme3 <- rasterTheme(region=brewer.pal(10,"Blues"))
plt3 <- levelplot(tascap1995$wetness, margin=F, par.settings=wetcol, main="1995 wetness")
plt3 + latticeExtra::layer(sp.lines(myExtent, col="black", lwd=0.5))
dev.off()
summary(tascap1995$wetness)

png("tcap1995rgb.png")
plotRGB(tascap1995, r=1, g=2, b=3, stretch="lin")
plot(myExtent, add=T, lwd=3)
dev.off()

#2011
tascap2011 <- tasseledCap(mugello2011, "Landsat5TM")
tascap2011

png("tswetness2011.png")
plt4 <- levelplot(tascap2011$wetness, margin=F, par.settings=mapTheme3, main="2011 wetness")
plt4 + latticeExtra::layer(sp.lines(myExtent, col="gray30", lwd=0.5))
dev.off()

summary(tascap2011$wetness)

png("tsgreenness2011.png")
plt5 <- levelplot(tascap2011$greenness, margin=F, par.settings=mapTheme2, main="2011 greenness")
plt5 + latticeExtra::layer(sp.lines(myExtent, col="gray30", lwd=0.5))
dev.off()

summary(tascap2011$greenness)

png("tcap2011rgb.png")
plotRGB(tascap2011, r=1, g=2, b=3, stretch="lin")
plot(myExtent, add=T, lwd=3)
dev.off()





