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
#?stack
stack <- stack(modisbrick)
class(stack)
january <- stack@layers[1]
janbrick <- brick(january)
#plot(janbrick)
#plot(stack, 1)
# Download City's
nlCity <- raster::getData('GADM',country='NLD', level=2, path = "./data")
#class(nlCity)
#head(nlCity@data)
nlCity@data <- nlCity@data[!is.na(nlCity$NAME_2),] ## remove rows with NA

# transform to the same CRS
nlCitySinu <- spTransform(nlCity, CRS(proj4string(modisbrick)))

janCrop <- crop(janbrick, nlCitySinu)
janMask <- mask(janbrick, nlCitySinu)
#?mask()
#plot(janCrop)
#plot(janMask)

#extract!!
januaryMean <- extract(janMask, nlCitySinu, sp=TRUE, df=TRUE,fun=mean)	
#?extract
plot(januaryMean)
head(januaryMean)

class(januaryMean)

# highest greenvalue
maximum <- max(januaryMean$January, na.rm = TRUE)
#januaryMean$NAME_2[maximum]
maximum
maxrownr <- which(januaryMean$January == maximum[1])
greenestcity <- januaryMean$NAME_2[maxrownr]
plot(greenestcity)
#?apply
#?max

c(januaryMean$NAME_2, januaryMean$January)


