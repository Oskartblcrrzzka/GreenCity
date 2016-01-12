# Main 
# Green city

# load librarys
library(raster)
library(sp)
library(rgdal)
library(rgeos)


unzip("./data/MODIS.zip", exdir = "./data/")

modisgrdpath <- "./data/MOD13A3.A2014001.h18v03.005.grd"

modisbrick <- brick(modisgrdpath)

stack <- stack(modisbrick)

# load myfunction
source("./R/greencityfunction.R")
# greenest city in january
myfunction(1)
# greenest city in august
myfunction(8)
