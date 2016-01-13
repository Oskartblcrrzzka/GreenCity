# Student: William Schuch & Rik van Berkum
# Team: Geodetic Engineers of Utrecht
# Institute: Wageningen University and Research
# Course: Geo-scripting (GRS-33806)
# Date: 2016-01-12
# Week 2, Lesson 7: Vector - Raster

GreenestCityOfTheMonth <- function(monthnumber,plot_or_not){
	
	# bricking the right raster
	mon <- stack@layers[monthnumber]
	monbrick <- brick(mon)
	
	# create a mask
	monMask <- mask(monbrick, nlCitySinu)
	
	# extract
	monMean <- extract(monMask, nlCitySinu, sp=TRUE, df=TRUE, fun=mean)
	
	# highest greenvalue
	maximum <- max(monMean@data[16], na.rm = TRUE)

	# find rownumber
	maxrownr <- which(monMean@data[16] == maximum[1])

	# lookup city name
	greenestcity <- monMean$NAME_2[maxrownr]
	
	# create a subset of the greenest city
	SS_greenestcity <- subset(monMean, monMean$NAME_2==greenestcity, drop = FALSE)

	if (plot_or_not == TRUE) {
		
		GetCenterX <- (bbox(SS_greenestcity)[1,1]+bbox(SS_greenestcity)[1,2])/2
		GetCenterY <- (bbox(SS_greenestcity)[2,1]+bbox(SS_greenestcity)[2,2])/2
		
		MonthnumberToMonth <- c("January", "February", "March", "April", "May", "June", "July", "August",
														"September", "October", "November", "December")
		MonthChar <- MonthnumberToMonth[monthnumber]
		
		CenterText = list("sp.text", c(GetCenterX,GetCenterY), greenestcity)
		p.plot <- spplot(monMean, zcol = MonthChar,
					 col.regions=colorRampPalette(c('darkred', 'red', 'orange', 'yellow','green'))(20),
					 xlim = bbox(SS_greenestcity)[1, ]+c(-10000,10000),
					 ylim = bbox(SS_greenestcity)[2, ]+c(-10000,10000),
					 scales= list(draw = TRUE),
					 sp.layout = CenterText,
					 main = paste(as.character("Greenest city of the month"),as.character(MonthChar)) )
		
		return(list(p.plot, greenestcity))
	} else {
		return(greenestcity)
	}
}
