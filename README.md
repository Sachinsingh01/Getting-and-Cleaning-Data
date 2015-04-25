# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Steps to run the project

1. Download the data source from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
2. Extract the zip file in "UCI HAR Dataset" (exclude quotes) folder.
3. Copy run_analysis.R script in UCI HAR Dataset folder.
4. In RStudio set your working directory to UCI HAR Dataset folder. (use setwd() function).
5. Run source("run_analysis.R") command from R.
6. This will generate tidy_average_data.txt in your working directory i.e UCI HAR Dataset.
