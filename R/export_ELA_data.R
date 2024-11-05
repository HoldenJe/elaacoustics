#' export_ELA_data
#'
#' @param evfile The name and file path to the required ev file
#' @param calfile The name and file path to the required calibration file
#' @description
#' This function provides COM control over Echoview Software. A user must have all of the necessary licenses and permissions to run Echoview.
#'
#' @return Returns usethis messages to provide status of progress of COM application
#' @export
#'
#' @examples
#' \dontrun{
#' export_ELA_data("myev.EV")
#' all_ev_files <- dir(recursive = TRUE, pattern = "EV$", full.names = TRUE)
#' lapply(all_ev_files, export_ELA_data)
#' }

export_ELA_data <- function(evfile, calfile){
  # load Echoview ----
  suppressWarnings(require(usethis))
  require(RDCOMClient)
  EVAppObj <- RDCOMClient::COMCreate("EchoviewCom.EvApplication")
  FullFileName <- file.path(getwd(), evfile)
  if(!file.exists(FullFileName)) {
    usethis::ui_stop(paste0(FullFileName, " does not exist."))
    }
  EVFile <- EVAppObj$OpenFile(FullFileName)
  on.exit(EVAppObj$Quit(), add = TRUE)

  ## transect directory required for downstream exports
  transect_dir <- sapply(strsplit(evfile, split = "/"), "[", 1)

  ## set calibration file
  FullCalFile <- file.path(getwd(), calfile)
  if(!file.exists(FullCalFile)) {
    usethis::ui_stop(paste0(FullCalFile, " does not exist."))
  }
  EVFile[["Filesets"]][[0]]$SetCalibrationFile(FullCalFile)

  ## add start end points for transects/cell exports
  EVAppObj$Exec("Ev File | ExportAnalysisVariables += | LatE LonE LatS LonS")

  # Check all necessary variable exist ----
  FinalSv <- EVFile[["Variables"]]$FindByName("Mask 1")
  if(is.null(FinalSv)) {usethis::ui_stop("Mask1 not found. Does the template match the expected format?")}
  FinalST <- EVFile[["Variables"]]$FindByName("Single target detection - split beam (method 2) 1")
  if(is.null(FinalST)) {usethis::ui_stop("Single Target variable not found. Does the template match the expected format?")}

  region_count <- EVFile[["Regions"]]$Count()

  HasRegions <- region_count > 0
  if(!HasRegions) {
    usethis::ui_stop("No regions have been defined.")
  }

  check_region_fishtrack <- function(index_value) {
    region <- EVFile[["Regions"]]$Item(index_value)
    region$RegionType() == 3 # 1 is EV's enum value for Fish tracks
  }

  HasFishTracks <- any(sapply(c(0:(region_count-1)), check_region_fishtrack))

  if(!HasFishTracks){
    usethis::ui_oops("There are no fish tracks to export.")
  }

  # Export Sv by region by cell ----
  ## Set export parameters
  FinalSv_propGrid <- FinalSv[["Properties"]][["Grid"]]
  FinalSv_propGrid$SetDepthRangeGrid(1, 200)
  FinalSv_propGrid$SetTimeDistanceGrid(5, 10000)

  ## check for Survey Analysis regions
  check_region_analysis <- function(index_value) {
    region <- EVFile[["Regions"]]$Item(index_value)
    region$RegionType() == 1 # 1 is EV's enum value for Analysis Regions
  }

  # HasAnalysisRegions <- any(sapply(c(0:(region_count-1)), check_region_analysis))
  SurveyRegion <-EVFile[["Regions"]]$FindByName("Survey")
  HasSurveyRegion <- !is.null(SurveyRegion)

  if(!HasSurveyRegion){
    # Create survey region if not already done
    TopLine = EVFile[['Lines']]$FindByName('NearSurfaceExclusion') # set top line
    BottomLine = EVFile[['Lines']]$FindByName('Bottom_Backstepped') # set bottom line
    NewRegion = FinalSv$CreateLineRelativeRegion("Survey",TopLine,BottomLine,-1,-1)
    EpiClassObj = EVFile[['RegionClasses']]$FindByName('Unclassified regions')
    NewRegion[['RegionType']] = 1
    usethis::ui_done("Line relative Survey region created.")
  }

  if (FinalSv$ExportIntegrationByRegionsByCellsAll(
    file.path(getwd(), transect_dir,"intg.csv"))) {
    usethis::ui_done("Sv by Regions by Cell Exported as intg.csv")
  } else {
    ui_oops("Something went wrong, Sv not exported.")}

  # Export Fishtracks
  FinalST_propGrid <- FinalST[["Properties"]][["Grid"]]
  FinalST_propGrid$SetDepthRangeGrid(1, 200)
  FinalST_propGrid$SetTimeDistanceGrid(5, 10000)
  if (FinalST$ExportFishTracksByRegionsAll(
    file.path(getwd(), transect_dir, "fishtracks.csv"))) {
    usethis::ui_done("Fishtracks exported as fishtracks.csv")
  } else {
    ui_oops("Something went wrong, fishtracks not exported.")}

  # Export Single Targets
  if (FinalST$ExportSingleTargetsByRegionsByCellsAll(file.path(getwd(), transect_dir,
                                                               "single_targets_transect.csv"))) {
    usethis::ui_done("Fishtracks exported as single_targets_transect.csv")
  } else {
    ui_oops("Something went wrong, single targets not exported.")}

  if(all(
    EVFile$Save(),
    EVFile$Close()
  )) {ui_done(paste0(evfile, " has been completed."))}
  ui_info(Sys.time())
  cat("\n")
}
