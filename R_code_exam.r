##R_code_exam.r

#R first code
install.packages("sp")

library(sp)

data(meuse)

# Let's see how the meuse dataset is structured:

meuse

# let's look at the first row of the set

head(meuse)

# lets' plot two variables

# let's see of the zinc concentration is realted to that of copper

attach(meuse)

plot(zinc,copper)

plot(zinc,copper,col="green")

plot(zinc,copper,col="green",pch=19)

plot(zinc,copper,col="green",pch=19,cex=2)

####################################################################

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

#spplot is the function that opens the plot of the sp package, --> open brackets and write which dataset we're using.. and then the variable that we want to see)

spplot(meuse, "zinc")

#we can see from the graph that zinc is concentrated in the northern part (yellow colour, each colour define a specific range of concentration) because the prof knows that there is a river there

#exercise : plot the spatial amount of copper

spplot(meuse, "copper")

#now we change the title

spplot(meuse,"copper",main="copper concentration")

#function bubble: bubble one variable--> the same info of the previous map but instead of using colours we use the size of the points, and each size relate to a specific concentration

bubble(meuse, "zinc")

#let's change the title

bubble(meuse, "zinc", main="Zinc concentration")

#exercise: bubble copper in red

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

#we should state into the command that there is a head (the first row, that are the names of the variables) in the dataset--> the dataset doesn't start directly with data --> head=T
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

#ggplot2 package

install.packages("ggplot2")

library(ggplot2)


##Second day
setwd("C:/lab/") #to set working directory
load(".RData")
ls() #to list of the files used previously in R

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

### Multipanel in R

install.packages("GGally") #this package is used only to use the function ggpair 
library (GGally)
library(sp) #require(sp) will do the same jub, it's a similar function

data(meuse)
#how to attach meuse to use its variables

attach(meuse)

#exercise: see the names of the variables and plot cadmium versus zinc
#there are two ways to see the names variables 
names(meuse)
head(meuse)
#to make the plot
plot(cadmium,zinc)

plot(cadmium,zinc,pch=15,col="red")

#exercise 2: make all the possible pairwise plots of the variables of the dataset 
#plot is not a good idea
pairs(meuse)

#how to reduce the amount of variables
# ~ this is called tilde
pairs(~cadmium+copper+lead+zinc, data=meuse)

#similar way to do line 23- in this case we hilight the fact that we want the plots of the pairs of a subset of variables
#la virgola dopo la parentesi dice "inizia da", i numeri s riferiscono al numero di colonna (il numero relativo alle variabili di interesse)

pairs(meuse[,3:6])

#exercise 3: prettify this graph

pairs(meuse[,3:6],pch=15,col="violet",cex=1.5)

#GGally will prettify the graph

ggpairs(meuse[,3:6])

###########################################################################################

##R_code_point_pattern

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

############################################################################################
