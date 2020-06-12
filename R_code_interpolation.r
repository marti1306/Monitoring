###R_code_interpolation.r

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


