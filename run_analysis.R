

### This code runs if the data is loaded in the working directory. It can be downloaded from here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# full description of the data can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# This code runs the follwing steps
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



##1. Merges the training and the test sets to create one data set.
datadir <- "C:/Users/Alexandra/Documents/Uni/Data Sience/Getting_Data/final test/UCI HAR Dataset"
setwd(datadir)

# load the test data into the global environment and convert to data.table
features <- as.data.table(read.table(paste0(datadir,"/features.txt"), header = FALSE))
subject_test <- as.data.table(read.table(paste0(datadir,"/test/subject_test.txt"), header = FALSE))
data_test <- as.data.table(read.table(paste0(datadir,"/test/X_test.txt"), header = FALSE))
labels_test <- as.data.table(read.table(paste0(datadir,"/test/y_test.txt"), header = FALSE))

# set names of the variables
colnames(data_test) <- as.character(features$V2)
setnames(labels_test, "V1", "activityid" )
setnames(subject_test, "V1", "subjectid" )

# combine the lable data with the test data
data_test <- cbind(subject_test,labels_test, data_test)


#load all the data for the training data, set the column names, and merge to make one training dataset
# Read training data from file and convert to data.table
data_train <- as.data.table(read.table(paste0(datadir,"/train/X_train.txt"), header = FALSE))
labels_train <- as.data.table(read.table(paste0(datadir,"/train/y_train.txt"), header = FALSE))
subject_train <- as.data.table(read.table(paste0(datadir,"/train/subject_train.txt"), header = FALSE))
activity_labels <- as.data.table(read.table(paste0(datadir,"/activity_labels.txt"), header = FALSE))

# set names of the variables
colnames(data_train) <- as.character(features$V2)
setnames(labels_train, "V1", "activityid" )
setnames(subject_train, "V1", "subjectid" )

# combine the activity ID the subject ID and the data together
data_train <- cbind(subject_train,labels_train, data_train)


# merge the training and test data together using the variable label
data <- rbind(data_test, data_train)


#clean the workspace up a bit 
rm(data_test, data_train, features, labels_test, labels_train, subject_test, subject_train)




# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#define the columns to keep with a logical vector
colums_keep<-(grepl("activityid",colnames(data))|grepl("subjectid",colnames(data))|grepl("-mean..",colnames(data)) & !grepl("-meanFreq..",colnames(data)) | grepl("-std..",colnames(data)))
# select the columns to keep in the data.table
data<-data[,colums_keep, with=FALSE]


# 3. Uses descriptive activity names to name the activities in the data set
setnames(activity_labels, "V1", "activityid")
setnames(activity_labels, "V2", "activity_name")
activity_labels[,activity_name:=tolower(activity_name)]
data <- merge(data, activity_labels, by="activityid", all.x = TRUE)


#4. Uses descriptive activity names to name the activities in the data set
#delete ()
colnames(data) <- gsub("\\()", "", colnames(data))
# replace t by time at the beginning of the activity name
colnames(data) <- gsub("^t", "time", colnames(data))
# replace f by freq at the beginning of the activity name
colnames(data) <- gsub("^f", "freq", colnames(data))
# replace Mag by Magnitude at the beginning of the activity name
colnames(data) <- gsub("Mag", "Magnitude", colnames(data))
# delete - in the activity name
colnames(data) <- gsub("-", " ", colnames(data))


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data<-data[,lapply(.SD,function(x) mean(x, na.rm=TRUE)), by=.(subjectid,activityid, activity_name)]

#save tidy_data to datadir
write.table(tidy_data,"tidy_data.txt", row.names = FALSE)
