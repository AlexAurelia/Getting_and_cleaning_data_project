# Getting_and_cleaning_data_project
Submission for the peer-graded assignment for the course getting and cleaning data course from John Hopkins University on coursera

# Overview and Data
This project aims at showing the ability to collect, clean and work with a data set.
[The Data for this project can be downloaded here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and a full description of the data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#Project Summary
Download the data set and save in your working directory. 
Then the R code run_analysis.R can be executed. 
Before executing the code you will need to change the path to the working directory (datadir) in line 17

The r code executes the following steps: 

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Additional information on the variables and data can be found in the codebook
