run_analysis <- function(directory='.', outfile='./tidy.txt') {
  
  # Load up the list of Activities and their numerical codes
  act_file <- sprintf("%s/activity_labels.txt", directory)
  activity_list <- read.table(act_file, col.names = c('Actnum','Activity'))
  
  # Load up the list of Features that are recorded in the columns of the input data
  feat_file <- sprintf("%s/features.txt", directory)
  features <- read.table(feat_file, col.names = c('Featnum','Feature'))
  
  # we are only interested in those features that are a Mean or STD value
  features_to_keep <- grepl('-(std|mean)\\(',features$Feature)
  
  # there are two directories of data to combine.
  sets <- c('test','train')
  combined <- NULL
  for (d in sets) {
    
       # in each directory there are three parallel files: subjects, activities, and data
       # we need to read them in separately and then glue the columns together with a cbind()
    
       sub_file <- sprintf("%s/%s/subject_%s.txt", directory, d, d)
       subjects <- read.table(sub_file, col.names = c('subject'))
       
       act_file <- sprintf("%s/%s/y_%s.txt", directory, d, d)
       activities <- read.table(act_file, col.names = c('Activity'))
       
       dat_file <- sprintf("%s/%s/X_%s.txt", directory, d, d)
       data <- read.table(dat_file)    
       
       dframe <- cbind(subjects, activities, data)
       
       # the 'combined' variable will hold the appended versions of both directories
       if (is.null(combined)) {
           combined <- dframe
       } else {
         combined = rbind(combined, dframe)
       }
  } 
  
  # make a new version of the results that removes all the unwanted columns
  filtered_result <- combined[c(TRUE, TRUE, features_to_keep)]
  
  # apply real column names based on the names from the features.txt file
  data_columns <- sub("\\(\\)", "", features$Feature[features_to_keep]) 
  colnames(filtered_result) = c('subject', 'Activity', data_columns )
  
  # replace the Activity numeric codes with the real names (from activity_lables.txt)
  filtered_result$Activity <- activity_list$Activity[filtered_result$Activity]
  
  # Now summarize by the Subject and Acitivity to get to a tidy version
  tidy_result <-aggregate(.~subject+Activity, filtered_result, FUN=mean)
 
  # write out the results to a file and return as a function response
  message("writing results to file: ", outfile, "...")
  write.table(tidy_result, file=outfile, row.names=FALSE)
  tidy_result
}

