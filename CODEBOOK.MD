---
title: "Codebook for run_analysis.R"
author: "Tomas R. Rodriguez"
date: "9/29/2018"
output: "tidy_data.txt""
  html_document:
    keep_md: yes
---

## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

##Study design and data processing
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###Collection of the raw data
The original raw data collection that was completed by the researchers included the following:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###Notes on the original (raw) data (Inputs to 'run_analysis.R)
The completed dataset for review provided by the researchers included:
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample.

##Creating the 'tidy_data.txt' datafile
- We used the script called run_analysis.R built in RStudio Version 1.1.419 with 'dplyr' library loaded.
- The script loads the data files mentioned above, cleans them up, and binds them into a tidy file.
- The script the finalizes by performing a summarized table based on 'activities' and 'subjects'.
- The summarized table is  written into the file 'tidy_data.txt' via write.table() function.

###Guide to create the tidy data file
The specific steps performed to create the file were as follows:

    1) Load all data sets (read.table) into the following data_frames, similar to names in input tables:
	    
	    'features'      : features<-read.table("UCI HAR Dataset/features.txt")
	    'activities'    : activities<-read.table("UCI HAR Dataset/activity_labels.txt")
	    'x_train'       : x_train<-read.table("UCI HAR Dataset/train/x_train.txt")[,indexed] 
        'y_train'       : y_train<-read.table("UCI HAR Dataset/train/y_train.txt")               
        'subject_train' : subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")  
        'x_test'        : x_test<-read.table("UCI HAR Dataset/test/x_test.txt")[,indexed]  
        'y_test'        : y_test<-read.table("UCI HAR Dataset/test/y_test.txt")                
        'subject_test'  : subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")  
    
	2)  Please note that for 'x_train', 'x_test' we created and 'indexed' vector to only load
	    features containing the 'mean()' or 'std()' attributes we were interested in:
	    
	    'indexed'       : indexed<-grep(("mean|std"),features[,2])
	    
	3) "Mapped" the 'feature' labels via the 'names' vector into 'x_train', 'x_test'.
	
	    'names'         : names <- features[indexed,2]; colnames(x_test)<-names; colnames(x_train)<-names

	4) "Mapped" the lables in 'activities' into 'y_train', "y_test' using the 'dplyr' functions:
	
	    y_train <- y_train %>% mutate(V1=factor(V1, activities[,1], activities[,2])) %>% select(activity=V1)
        y_test <- y_test %>% mutate(V1=factor(V1, activities[,1], activities[,2])) %>% select(activity=V1)

	5) Isolated 'subject' column in 'subject_train', subject_test:
	
	    subject_train <- subject_train %>% select(subject=V1)
        subject_test <- subject_test %>% select(subject=V1) 
	
	6) We built up both datasets into 'train', 'test':
	
	   'train'          : train <- cbind(y_train, subject_train, x_train)
       'test'           : test <- cbind(y_test, subject_test, x_test) 

    7) Bound 'train', 'test' into 'final_data' (10299x81) for the final tydy table.
    
        'final_data'    : final_data <- rbind(train, test)

	8) Created grouped, summarized 'mean_data' (180x81) for the tydy means.
	
	    'mean_data'     : mean_data <- final_data %>% group_by(activity, subject)
	                         %>% summarize_at(3:81, funs(mean))

	9) Finally, 'mean_data' was uploaded to repository as 'tidy_data.txt'.
	
	    'tidy_data.txt' : write.table(mean_data, "tidy_data.txt", row.name=FALSE)

##Description of the variables in the tiny_data.txt file

Dataframe with 180 obs. of  81 variables:

 activity                       : Factor  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
                                            SITTING, STANDING, LAYING
                                    
 subject                        : int     1-30
 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

For each of these features the avverage is calculated by activity and subject.
 
 tBodyAcc-mean()-X              : num     
 tBodyAcc-mean()-Y              : num     
 tBodyAcc-mean()-Z              : num
 tBodyAcc-std()-X               : num 
 tBodyAcc-std()-Y               : num  
 tBodyAcc-std()-Z               : num
 
 tGravityAcc-mean()-X           : num
 tGravityAcc-mean()-Y           : num
 tGravityAcc-mean()-Z           : num
 tGravityAcc-std()-X            : num
 tGravityAcc-std()-Y            : num
 tGravityAcc-std()-Z            : num
 
 tBodyAccJerk-mean()-X          : num
 tBodyAccJerk-mean()-Y          : num  
 tBodyAccJerk-mean()-Z          : num  
 tBodyAccJerk-std()-X           : num  
 tBodyAccJerk-std()-Y           : num  
 tBodyAccJerk-std()-Z           : num  
 
 tBodyGyro-mean()-X             : num  
 tBodyGyro-mean()-Y             : num  
 tBodyGyro-mean()-Z             : num  
 tBodyGyro-std()-X              : num  
 tBodyGyro-std()-Y              : num  
 tBodyGyro-std()-Z              : num 
 
 tBodyGyroJerk-mean()-X         : num  
 tBodyGyroJerk-mean()-Y         : num  
 tBodyGyroJerk-mean()-Z         : num  
 tBodyGyroJerk-std()-X          : num  
 tBodyGyroJerk-std()-Y          : num  
 tBodyGyroJerk-std()-Z          : num  
 
 tBodyAccMag-mean()             : num  
 tBodyAccMag-std()              : num 
 
 tGravityAccMag-mean()          : num  
 tGravityAccMag-std()           : num 
 
 tBodyAccJerkMag-mean()         : num  
 tBodyAccJerkMag-std()          : num 
 
 tBodyGyroMag-mean()            : num  
 tBodyGyroMag-std()             : num 
 
 tBodyGyroJerkMag-mean()        : num  
 tBodyGyroJerkMag-std()         : num 
 
 fBodyAcc-mean()-X              : num  
 fBodyAcc-mean()-Y              : num  
 fBodyAcc-mean()-Z              : num  
 fBodyAcc-std()-X               : num  
 fBodyAcc-std()-Y               : num  
 fBodyAcc-std()-Z               : num 
 
 fBodyAcc-meanFreq()-X          : num  
 fBodyAcc-meanFreq()-Y          : num  
 fBodyAcc-meanFreq()-Z          : num 
 
 fBodyAccJerk-mean()-X          : num  
 fBodyAccJerk-mean()-Y          : num  
 fBodyAccJerk-mean()-Z          : num  
 fBodyAccJerk-std()-X           : num  
 fBodyAccJerk-std()-Y           : num  
 fBodyAccJerk-std()-Z           : num 
  fBodyAccJerk-meanFreq()-X     : num  
 fBodyAccJerk-meanFreq()-Y      : num  
 fBodyAccJerk-meanFreq()-Z      : num  
 
 fBodyGyro-mean()-X             : num  
 fBodyGyro-mean()-Y             : num  
 fBodyGyro-mean()-Z             : num  
 fBodyGyro-std()-X              : num  
 fBodyGyro-std()-Y              : num  
 fBodyGyro-std()-Z              : num  
 fBodyGyro-meanFreq()-X         : num  
 fBodyGyro-meanFreq()-Y         : num  
 fBodyGyro-meanFreq()-Z         : num
 
 fBodyAccMag-mean()             : num
 fBodyAccMag-std()              : num  
 fBodyAccMag-meanFreq()         : num
 
 fBodyBodyAccJerkMag-mean()     : num
 fBodyBodyAccJerkMag-std()      : num 
 fBodyBodyAccJerkMag-meanFreq() : num 
 
 fBodyBodyGyroMag-mean()        : num  
 fBodyBodyGyroMag-std()         : num 
 fBodyBodyGyroMag-meanFreq()    : num  
 fBodyBodyGyroJerkMag-mean()    : num  
 fBodyBodyGyroJerkMag-std()     : num  
 fBodyBodyGyroJerkMag-meanFreq(): num  
