# Student: William Schuch & Rik van Berkum
# Team: Geodetic Engineers of Utrecht
# Institute: Wageningen University and Research
# Course: Geo-scripting (GRS-33806)
# Date: 2016-01-12
# Week 2, Lesson 7: Vector - Raster

GreenestCityOfTheMonth <- function(monthnumber){
	
	mon <- stack@layers[monthnumber]
	monbrick <- brick(mon)
	
	# Download City's
	nlCity <- raster::getData('GADM',country='NLD', level=2, path = "./data")
	
	# remove rows with nodata
	nlCity@data <- nlCity@data[!is.na(nlCity$NAME_2),]
	
	# transform to the same CRS
	nlCitySinu <- spTransform(nlCity, CRS(proj4string(modisbrick)))
	
	# create a crop with citys
	#janCrop <- crop(janbrick, nlCitySinu)
	
	# create a mask
	monMask <- mask(monbrick, nlCitySinu)
	
	# extract
	monMean <- extract(monMask, nlCitySinu, sp=TRUE, df=TRUE,fun=mean)
	
	# highest greenvalue
	maximum <- max(monMean@data[16], na.rm = TRUE)

	# find rownumber
	maxrownr <- which(monMean@data[16] == maximum[1])

	# lookup city name
	greenestcity <- monMean$NAME_2[maxrownr]
	
	return(greenestcity)
}


