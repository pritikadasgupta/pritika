#' Takes Accelerometer Data (from xlsx) and converts to txt file
#' 
#' Also resamples and filters (butterworth)
#' Resample Function: resampleAccelerometerData.R
#' 
#' @param df (data.frame)
#' @param desiredFs desired sampling frequency
#' @param n Order of the filter
#' @param to end frequency (in Hz) where to apply the filter
#' @return (data.frame)
#' @export

accelerometerDataToText <- function(wd,newwd,desiredFs,n,to,experimentNum) {
  require(readxl)
  setwd(wd)
  
  #create a list of the files from your target directory
  file_list <- list.files(path=wd)
  
  x <- file_list
  file_list_ID <- as.numeric(gsub("\\D", "", x))
  reference <- data.frame(file_list_ID,file_list,stringsAsFactors = FALSE)
  labels_final <- vector()
  
  for (i in 1:length(reference$file_list_ID)){
    setwd(wd) 
    subject <- reference$file_list_ID[i]
    file <- reference$file_list[i]
    df <- read_excel(file)
    
    names(df)[5] <- "Code"
    df$Code <- as.factor(df$Code)
    
    dfList <- list()
    for (j in 1:length(levels(df$Code))){
      x <- subset(df, df$Code==j)
      y <- resampleAccelerometerData(x,100,5,12.5)
      dfList[[j]] <- y
    }

    
    experiment <- rep(1,length(levels(df$Code)))
    userID <- rep(subject,length(levels(df$Code)))
    activity <- as.numeric(levels(df$Code))
    
    startPos <- c(1)
    data <- rbind(dfList[[1]])
    endPos <- c(nrow(data))
    for (j in 2:length(levels(df$Code))){
      startPos <- append(startPos,nrow(data)+1)
      data <- rbind(data,dfList[[j]])
      endPos <- append(endPos,nrow(data))
      }
    
    labels <- cbind(experiment,userID,activity,startPos,endPos)
    labels_final <- rbind(labels_final,labels)
    
    setwd(newwd) 
    write.table(data[,2:4], paste("acc_exp",experimentNum,"_user",subject,".txt",sep=""),row.names=FALSE,col.names=FALSE) 
  }
  
  setwd(newwd) 
  write.table(labels_final, "labels.txt",row.names=FALSE,col.names=FALSE) 
  
}


