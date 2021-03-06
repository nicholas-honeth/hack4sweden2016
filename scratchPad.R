

## Downloaded GRIB files with large data series from http://opendata-download-grid-archive.smhi.se/explore/?modeltype=5#



## To pick values out of the data frames
for (i in 1:140) {  values[i] <- (weatherStations$value[[i]][2])  }

ogrInfo("C:/Users/nicho/Dropbox/Documents/Development/R/Hack4Sweden/clone/hack4sweden2016/Data", "lansgranser")

shape <- readOGR(dsn="C:/Users/nicho/Dropbox/Documents/Development/R/Hack4Sweden/clone/hack4sweden2016/Data", layer="lansgranser")


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


stationLocations <- read.csv2(file="Data/test_sites_nederbord_flaggtabell_dygn_view.csv", stringsAsFactors = F)


currdf <- read.csv2(file="Data/weatherStations_location_code.csv", stringsAsFactors = F)


ReadGrib("C:/Users/nicho/Dropbox/Documents/Development/QGIS/SMHI/GRIB/201601/AM25H2_201601240000+000H00M", levels, variables,
    domain = NULL, file.type = "grib2", missing.data = NULL)







#Turns the SpatialPolygons in DF
shape.map_df <- fortify(shape)
