# Student: William Schuch & Rik van Berkum
# Team: Geodetic Engineers of Utrecht
# Institute: Wageningen University and Research
# Course: Geo-scripting (GRS-33806)
# Date: 2016-01-12
# Week 2, Lesson 7: Vector - Raster

rm(list = ls())  # Clear the workspace!
ls() ## no objects left in the workspace

# load librarys
library(raster)
library(sp)
library(rgdal)
library(rgeos)

# referring to functions in R folder
source("./R/GreenestCityOfTheMonth.R")
source("./R/GreenestCityOverTheYearAverage.R")

# unzip the MODUS pack
unzip("./data/MODIS.zip", exdir = "./data")

# bricking and stacking of the raster
modisgrdpath <- "./data/MOD13A3.A2014001.h18v03.005.grd"
modisbrick <- brick(modisgrdpath)
stack <- stack(modisbrick)

# calculate greenest city in January
GreenestCityOfTheMonth(1)
# calculate greenest city in August
GreenestCityOfTheMonth(8)

# calculate greenest city on average over the year
GreenestCityOverTheYearAverage()

# calculate greenest city in July and plotting it Y/N
GreenestCityOfTheMonth(7,TRUE)

# - - - - - - 


# load myfunction
source("./R/greencityfunction.R")
# greenest city in january
myfunction(1)
# greenest city in august
myfunction(8)

# load year avarage
source("./R/yearavg.R")
