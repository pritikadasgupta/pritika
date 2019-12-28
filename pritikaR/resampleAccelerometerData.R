#' Resamples and Butterworth Filters Accelerometer Data
#' 
#' 
#' @param df (data.frame)
#' @param desiredFs desired sampling frequency
#' @param n Order of the filter
#' @param to end frequency (in Hz) where to apply the filter
#' @return (data.frame)
#' @export

resampleAccelerometerData <- function(df,desiredFs,n,to) {
  require(signal)
  require(seewave)
  
  t = unlist(df[,1])
  dt = mean(diff(t)) 
  fs = 1/dt #current sampling frequency (overall)
  originalX <- unlist(df[,2])
  originalY <- unlist(df[,3])
  originalZ <- unlist(df[,4])

  xrt <- resample(originalX,1/fs,1/desiredFs)
  rt <- seq(0,( (length(xrt)) *(1/desiredFs))-(1/desiredFs),by=1/desiredFs)
  yrt <- resample(originalY,1/fs,1/desiredFs)
  zrt <- resample(originalZ,1/fs,1/desiredFs)
  
  f <- desiredFs #sampling frequency
  ## low-pass
  # 1st order filter
  xrt <- bwfilter(xrt, f=f, n=n, to=to)
  yrt <- bwfilter(yrt, f=f, n=n, to=to)
  zrt <- bwfilter(zrt, f=f, n=n, to=to)
  
  newdf <- as.data.frame(cbind(rt,xrt,yrt,zrt))
  newdf
}
