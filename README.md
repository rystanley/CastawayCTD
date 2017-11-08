# CastawayCTD
Scripts to process CastawayCTD output - SABS

#To source the scripts to your R environment use the following scripts and the package RCurl.

script1 <- RCurl::getURL("https://raw.githubusercontent.com/rystanley/CastawayCTD/master/CTDProcess.R",ssl.verifypeer = FALSE)
script2 <- RCurl::getURL("https://raw.githubusercontent.com/rystanley/CastawayCTD/master/CTDProcessBatchProcess.R",ssl.verifypeer = FALSE)
eval(parse(text = script1))
eval(parse(text = script2))
