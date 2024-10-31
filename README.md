
<!-- README.md is generated from README.Rmd. Please edit that file -->

# elaacoustics

<!-- badges: start -->
<!-- badges: end -->

The goal of elaacoustics is to …

## Installation

You can install the development version of elaacoustics like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Example

This is an example of how to use the basemaps for each lake.

``` r
library(elaacoustics)
library(ggplot2)
#> Warning: package 'ggplot2' was built under R version 4.4.1
basemap_lake379
```

<img src="man/figures/README-example1-1.png" width="100%" />

This is an example of how to add a point to basemaps for each lake.

``` r
library(elaacoustics)
library(ggplot2)
basemap_lake379 + geom_point(aes(x = -93.799462, y = 49.708170), pch = 13, size = 4)
```

<img src="man/figures/README-example2-1.png" width="100%" />

This is an example of how to combine multiple lake files on a single
plot.

``` r
library(elaacoustics)
library(ggplot2)
ggplot()+ 
  geom_sf(data = shape_lake379, fill = 'blue') + 
  geom_sf(data = shape_lake259, fill = 'blue') +
  geom_point(aes(x = -93.799462, y = 49.708170), pch = 13, size = 4, colour = "yellow") +
  theme_bw() +
  ylab("Latitude") + xlab("Longitude") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

<img src="man/figures/README-example3-1.png" width="100%" />
