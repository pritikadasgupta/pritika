#' Read contents of single file to a dataframe with accelerometer data
#' 
#' Must be in a text file, with three columns (denoting x, y, z accelerometer measurements)
#' Example below:
#' -0.244231611662574 6.13990040832691 -0.478497713025528
#' 
#' @param directory the directory (string/character)
#' @param experiment the experiment we're querying (numeric)
#' @param userId the user ID we're querying (numeric)
#' @return A vector of column names matching the keyword
#' @export


readInAccelerometerData <- function(directory,experiment, userId){
  genFilePath = function(type) {
    paste0(directory, type, "_exp",experiment, "_user", userId, ".txt")
  }  
  
  bind_cols(
    read.table(genFilePath("acc"), col.names = c("a_x", "a_y", "a_z"))
  )
}