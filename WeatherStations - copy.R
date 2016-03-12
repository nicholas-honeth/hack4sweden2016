
library(jsonlite)
library(XML)
library("sp")
library(plyr)
library("raster")
library("rgdal")
library("rgeos")
library("OpenStreetMap")
library("ggplot2")

## Inspiration from: 
## http://www.maths.lancs.ac.uk/~rowlings/Teaching/UseR2012/crime.html

##Fetch SMHI JSON data for rainfall in the last hour
hourlyFrame <- fromJSON("http://opendata-download-metobs.smhi.se/api/version/latest/parameter/7/station-set/all/period/latest-hour/data.json", simplifyVector = TRUE)

## Convert to dataframe
weatherStations <- do.call("rbind.fill", lapply(hourlyFrame, as.data.frame))

## Remove nulls
weatherStations <- weatherStations[is.na(weatherStations$longitude) == FALSE,]

## Select columns containing x,y coordinates
coordinates(weatherStations) = ~longitude + latitude

## Test plot - this will show the wrong projection though
plot(weatherStations)

## Set the correct WGS84 coordinate reseternce system (TODO: Check up on exactly what SMHI uses)
proj4string(weatherStations) = CRS("+init=epsg:4326")

## Test plot again - now the shape of Sweden should be clearer
plot(weatherStations)

## Derive the bounding box from the data
latLongBox = bbox(spTransform(weatherStations, CRS("+init=epsg:4326")))

## Fetch OSM data for the region in the bounding box
map = openmap(c(latLongBox[2, 2], latLongBox[1, 1]), c(latLongBox[2, 1], latLongBox[1, 2]), type = "osm")

plot(map)
## Plot the weather station positions transformed to OSM data
points(spTransform(weatherStations, osm()))

## TODO: Figure out how to reference the data in WeatherStations$value like the "value" fainfall in mm and use it in the plot.

