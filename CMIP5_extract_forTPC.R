############################
#### code to extract projected temperature values from CMIP5 projection models
#creatd May 19, 2018 by JB, based on code snippets from CC
############################

library(raster)

###
# 1) RCP 8.5 mean trend
setwd("/Users/jbruno/Documents/GitHub/CoralThermalTolerance/CMIP5_extract")

#load warming data: Rate of incrase for mean SST 8.5
source("revrotate.R") 
meanTrend8.5N<-raster("trend_yearmean_ensemble_tos_RCP85.nc") #cmip5 trends of the mean, rcp8.5 coarse-grained 
extent(meanTrend8.5N)<-c(-180,180,-90,90) #need to reset for this layer, orginal orientation was 0-360 longitude
plot(meanTrend8.5N) #have a look
meanTrend8.5N<-revrotate(meanTrend8.5N)
extent(meanTrend8.5N)<-c(-180,180,-90,90)
plot(meanTrend8.5N)

print(meanTrend8.5N) 
head(meanTrend8.5N) #check values
hist(meanTrend8.5N) 
density((meanTrend8.5N), main="Mean trend RCP8.5")

#load coordinates
Bermuda<-read.csv("Bermuda.csv")
mpa_coord <- read.csv("mpa_coords.csv")

#set coordinates
coordinates(nn.buffered.dat)<-~Centroid_Longitude+Centroid_Latitude

plot(meanTrend8.5N, main = ("RCP 8.5 warming rate for mean SST"),  ylim = c(-71.2, 71.2), col=rev(rainbow(200, start=.8, end=.23)))
points(mpa_coord[,c(1,2)], pch=20, cex=.5)

#extract values 
BermudaTrend8.5N<-extract(meanTrend8.5N, Bermuda)
mpa_coordTrend8.5N<-extract(meanTrend8.5N, mpa_coord)

head(BermudaTrend8.5N)
head(mpa_coordTrend8.5N)

mean(BermudaTrend8.5N) #0.03326017 C / yr
hist(BermudaTrend8.5N, main="Mean trend RCP8.5")
hist(BermudaTrend8.5N*100) #roughly warming over the next century

###
# 2 RCP 8.5 max trend
#load warming data: Rate of incrase for max SST 8.5
source("revrotate.R") 
maxTrend8.5N<-raster("trend_yearmax_ensemble_RCP85.nc") #cmip5 trends of the max, rcp8.5 coarse-grained 
extent(maxTrend8.5N)<-c(-180,180,-90,90) #need to reset for this layer, orginal orientation was 0-360 longitude
plot(maxTrend8.5N) #have a look
maxTrend8.5N<-revrotate(maxTrend8.5N)
extent(maxTrend8.5N)<-c(-180,180,-90,90)
plot(maxTrend8.5N)

plot(maxTrend8.5N, main = ("RCP 8.5 warming rate for max SST"),  ylim = c(-71.2, 71.2), col=rev(rainbow(200, start=.8, end=.23)))
points(mpa_coord[,c(1,2)], pch=20, cex=.5)

Bermuda_MaxTrend8.5N<-extract(maxTrend8.5N, Bermuda)
head(Bermuda_MaxTrend8.5N)
mean(Bermuda_MaxTrend8.5N) #0.03577105 C / yr

###
# 3 RCP 4.5 max trend
#load warming data: Rate of incrase for max SST 4.5
source("revrotate.R") 
maxTrend4.5N<-raster("trend_yearmax_ensemble_RCP45.nc") #cmip5 trends of the max, rcp8.5 coarse-grained 
extent(maxTrend4.5N)<-c(-180,180,-90,90) #need to reset for this layer, orginal orientation was 0-360 longitude
plot(maxTrend4.5N) #have a look
maxTrend4.5N<-revrotate(maxTrend4.5N)
extent(maxTrend4.5N)<-c(-180,180,-90,90)
plot(maxTrend4.5N)

plot(maxTrend4.5N, main = ("RCP 4.5 warming rate for max SST"),  ylim = c(-71.2, 71.2), col=rev(rainbow(200, start=.8, end=.23)))
points(mpa_coord[,c(1,2)], pch=20, cex=.5)

Bermuda_MaxTrend4.5N<-extract(maxTrend4.5N, Bermuda)
head(Bermuda_MaxTrend4.5N)
mean(Bermuda_MaxTrend4.5N) #0.0155957 C / yr
