#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
library(tidyverse)
library(sf) # simple features in R, enables geographic viz
library(geojsonsf) # reading GeoJSON files into the right format
library(leaflet) # interactive maps
library(tmap) # package for static and interactive maps following GoG
library(spData) # data package for spatial data
library(usmap) # US map data

library(htmlwidgets)
library(htmltools) # HTML manipulation
#
#
#
#
#
zipcodes <- geojson_sf("data/zip-codes/Zip_Codes.geojson")
dc <- geojson_sf("data/dc-boundary/Washington_DC_Boundary.geojson")
metro <- geojson_sf("data/metro-stations/Metro_Stations_Regional.geojson")
wards <- geojson_sf("data/wards/ACS_Demographic_Characteristics_DC_Ward.geojson")
#
#
#
#
#
wards_map <- tm_shape(wards) + 
  tm_polygons(col = "DP05_0001E", palette = "Blues", style = "cont", title = "Total Population") + 
  tm_layout(main.title = "DC Population Heatmap by Ward", frame = FALSE) +
  tm_text(text = "DP05_0001E", size = 1, col = "red", fontface = "bold")
wards_map
#
#
#
#
#
tmap_mode("view")
tm_basemap(leaflet::providers$CartoDB.Positron) +
  wards_map
#
#
#
#
#
#
#
