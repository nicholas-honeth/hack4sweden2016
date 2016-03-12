# 21 columns represent the different regions in Sweden
  # 1 column represents the risk of floods (either 0, 0.2, 0.4, 0.6, 0.8 or 1.0)

library(RCurl)

 stationsdf <- read.csv2(file="Data/weatherStations_location_code.csv",stringsAsFactors = F)
 stationsdf$latlong  <- paste(stationsdf$Latitud,stationsdf$Longitud, sep = ":")

 for (i in 1:dim(stationsdf)[1]){
        URL <- paste("http://opendata-download-metobs.smhi.se/api/version/latest/parameter/2/station/",stationsdf$Stationsnummer[i],"/period/corrected-archive/data.csv",sep="")
        destfile <- paste("Data/temperature/",stationsdf$Stationsnummer[i], ".csv", sep="")
        if (!file.exists(destfile)) {
          if(url.exists(URL)){
                  download.file(URL,destfile)
          }
        }
 }

require(tools)
stationsdf <- read.csv2(file="Data/weatherStations_location_code.csv",stringsAsFactors = F)
stationsdf$latlong  <- paste(stationsdf$Latitud,stationsdf$Longitud, sep = ":")

filenames <- list.files("Data/temperature")
for (i in 1:length(filenames)){
       filenames[i] <- strsplit(filenames[i],".csv")[[1]]
}

for (i in 1:length(filenames)){
               print(filenames[i])
               destfile <- paste("Data/rainfall/",filenames[i],".csv",sep="")
               if (stationsdf$rainfall[stationsdf$Stationsnummer == filenames[i]] != NULL) stationsdf$rainfall[stationsdf$Stationsnummer == filenames[i]] <- read.csv2(file=destfile, stringsAsFactors = F, skip = grep(pattern="Datum",readLines(destfile))-1)
}
