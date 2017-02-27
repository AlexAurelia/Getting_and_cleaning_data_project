# Geeting_and_cleaning_data_project


## Getting the Data and data description

### Data Source

The data for the project can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and a full description of the data can be found at the [UCI Machine Learning Repository] 

### Data Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned 
into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record, it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

# Cleaning the data 

### Step 1: Merges the training and the test sets to create one data set.

first the data directory is defined, where the downloaded files can be found. 

Then the following files are read into R as data.tables: 
1. features.txt
2. subject_test.txt
3. X_test.txt
4. y_test.txt

and merged to create the test data set.

The following data sets are read into R as data.tables: 
5. X_train.txt
6. y_train.txt
7. subject_train.txt
8. activity_labels.txt

and table 5. to 7. are merged to create the train data set. 

The Train and Test datasets are subsequently merged to get the entire dataset. 

### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

A logical vector is created to identify the columns that only measure the mean and standard deviation of each measurement.
On the basis of this logical vector the columns in the data.table are selected. 

### Setp 3: Uses descriptive activity names to name the activities in the data set

merge the activity_labels read into R in Step 1 (table number 8) and merge to the data. Set the activity names are set to be lower case

### Step 4: Appropriately labels the data set with descriptive variable names.

the data labels are cleaned up using gsub function

### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

for each column the mean is calculated by the subjectid, activityid and activity_name to create the final tidy data set. 
The tidy data set is then saved in the datadir.



