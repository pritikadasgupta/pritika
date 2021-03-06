#' Scan through all experiment and userId combos and gather data into a dataframe. 
#' 
#' Loads data with loadAccelerometerFileData function
#' Extracts observation locations from a pre-existing labels dataframe.
#' Extract observations as dataframes and save as a column in dataframe.
#' 
#' #' Requires "labels" to be in the global environment
#' 
#' Source code from: https://blogs.rstudio.com/tensorflow/posts/2018-07-17-activity-detection/
#' Edits made by Pritika Dasgupta
#' 
#' 
#' @param curExperiment (numeric)
#' @param curUserId (numeric)
#' @return (data.frame)
#' @export

scanAccelerometerObservations <- function(curExperiment, curUserId, activityLabels){
  rename(right_join(map2_df(curExperiment, curUserId, loadAccelerometerFileData),activityLabels, by = c("activity" = "number")),activityName = label)
}
