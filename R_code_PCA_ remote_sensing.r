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

p224r63_2011_pca <- rasterPCA(p224r63_2011_res)

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

 

