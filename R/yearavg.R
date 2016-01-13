# yearavg.R

# calculate avarage over one year

# double code
modisgrdpath <- "./data/MOD13A3.A2014001.h18v03.005.grd"

modis <- brick(modisgrdpath)

stack <- stack(modisbrick)

###############

yeardf <- as.data.frame(modis, na.rm=TRUE)
yeardf$avg <- rowMeans(yeardf, na.rm = TRUE)
head(yeardf)






?as.data.frame

year <- stack@layers
yearbrick <- brick(year)


year$avg <- rowMeans(year, na.rm = TRUE)

x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
rowMeans(yeardf)
x



stack
yearbrick <- brick(stack)
head(stack)
head(yearbrick)
yearbrick

stack@layers[1]
mean <- mean(stack@layers[1], na.rm = TRUE)
head(mean)

?mean

x <- c(1:3)
mean(x)

modis$avg <- rowMeans(modis[-1], na.rm = TRUE)
?rowMeans

head(modis)
max(modis)

head(modisbrick)

year <- stack
yearbrick <- brick(year)
max(stack$avg, na.rm = TRUE)

?aggregate

aggregate(yearbrick, mean)
class(yearbrick)



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

#return(greenestcity)
greenestcity