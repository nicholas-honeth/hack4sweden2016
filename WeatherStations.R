
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


##Fetch SMHI JSON data for wind speed in the last hour
hourlyFrame <- fromJSON("http://opendata-download-metobs.smhi.se/api/version/latest/parameter/4/station-set/all/period/latest-hour/data.json", simplifyVector = TRUE)

## Convert to dataframe
weatherStations <- do.call("rbind.fill", lapply(hourlyFrame, as.data.frame))

## Remove nulls
weatherStations <- weatherStations[is.na(weatherStations$longitude) == FALSE,]

## Select columns containing x,y coordinates
coordinates(weatherStations) = ~longitude + latitude

## Test plot - this will show the wrong projection though
#plot(weatherStations)

## Set the correct WGS84 coordinate reseternce system (TODO: Check up on exactly what SMHI uses)
proj4string(weatherStations) = CRS("+init=epsg:4326")

## Test plot again - now the shape of Sweden should be clearer
#plot(weatherStations)

## Derive the bounding box from the data
#latLongBox = bbox(spTransform(weatherStations, CRS("+init=epsg:4326")))

## Fetch OSM data for the region in the bounding box
#map = openmap(c(latLongBox[2, 2], latLongBox[1, 1]), c(latLongBox[2, 1], latLongBox[1, 2]), type = "osm")

#plot(map)
## Plot the weather station positions transformed to OSM data
#points(spTransform(weatherStations, osm()))


## Pick out entries from "value" to a new list which we populate with the values
for (i in 1:length(weatherStations)) {  if (!is.null(weatherStations$value[[i]][2])) values[i] <- (as.double(weatherStations$value[[i]][2])) else values[i] <- NA  }

## Add the values as numerics to the weatherStations frames
weatherStations$values <- as.numeric(values)

library("ggplot2")
weatherStations@data = cbind(weatherStations@data, coordinates(weatherStations))


ggplot(weatherStations@data) + geom_point(aes(x = longitude, y = latitude, colour = round(values))) + coord_equal()

#shape <- readOGR(dsn="C:/Users/nicho/Dropbox/Documents/Development/R/Hack4Sweden/clone/hack4sweden2016/Data", layer="lansgranser")
shape <- readOGR(dsn="Data", layer="lansgranser")


## Transforms the projection used in the SCB map to the same projection as SMHI
shape.epsg <- spTransform(shape, CRS("+init=epsg:4326"))

## Maps the weather stations to the län polygons that they belong to
stationsPerLan <- over(SpatialPolygons(shape.epsg@polygons), SpatialPoints(weatherStations),returnList = TRUE)

 unlist(lapply(stationsPerLan, length))


## Calculate the mena for each län
meanWind <- list(numeric)
for(i in 1:length(stationsPerLan)) {meanWind[i] = mean(as.numeric(values[stationsPerLan[[i]]]), na.rm=TRUE)}
shape$windAvg  <- as.numeric(meanWind)

## Calculate each Län wind as a factor of the maximum windy Län
shape$windFactor  <- as.numeric(meanWind)/max(as.numeric(values),na.rm = TRUE)


## Plot a heat map of 100 stages
plot(shape, col=heat.colors(100)[round(shape$windFactor*100)])
