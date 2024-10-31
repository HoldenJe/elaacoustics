# tests/testthat/test-LakeMapObjects.R

# Load necessary libraries
suppressWarnings(library(testthat))
suppressWarnings(library(sf))

### lake 259 ----
test_that("basemap_lake259 is a valid ggplot object", {
  # Load the data object
  data("basemap_lake259", package = "elaacoustics")

  # Check if basemap_lake259 is a ggplot object
  expect_s3_class(basemap_lake259, "ggplot")

  # Check the number of layers
  expect_equal(length(basemap_lake259$layers), 1)
})

test_that("shape_lake259 is a valid sf object", {
  # Load the shapefile
  data("shape_lake259", package = "elaacoustics")

  # Check that shape_lake259 is an sf object
  expect_s3_class(shape_lake259, "sf")
})

test_that("Coordinate is within lake259 boundary", {
  # Define the coordinate to check
  point <- st_sfc(st_point(c(-93.784015, 49.689958)), crs = st_crs(shape_lake259))

  # Test if the point falls within any of the polygons in shape_lake259
  point_within_boundary <- any(st_contains(shape_lake259, point, sparse = FALSE))

  # Expect that the point is within a boundary
  expect_true(point_within_boundary, info = "The coordinate is outside the expected boundaries.")
})

### lake 379 ----
test_that("basemap_lake379 is a valid ggplot object", {
  # Load the data object
  data("basemap_lake379", package = "elaacoustics")

  # Check if basemap_lake259 is a ggplot object
  expect_s3_class(basemap_lake379, "ggplot")

  # Check the number of layers
  expect_equal(length(basemap_lake379$layers), 1)
})

test_that("shape_lake379 is a valid sf object", {
  # Load the shapefile
  data("shape_lake379", package = "elaacoustics")

  # Check that shape_lake379 is an sf object
  expect_s3_class(shape_lake379, "sf")
})

test_that("Coordinate is within lake379 boundary", {
  # Define the coordinate to check
  point <- st_sfc(st_point(c(-93.799462, 49.708170)), crs = st_crs(shape_lake379))

  # Test if the point falls within any of the polygons in shape_lake379
  point_within_boundary <- any(st_contains(shape_lake379, point, sparse = FALSE))

  # Expect that the point is within a boundary
  expect_true(point_within_boundary, info = "The coordinate is outside the expected boundaries.")
})

### Lake 622 ----
test_that("basemap_lake622 is a valid ggplot object", {
  # Load the data object
  data("basemap_lake622", package = "elaacoustics")

  # Check if basemap_lake622 is a ggplot object
  expect_s3_class(basemap_lake622, "ggplot")

  # Check the number of layers
  expect_equal(length(basemap_lake622$layers), 1)
})

test_that("shape_lake622 is a valid sf object", {
  # Load the shapefile
  data("shape_lake622", package = "elaacoustics")

  # Check that shape_lake622 is an sf object
  expect_s3_class(shape_lake622, "sf")
})

test_that("Coordinate is within lake622 boundary", {
  # Define the coordinate to check
  point <- st_sfc(st_point(c(-93.837532,  49.764347)), crs = st_crs(shape_lake622))

  # Test if the point falls within any of the polygons in shape_lake622
  point_within_boundary <- any(st_contains(shape_lake622, point, sparse = FALSE))

  # Expect that the point is within a boundary
  expect_true(point_within_boundary, info = "The coordinate is outside the expected boundaries.")
})

### Lake 623 ----
test_that("basemap_lake623 is a valid ggplot object", {
  # Load the data object
  data("basemap_lake623", package = "elaacoustics")

  # Check if basemap_lake623 is a ggplot object
  expect_s3_class(basemap_lake623, "ggplot")

  # Check the number of layers
  expect_equal(length(basemap_lake623$layers), 1)
})

test_that("shape_lake623 is a valid sf object", {
  # Load the shapefile
  data("shape_lake623", package = "elaacoustics")

  # Check that shape_lake623 is an sf object
  expect_s3_class(shape_lake623, "sf")
})

test_that("Coordinate is within lake623 boundary", {
  # Define the coordinate to check
  point <- st_sfc(st_point(c(-93.848461, 49.762933)), crs = st_crs(shape_lake623))

  # Test if the point falls within any of the polygons in shape_lake623
  point_within_boundary <- any(st_contains(shape_lake623, point, sparse = FALSE))

  # Expect that the point is within a boundary
  expect_true(point_within_boundary, info = "The coordinate is outside the expected boundaries.")
})
