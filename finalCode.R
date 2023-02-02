library(raster)
library(tigris)
library(ggplot2)
library(rgdal)
library(leaflet)
library(sf)

# tracts = st_read("https://services5.arcgis.com/GfwWNkhOj9bNBqoJ/arcgis/rest/services/NYC_Census_Tracts_for_2020_US_Census/FeatureServer/0/query?where=1=1&outFields=*&outSR=4326&f=pgeojson", stringsAsFactors=F, quiet=T)

#tracts = tracts(state= "NY", c("Kings", "New York", "Bronx", "Richmond", "Queens"))
tracts = tracts(state= "NJ", "Essex")
income <- read.table("medianIncomeNYC.csv", header=TRUE, sep=",", stringsAsFactors = TRUE)
View(income)

plot(tracts)
## Names the bands
red = raster("redBand.TIF")
near.infrared = raster("nirBand.TIF")

#boundary = raster(ymx=40.932, xmn=-74.268, ymn=40.481, xmx=-73.634)
#boundary = raster(as_Spatial(tracts))
#boundary = projectExtent(boundary, red@crs)

#red = crop(red, boundary)
#near.infrared = crop(near.infrared, boundary)

## Calculate NDVI(Normalized Difference Vegetation Index). 
### Formula is commonly NDVI = (NIR - Red)/(NIR + Red)
ndvi = (near.infrared - red) / (near.infrared + red)

### Add census tracts of NYC
#nyc_blocks <- tracts(state = "NY", county = "" cb = TRUE)

ggplot(nyc_blocks) + geom_sf(fill = "grey", color = "black")

colors = colorRampPalette(c("red3", "white", "darkcyan"))(255)
#hist(ndvi) # used to determine which NDVI values should be included in the plotting. Natural range is -1 to 1. Sharp spike in negative values and plotting inclusive of negative values demonstrates that negative values are water. To avoid confusion, negative values were excluded

## High NDVI values (1) indicate high vegetation, while low NDVI values indicate low vegetation
plot(ndvi, zlim=c(0, 0.6), col=colors, interpolate=T, axes=F, box=F)

df <- cbind(nyc_blocks, NDVI = raster::extract(ndvi, nyc_blocks))

ggplot(df) + geom_sf(aes(fill = NDVI), color = "black") + scale_fill_gradient(low = "red", high = "green")
