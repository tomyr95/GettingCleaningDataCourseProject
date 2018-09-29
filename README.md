# GettingCleaningDataCourseProject

Peer-graded Assignment: Getting and Cleaning Data Course Project
Version 1.0

Student: Tomas R. Rodriguez


The purpose of this project is to demonstrate your ability to collect, work with, and clean a data
set. The goal is to prepare tidy data that can be used for later analysis. 


One of the most exciting areas in all of data science right now is wearable computing. Companies
like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract
new users. The data linked to from the course website represent data collected from the
accelerometers from the Samsung Galaxy S smartphone. A full description is available
at the site where the data was obtained:

	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This is a summary of the description of the work completed by the researchers:

	"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
	Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING,
	LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and
	gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of
	50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has
	been randomly partitioned into two sets, where 70% of the volunteers was selected for generating
	the training data and 30% the test data."

We used the following files (in order) as inout to our project related to getting and cleaning data:

	- 'UCI HAR Dataset/features.txt'		: List of all features.
	- 'UCI HAR Dataset/activity_labels.txt'		: Links the class labels with their activity name.
	- 'UCI HAR Dataset/train/x_train.txt'		: Training set.
	- 'UCI HAR Dataset/train/y_train.txt'		: Training labels.
	- 'UCI HAR Dataset/train/subject_train.txt'	: Each row identifies the subject who performed the activity
							   for each window sample. Its range is from 1 to 30. 
	- 'UCI HAR Dataset/test/x_test.txt'		: Test set.
	- 'UCI HAR Dataset/test/y_test.txt'		: Test labels.
	- 'UCI HAR Dataset/test/subject_test.txt'	: Each row identifies the subject who performed the activity
							   for each window sample. Its range is from 1 to 30. 
							   
	NOTE: Script runs based on placing fhe folder 'UCI HAR Dataset" in the working directory.

Our goals in this project were to produce a tydy data table, script, and README file, that met the following:

	- Create one R script called run_analysis.R that does the following.
	- Merges the training and the test sets to create one data set.
	- Extracts only the measurements on the mean and standard deviation for each measurement.
	- Uses descriptive activity names to name the activities in the data set
	- Appropriately labels the data set with descriptive variable names.
	- From the data set in step 4, creates a second, independent tidy data set with the
	   average of each variable for each activity and each subject.

We completed this as scripted and annotated in the file 'run_analysis.R' with the following steps:

	1) Load all data sets (read.table) into the following data_frames, similar to names in input tables:
	    'features', 'activities', 'x_train', 'y_train', 'subject_train', 'x_test', 'y_test', 'subject_test'

	2) For 'x_train', 'x_test' we reduced the table sizes by applying a filter via 'indexed' vector. 

	3) "Mapped" the headings in 'features' via the 'indexed' vector into 'x_train', 'x_test'.

	4) "Mapped" the lables in 'activities' into 'y_train', "y_test'.

	5) Isolated 'subject' column in 'subject_train', subject_test.

	6) We built up both datasets into 'train', 'test'.

        7) Bound 'train', 'test' into 'final_data' (10299x81) for the final tydy table.

	8) Created grouped, summarized 'mean_data' (180x81) for the tydy means.

	9) 'mean_data' was uploaded to repository as 'means.txt'.

	10) this README file uploaded to same repository.

Repository URL:

	https://github.com/tomyr95/GettingCleaningDataCourseProject		



Thank you,

Tomas R. Rodriguez
