# Student: William Schuch & Rik van Berkum
# Team: Geodetic Engineers of Utrecht
# Institute: Wageningen University and Research
# Course: Geo-scripting (GRS-33806)
# Date: 2016-01-12
# Week 2, Lesson 7: Vector - Raster

GreenestCityOverTheYearAverage <- function(plot_or_not){
	
	# convert to dataframe
	yeardf <- as.data.frame(modisbrick, na.rm=FALSE) # true
	#head(yeardf)
	
	# add a column with avarage row values
	modisbrick$avg <- rowMeans(yeardf, na.rm = FALSE)
	#head(modis)
	
	# create a mask
	yearMask <- mask(modisbrick, nlCitySinu)
	
	# extract
	yearMean <- extract(yearMask, nlCitySinu, sp=TRUE, df=TRUE,fun=mean)	
	
	# highest greenvalue
	maximum <- max(yearMean$avg, na.rm = TRUE)
	
	# find rownumber
	maxrownr <- which(yearMean$avg == maximum[1])
	
	# lookup city name
	greenestcity <- yearMean$NAME_2[maxrownr]
	
	# create a subset of the greenest city
	SS_greenestcity <- subset(yearMean, yearMean$NAME_2==greenestcity, drop = FALSE)
	
	if (plot_or_not == TRUE) {
		
		GetCenterX <- (bbox(SS_greenestcity)[1,1]+bbox(SS_greenestcity)[1,2])/2
		GetCenterY <- (bbox(SS_greenestcity)[2,1]+bbox(SS_greenestcity)[2,2])/2

		CenterText = list("sp.text", c(GetCenterX,GetCenterY), greenestcity)
		p.plot <- spplot(yearMean, zcol = "avg",
										 col.regions=colorRampPalette(c('darkred', 'red', 'orange', 'yellow','green'))(20),
										 xlim = bbox(SS_greenestcity)[1, ]+c(-10000,10000),
										 ylim = bbox(SS_greenestcity)[2, ]+c(-10000,10000),
										 scales= list(draw = TRUE),
										 sp.layout = CenterText,
										 main = "Greenest city over the year")
		
		return(list(p.plot, greenestcity))
	} else {
		return(greenestcity)
	}
	
	return(greenestcity)
}