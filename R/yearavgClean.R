# yearavg.R
# calculate avarage over one year


yearavarage <- function(){
	# load modis data
	modisgrdpath <- "./data/MOD13A3.A2014001.h18v03.005.grd"
	modis <- brick(modisgrdpath)
	
	# convert to dataframe
	yeardf <- as.data.frame(modis, na.rm=FALSE) # true
	#head(yeardf)
	
	# add a column with avarage row values
	modis$avg <- rowMeans(yeardf, na.rm = FALSE)
	#head(modis)
	
	
	# Download City's
	nlCity <- raster::getData('GADM',country='NLD', level=2, path = "./data")
	
	# remove rows with nodata
	nlCity@data <- nlCity@data[!is.na(nlCity$NAME_2),]
	
	# transform to the same CRS
	nlCitySinu <- spTransform(nlCity, CRS(proj4string(modis)))
	
	# create a crop with citys
	#janCrop <- crop(janbrick, nlCitySinu)
	
	# create a mask
	yearMask <- mask(modis, nlCitySinu)
	
	# extract
	yearMean <- extract(yearMask, nlCitySinu, sp=TRUE, df=TRUE,fun=mean)	
	
	# highest greenvalue
	maximum <- max(yearMean$avg, na.rm = TRUE)
	
	# find rownumber
	maxrownr <- which(yearMean$avg == maximum[1])
	
	# lookup city name
	greenestcity <- yearMean$NAME_2[maxrownr]
	
	return(greenestcity)
	
}
