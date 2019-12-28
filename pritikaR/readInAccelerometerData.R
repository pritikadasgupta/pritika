#' Read contents of single file to a dataframe with accelerometer data
#' Source code from: https://blogs.rstudio.com/tensorflow/posts/2018-07-17-activity-detection/
#' Edits made by Pritika Dasgupta
#' 
#' Must be in a text file (.txt), with three columns (denoting x, y, z accelerometer measurements)
#' Example below:
#' -0.244231611662574 6.13990040832691 -0.478497713025528
#' 
#' Text file should be in format: [type]_exp[experiment]_user[userId].txt
#' Example: acc_exp01_user1.txt
#' 
#' @param directory the directory (string/character)
#' @param experiment the experiment we're querying (numeric)
#' @param userId the user ID we're querying (numeric)
#' @return 
#' @export


readInAccelerometerData <- function(experiment, userId){
  genFilePath = function(type) {
    paste0(type, "_exp",experiment, "_user", userId, ".txt")
  }  
  
  filePaths <- genFilePath("acc")
  df <- data.frame()
  for (i in 1:length(filePaths)){
    df_ <- bind_cols(read.table(filePaths[i], col.names = c("a_x", "a_y", "a_z")))
    df <- rbind(df,df_)
  }
  df
  
}
