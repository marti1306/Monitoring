### R code for MULTIVARIATE ANALYSIS


setwd("C:/lab/")

library(vegan)

#now we assign a function (naming it "biomes") to an object (the dataset we want to use); the argument head stands for the header (in the dataset the first row and column are header, not data)
#sep argument stands for separator: R will read that the separator is a comma, so each time there is a comma R knows that there is a new column or row

biomes <- read.table("biomes.csv",head=T,sep=",") 

#function head to view the dataset

head(biomes)

#MULTIVARIATE ANALYSIS
#decorana stands for detrended correspondence analysis --> we're going to detrend the 2 dimensions that we have (20 plots) into just 2 dimensions
# we assign a name to a function that corresponds to decorana analysis applied to the dataset

multivar <- decorana(biomes)

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

#ordispider function:

ordispider(multivar,type,col=1:4,label=TRUE)

##so within the ellipses there are the species of the same biomes that are functionally related to each other
#the biomes are overlapping --> it means that there are species that live in both
#we can say that if we remove one species within the ellipse the whole related biome could be endangered 

#let's keep in mind the fact that with this graph obtained we see only the 80% (Eigenvalues) of the info in the dataset, 
#so if there are species that are outside the ellipses it means that we're looking at the dataset in a specific way (defined by the 2 dimensions) but there could be other ways to look at it
#for example,by adding more dimensions (DCA), we add more infos and this time the species that was previously outside the ellipse may be now inside.
