# Human Activity Recognition Using Smartphones Dataset

This is a reduced and tidied dataset of the [Human Activity
Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

This distribution contains the following files:
* `README.md`: this file
* `run_analysis.R`: R script which fetches the data from the above dataset and cputes averaged values as described in `CodeBook.md`.
* `run_analysis.Rmd`: [R markdown](http://rmarkdown.rstudio.com/) version of the script
* `CodeBook.md`: detailed description of the generated data set

Running the script will generate the following output files:
* `data/Dataset.zip`: original data will be fetched
* `UCI HAR Dataset/`: unzipped original data
* `data/run_analysis_tidy.txt`: tidied data frame as described in `CodeBook.md`

## Required libraries for this analysis:
    library(plyr)
    library(dplyr)
    library(tidyr)
    library(readr)
Please install missing packages with `install.packages()`.
