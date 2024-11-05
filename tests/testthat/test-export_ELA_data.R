# test that export_ELA_data function fails as required

devtools::load_all()
setwd(here::here("data-raw"))

if(file.exists("ELA_TEST/intg.csv")) {file.remove("ELA_TEST/intg.csv")}
if(file.exists("ELA_TEST/fishtracks.csv")){file.remove("ELA_TEST/fishtracks.csv")}
if(file.exists("ELA_TEST/single_targets_transect.csv")){file.remove("ELA_TEST/single_targets_transect.csv")}


test_that("fails with no Mask 1", {
  expect_error(export_ELA_data("ELA_TEST/ELA_TEST_NoMask.EV", "Simrad_ELA_2024.ecs"))
})

test_that("fails with no Single Target variable", {
  expect_error(export_ELA_data("ELA_TEST/ELA_TEST_NoST.EV", "Simrad_ELA_2024.ecs"))
})

test_that("fails with no regions defined", {
  expect_error(export_ELA_data("ELA_TEST/ELA_TEST_NoRegions.EV", "Simrad_ELA_2024.ecs"))
})

test_that("ELA_TEST does not fail", {
  expect_no_error(export_ELA_data("ELA_TEST/ELA_TEST.EV", "Simrad_ELA_2024.ecs"))
})

test_that("csv files created", {
  expect_true(file.exists("ELA_TEST/intg.csv"))
  expect_true(file.exists("ELA_TEST/fishtracks.csv"))
  expect_true(file.exists("ELA_TEST/single_targets_transect.csv"))
})

setwd(here::here())
