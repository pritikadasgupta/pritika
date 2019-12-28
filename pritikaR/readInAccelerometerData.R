# Read contents of single file to a dataframe with accelerometer data

# Must be in format


readInAccelerometerData <- function(experiment, userId){
  genFilePath = function(type) {
    paste0("RawData/", type, "_exp",experiment, "_user", userId, ".txt")
  }  
  
  bind_cols(
    read.table(genFilePath("acc"), col.names = c("a_x", "a_y", "a_z"))
  )
}