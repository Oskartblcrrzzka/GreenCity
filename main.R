# Student: William Schuch & Rik van Berkum
# Team: Geodetic Engineers of Utrecht
# Institute: Wageningen University and Research
# Course: Geo-scripting (GRS-33806)
# Date: 2016-01-12
# Week 2, Lesson 7: Vector - Raster

rm(list = ls())  # Clear the workspace!
ls() ## no objects left in the workspace

# Installing packages (If you get an error with the 'extract' function)
#install.packages("raster")

# load librarys
library(raster)
library(sp)
library(rgdal)
library(rgeos)

# referring to functions in R folder
source("./R/Preprocessing.R")
source("./R/GreenestCityOfTheMonth.R")
source("./R/GreenestCityOverTheYearAverage.R")

# calculate greenest city of every month and plotting it Y/N
GreenestCityOfTheMonth(5,TRUE)
GreenestCityOfTheMonth(8,TRUE)
GreenestCityOfTheMonth(1,FALSE)

# calculate greenest city on average over the year, also 'plottable'!
GreenestCityOverTheYearAverage(TRUE)
GreenestCityOverTheYearAverage(FALSE)
