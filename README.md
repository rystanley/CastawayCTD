# CastawayCTD
Scripts to process CastawayCTD output - SABS

To source the scripts to your R environment use the following scripts and the package **RCurl**. Note these scripts require the R packages **lubridate** and **data.table**.

## Installation

```r

library(devtools)

source_url("https://raw.githubusercontent.com/rystanley/CastawayCTD/master/code/CTDProcess.R") #parsing script

source_url("https://raw.githubusercontent.com/rystanley/CastawayCTD/master/code/CTDProcessBatchProcess.R") #batch processing script

source_url("https://raw.githubusercontent.com/rystanley/CastawayCTD/master/code/ctd_check.R") #script for checking whether casts are valid
```

## Example use. 

*Note that example usage requires a path to the local folder* **CTD Casts**. *The* **CTD Casts** *folder used in these examples is included in this repository.* 

```r

#Process a single file.
output <- CTDProcess(path = "CTD Casts/CC1349003_20170828_182816.csv")

#Process multiple files. Note in this example I have replicated the file path to the example CTD cast to mirror how the function would handle a vector of paths.
batchoutput <- CTDProcess_Batch(paths = rep("CTD Casts/CC1349003_20170828_182816.csv",3))

```