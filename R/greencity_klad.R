# greencity.R

# load librarys
library(raster)
library(sp)
library(rgdal)
library(rgeos)


unzip("./data/MODIS.zip", exdir = "./data/")

modisgrdpath <- "./data/MOD13A3.A2014001.h18v03.005.grd"



modisbrick <- brick(modisgrdpath)
class(modisbrick)
spplot(modisbrick)
head(modisbrick)
modisbrick
names(modisbrick)
nlayers(modisbrick)

subsetmodis <- modisbrick[modisbrick$names=="January",]
modisbrick[grep("January", modisbrick$names, ignore.case = TRUE)]
subset(modisbrick, names=="January")

extract(modisbrick)
stack <- stack(modisbrick)
class(stack)
january <- stack@layers[1]
janbrick <- brick(january)
plot(janbrick)

#modisraster <- raster(modisgrdpath)
head(modisraster)
plot(modisraster)
modisbrick@names[1]
