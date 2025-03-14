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
# Restore the existing environment from renv.lock
renv::restore()
#
#
#
#
# Install packages
install.packages("tidyverse")
install.packages("sf")
install.packages("geojsonsf")
install.packages("leaflet")
install.packages("tmap")
install.packages("spData")
install.packages("usmap")
install.packages("htmlwidgets")
install.packages("htmltools")

# Update the renv.lock file
renv::snapshot()
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
counties <- us_map("counties")
full_map <-
  tm_shape(counties, bbox = st_bbox(metro)) + tm_polygons(col = "white")
full_map

wards_map <- full_map +
  tm_shape(wards) + 
  tm_polygons(col = "DP05_0001E", palette = "YlOrRd", style = "cont", title = "Total Population") +  # 为选区着色
  tm_layout(main.title = "Population Heatmap by Ward", frame = FALSE)

# 显示地图
full_map

tm_shape(wards) + 
  tm_polygons(col = "DP05_0001E",
              palette = "YlOrRd",
              style = "cont",
              title = "Total Population") +
  tm_layout(main.title = "Population Heatmap by Ward",
            main.title.position = c("center", "top"),
            frame = FALSE)
#
#
#
