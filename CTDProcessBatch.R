CTDProcess_Batch <- function(paths,datetime=T){

  #paths are a vector of file paths which point to the Castaway csv output files
  #datetime - parameter (default is true) which will split the date and time information into individual columns
  
return(do.call("rbind", lapply(filepaths, function(x) CTDProcess(x,datetime=datetime))))

}
