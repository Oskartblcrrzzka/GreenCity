# Student: William Schuch & Rik van Berkum
# Team: Geodetic Engineers of Utrecht
# Institute: Wageningen University and Research
# Course: Geo-scripting (GRS-33806)
# Date: 2016-01-12
# Week 2, Lesson 7: Vector - Raster

GreenestCityOverTheYearAverage <- function(){
	
	year <- stack@layers
	yearbrick <- brick(year)
	
	# Download City's
	nlCity <- raster::getData('GADM',country='NLD', level=2, path = "./data")
	
	# remove rows with nodata
	nlCity@data <- nlCity@data[!is.na(nlCity$NAME_2),]
	
	# transform to the same CRS
	nlCitySinu <- spTransform(nlCity, CRS(proj4string(modisbrick)))
	
	# create a crop with citys
	#janCrop <- crop(janbrick, nlCitySinu)
	
	# create a mask
	yearMask <- mask(yearbrick, nlCitySinu)
	
	# extract
	yearMean <- extract(yearMask, nlCitySinu, sp=TRUE, df=TRUE, fun=mean)
	
	# average over the whole year
	yearAvr <- (yearMean@data[16]+yearMean@data[17]+yearMean@data[18]+yearMean@data[19])/4
	
	# highest greenvalue
	maximum <- max(yearMean@data[16:27], na.rm = TRUE)
	
	# find rownumber
	maxrownr <- which(yearMean@data[16:27] == maximum)
	
	# lookup city name
	greenestcity <- yearMean$NAME_2[maxrownr]
	
	return(greenestcity)
}

yearMean@data[27]
