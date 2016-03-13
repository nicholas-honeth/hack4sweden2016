# The purpose of this script is to generate a data frame of rainfall timeseries
# averaged per regions in Sweden
# Expected data frame is n observations and 22 columns
# 21 columns represent the different regions in Sweden
# 1 column represents the risk of floods (either 0, 0.2, 0.4, 0.6, 0.8 or 1.0)

stationsdf <- read.csv2(file="Data/weatherStations_location_code.csv",stringsAsFactors = F)
stationsdf$latlong  <- paste(stationsdf$Latitud,stationsdf$Longitud, sep = ":")

for (i in 1:dim(stationsdf)[1]){
        URL <- paste("http://opendata-download-metobs.smhi.se/api/version/latest/parameter/5/station/",stationsdf$Stationsnummer[i],"/period/corrected-archive/data.csv",sep="")
        destfile <- paste("data/rainfall/",stationsdf$Stationsnummer[i], ".csv", sep="")
        download.file(URL,destfile)
}