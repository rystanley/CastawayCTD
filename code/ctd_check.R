#functions to check the status of the data and flag invalid sets

ctd_check <- function(path){

  ## read in data (data.table has a nice and efficient fast reading function)
  dat <-  data.table::fread(path,
                            header = FALSE, sep = "\t",
                            stringsAsFactors = FALSE)
  
  ## remove the "% " at the beginning of the meta-data
  dat <- as.vector(apply(dat,1,function(x) gsub("\\% ","",x)))
  
  if(sum(grepl("Invalid",dat))>0){return("invalid set")}else{return("valid set")}

  
}

ctd_check_batch <- function(paths){
  
  return(do.call("rbind", lapply(paths, function(x) ctd_check(x))))
  
}