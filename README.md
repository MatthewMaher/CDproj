# Overview Purpose
This Repository contains a tool for producing a summarization of data from:

**Version 1.0 of Human Activity Recognition Using Smartphones Dataset**


# Input Data Source and Format
For that original data set:

   the raw data can viewed at:  
      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

   Descriptions of the original source data are at:
      http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


# Output Data Source and Format Descriptions
The summarized data set provides the mean value, for unique combinations of SUBJECT and ACTIVITY,
of a subset of measurement values (those representing a Mean or an Std Dev).  

The measurements that were summarized were those original dataset 'features' with names ended in 'mean' or 'std'

The Output Dataset contains: 

 * A merged view of the Testing and Training Data (which are separate in the input dataset)
 
 * explicit acitivty descriptions rather than numeric code (as in original input)

 * One row per each unique combination of SUBJECT and ACITIVITY (180 rows)
 
 * One data column for each measurement that is summarized  (66 measurements)
 
 * One row of column headings at the top

# Execution 

The entire procedure for constructing the data summarization is within the script file:  **run_analysis.R**, which is internally documented on a step by step basis. 

You should first download and locally expand ZIP file source data (URL above).

The single contained function, "**run_analysis()**" has two optional parameters:

* the directory in which the original data set tree (from URL above is located).  default = '.'

* the output filename into which the data should be written.  default = './tidy.dat'

Besides the creation of a tidy.dat file, the summarized data are also returned as a data.frame from the function.  

# Sample Demo

```
> setwd("~/CDproj")
> source("run_analysis.R")
> tidy <- run_analysis()
writing results to file: ./tidy.dat...
> dim(tidy)
[1] 180  68
```
