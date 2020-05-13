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

#lower are the bits 

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

library(rasterdiv)


