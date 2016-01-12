# yearavg.R

# calculate avarage over one year

# double code
modisgrdpath <- "./data/MOD13A3.A2014001.h18v03.005.grd"

modisbrick <- brick(modisgrdpath)

stack <- stack(modisbrick)

###############

stack
head(stack)

year <- stack
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
yearMean <- extract(yearMask, nlCitySinu, sp=TRUE, df=TRUE,fun=mean)	

# highest greenvalue
maximum <- max(yearMean$year, na.rm = TRUE)

# find rownumber
maxrownr <- which(yearMean$year == maximum[1])

# lookup city name
greenestcity <- yearMean$NAME_2[maxrownr]

return(greenestcity)