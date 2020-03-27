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
