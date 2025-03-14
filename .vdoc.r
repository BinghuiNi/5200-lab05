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
rr <- tags$div(
   HTML('<h3 align="center" style="font-size:16px"><b>DC Population Heatmap by Ward</b></h3>')
 )

plt <- leaflet(wards) %>%
  setView(lng = -77, lat = 38.9, zoom = 11) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(data = wards, 
              fillColor = ~colorNumeric(palette = "Blues", domain = wards$DP05_0001E)(DP05_0001E),
              weight = 1, opacity = 1, color = "white", fillOpacity = 0.7) %>%
  addControl(rr, position = "bottomright") %>%
  addLabelOnlyMarkers(data = wards,
                    lng = ~st_coordinates(geometry)[, 1], 
                    lat = ~st_coordinates(geometry)[, 2], 
                    label = ~as.character(DP05_0001E), 
                    labelOptions = labelOptions(noHide = TRUE, 
                                                direction = "center", 
                                                textsize = "12px", 
                                                fontface = "bold", 
                                                color = "red"))

plt
#
#
#
#
#
#
#
