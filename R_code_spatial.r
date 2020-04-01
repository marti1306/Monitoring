#R code for spatial view of points

#1st of all: showing the points of the last time, (sp library) to visualise them in a map

library(sp)

data(meuse)
#in all the functions that will do,always write the dataset that we're using--> meuse


#now we look at the data, not all, but just few lines to have an idea of the set

head(meuse)

#we can see that these data are spatial, the variables consider that the points (x,y) are in a space

#coordinates: they are X and Y--> we use tilde ~ totell R that the coordinates are x, y

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


