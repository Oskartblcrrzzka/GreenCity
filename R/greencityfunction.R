myfunction <- function(monthnumber){
	
	january <- stack@layers[monthnumber]
	janbrick <- brick(january)
	
	
	# Download City's
	nlCity <- raster::getData('GADM',country='NLD', level=2, path = "./data")
	
	# remove rows with nodata
	nlCity@data <- nlCity@data[!is.na(nlCity$NAME_2),]
	
	# transform to the same CRS
	nlCitySinu <- spTransform(nlCity, CRS(proj4string(modisbrick)))
	
	# create a crop with citys
	#janCrop <- crop(janbrick, nlCitySinu)
	
	# create a mask
	janMask <- mask(janbrick, nlCitySinu)
	
	# extract
	januaryMean <- extract(janMask, nlCitySinu, sp=TRUE, df=TRUE,fun=mean)	
	
	# highest greenvalue
	maximum <- max(januaryMean$January, na.rm = TRUE)
	
	# find rownumber
	maxrownr <- which(januaryMean$January == maximum[1])

	# lookup city name
	greenestcity <- januaryMean$NAME_2[maxrownr]
	
	return(greenestcity)
	
	
}


