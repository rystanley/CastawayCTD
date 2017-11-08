CTDProcess <- function(path,datetime=T,returncols=F){

  ## function will process the output from a Castaway CTD into a clean tabular format
  
  #Inputs
      #path - a full file path for the input csv
      #datetime - parameter (default is true) which will split the date and time information into individual columns
      #returncols - the data and metadata names provided by Castaway are quite long so I have cleaned them up. 
      #             This is hard coded and can be edited as required. When this parameter is specified as TRUE the
      #             legend of changes will  be printed
  
    ## read in data (data.table has a nice and efficient fast reading function)
      dat <-  data.table::fread(file,
                                header = FALSE, sep = "\t",
                                stringsAsFactors = FALSE)
      
    ## remove the "% " at the beginning of the meta-data
      dat <- as.vector(apply(dat,1,function(x) gsub("\\% ","",x)))
    
    # Take the data recordings from the CTD and assign column names. Note this assumes comma delimited seperation. 
      castdata <- as.data.frame(do.call(rbind, strsplit(dat[grep("Decibar",dat)+1:length(dat)],",")),stringsAsFactors = F)
      castdata <- data.frame(apply(castdata, 2, as.numeric))
      colnames(castdata) <- as.vector(unlist(strsplit(dat[grep("Decibar",dat)],",")))
    
    # Metadata to columns - convert numeric data to numeric
      metadata <- dat[1:(grep("Decibar",dat)-2)]
    
      for (i in metadata){
        castdata$v1 <- unlist(strsplit(i,","))[2]
        if(!sum(suppressWarnings(is.na(as.numeric(castdata[1:5,"v1"]))))>1){castdata$v1=as.numeric(castdata$v1)}
        colnames(castdata)[length(castdata)] <- unlist(strsplit(i,","))[1]
      }
    
    ## Clean up the column names ** note that this part of the analysis assumes the metainformation is fixed (i.e., every cast has the same header info)
      BetterNames <- data.frame(old=names(castdata),
                           new=c("Pressure","Depth","Temperature","Conductivity",
                             "Conductance","Salinity","SoundVelocity","Density",
                             "Device","FileName","CastTime_UTC","CastTime_Local",
                             "SampleType","CastData","LocationSource","Latitude_Default",
                             "Altitude_Default","Latitude_Start","Longitude_Start","Altitude_Start",
                             "GPS_Horiz_error_Start","GPS_Vert_error_Start","GPS_Num_Sat_Start",
                             "Latitude_End","Longitude_End","Altitude_End",
                             "GPS_Horiz_error_End","GPS_Vert_error_End","GPS_Num_Sat_End",
                             "Cast_Duration","SamplesPerSecond","Elec_Calib_Date","Conduct_Calib_Date",
                             "Temp_Calib_Date","Press_Calib_Date"),stringsAsFactors = F)
      
      colnames(castdata) <- BetterNames$new
    
    ## deal with data and time - split into columns. 
    
    #extra date time is probably not required. Remove this and use local
      castdata <- castdata[,-grep("CastTime_UTC",names(castdata))]
      castdata$CastTime_Local <- as.POSIXct(castdata$CastTime_Local) # set POSIX mode
      
      if(datetime){
        castdata$day <- lubridate::day(castdata$CastTime_Local)
        castdata$month <- lubridate::month(castdata$CastTime_Local)
        castdata$year <- lubridate::year(castdata$CastTime_Local)
        castdata$hour <- lubridate::hour(castdata$CastTime_Local)
        castdata$minute <- lubridate::minute(castdata$CastTime_Local)
      }
    
    #Reorder the data to have the metadata first
      castdata <- castdata[,c(grep("Device",names(castdata)):length(castdata),
                              1:(grep("Device",names(castdata))-1))]
      
      if(returncols){
        writeLines("Legend for data output versus Castaway CTD data naming.")
        print(BetterNames)}
    
    #Return the data 
      return(castdata)

}
                                           