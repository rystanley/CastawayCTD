# CastawayCTD
Scripts to process CastawayCTD output - SABS

To source the scripts to your R environment use the following scripts and the package **RCurl**. Note these scripts require the R packages **lubridate** and **data.table**.

## Installation

```r
script1 <- RCurl::getURL("https://raw.githubusercontent.com/rystanley/CastawayCTD/master/CTDProcess.R",ssl.verifypeer = FALSE)

script2 <- RCurl::getURL("https://raw.githubusercontent.com/rystanley/CastawayCTD/master/CTDProcessBatchProcess.R",ssl.verifypeer = FALSE)

eval(parse(text = script1))

eval(parse(text = script2))
```

## Example use

```r

#Process a single file.
output <- CTDProcess(path = "CTD Casts/CC1349003_20170828_182816.csv")

#Process multiple files. Note in this example I have replicated the file path to the example CTD cast to mirror how the function would handle a vector of paths.
batchoutput <- CTDProcess_Batch(paths = rep("CTD Casts/CC1349003_20170828_182816.csv",3))

```