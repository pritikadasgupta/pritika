#' Function to read a given file and get the accel observations contained along with their classes/labels.
#' 
#' Loads data with readInAccelerometerData function.
#' Extracts observation locations from a pre-existing labels dataframe.
#' Extract observations as dataframes and save as a column in dataframe.
#' 
#' Requires "labels" to be in the global environment
#' 
#' Source code from: https://blogs.rstudio.com/tensorflow/posts/2018-07-17-activity-detection/
#' Edits made by Pritika Dasgupta
#' 
#' 
#' @param curExperiment (numeric)
#' @param curUserId (numeric)
#' @return (data.frame)
#' @export

loadAccelerometerFileData <- function(curExperiment, curUserId) {
  
  # load accelerometer data from file into dataframe
  allData <- readInAccelerometerData(curExperiment, curUserId)
  
  extractObservation <- function(startPos, endPos){
    allData[startPos:endPos,]
  }
  
  # get observation locations in this file from labels dataframe
  dataLabels <- filter(labels, userId == as.integer(curUserId), experiment == as.integer(curExperiment))
  
  
  # extract observations as dataframes and save as a column in dataframe.
    select(mutate(dataLabels, data = map2(startPos, endPos, extractObservation)),
           -startPos, -endPos)
}