## Import kml files and save as shapefiles and ggplot basemap files
library(sf)
library(ggplot2)

shape_lake379 <- sf::st_read("data-raw/Lake379.kml")
usethis::use_data(shape_lake379, overwrite = TRUE)

basemap_lake379 <- ggplot2::ggplot() + ggplot2::geom_sf(data = shape_lake379)
usethis::use_data(basemap_lake379, overwrite = TRUE)

shape_lake259 <- sf::st_read("data-raw/Lake259.kml")
usethis::use_data(shape_lake259, overwrite = TRUE)

basemap_lake259 <- ggplot2::ggplot() + ggplot2::geom_sf(data = shape_lake259)
usethis::use_data(basemap_lake259, overwrite = TRUE)

shape_lake622 <- sf::st_read("data-raw/Lake622.kml")
usethis::use_data(shape_lake622, overwrite = TRUE)

basemap_lake622 <- ggplot2::ggplot() + ggplot2::geom_sf(data = shape_lake622)
usethis::use_data(basemap_lake622, overwrite = TRUE)

shape_lake623 <- sf::st_read("data-raw/Lake623.kml")
usethis::use_data(shape_lake623, overwrite = TRUE)

basemap_lake623 <- ggplot2::ggplot() + ggplot2::geom_sf(data = shape_lake623)
usethis::use_data(basemap_lake623, overwrite = TRUE)


