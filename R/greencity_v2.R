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
#spplot(modisbrick)
#head(modisbrick)
#modisbrick
#names(modisbrick)
#nlayers(modisbrick)

# selecting january
?stack
stack <- stack(modisbrick)
class(stack)
january <- stack@layers[1]
janbrick <- brick(january)
plot(janbrick)

# Download City's
nlCity <- raster::getData('GADM',country='NLD', level=2, path = "./data")
class(nlCity)
head(nlCity@data)
nlCity@data <- nlCity@data[!is.na(nlCity$NAME_2),] ## remove rows with NA

# transform to the same CRS
nlCitySinu <- spTransform(nlCity, CRS(proj4string(janbrick)))

janCrop <- crop(janbrick, nlCitySinu)
janSub <- mask(janbrick, nlCitySinu)
?mask()
plot(janCrop)
plot(janSub)

#extract!!
	




