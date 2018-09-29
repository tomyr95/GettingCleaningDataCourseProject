library(dplyr)

    features<-read.table("UCI HAR Dataset/features.txt")                    #FULL FEATURE VECTOR headings, study qty-561
    activities<-read.table("UCI HAR Dataset/activity_labels.txt")           #ACTIVITY NAME description table, study qty-6
    
    indexed<-grep(("mean|std"),features[,2])                                #FILTERED FEATURE VECTOR by (mean|std)
    
    x_train<-read.table("UCI HAR Dataset/train/x_train.txt")[,indexed]      #OBSERVATIONS for FILTERED FEATURE VECTOR - training data
    y_train<-read.table("UCI HAR Dataset/train/y_train.txt")                #ACTIVITY identifiers for OBSERVATIONS - training data
    subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")    #SUBJECT identifiers for OBSERVATIONS - training data
    
    x_test<-read.table("UCI HAR Dataset/test/x_test.txt")[,indexed]         #OBSERVATIONS for FILTERED FEATURE VECTOR - test data
    y_test<-read.table("UCI HAR Dataset/test/y_test.txt")                   #ACTIVITY identifiers for OBSERVATIONS - test data
    subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")       #SUBJECT identifiers for OBSERVATIONS - test data

    names <- features[indexed,2]                                            #Add FILTERED FEATURE column names to OBSERVATIONS
    colnames(x_test)<-names
    colnames(x_train)<-names
    
    y_train <- y_train %>% mutate(V1=factor(V1, activities[,1],             #Replace ACTIVITY INDEX for ACTIVITY NAME LABELS - training data
                activities[,2])) %>% select(activity=V1)
    
    y_test <- y_test %>% mutate(V1=factor(V1, activities[,1],               
                activities[,2])) %>% select(activity=V1)
    
    subject_train <- subject_train %>% select(subject=V1)                   #Isolate SUBJECT column
    subject_test <- subject_test %>% select(subject=V1) 
    
    train <- cbind(y_train, subject_train, x_train)                         #Bind tables columns
    test <- cbind(y_test, subject_test, x_test)                             

    final_data <- rbind(train, test)                                                            #Bind TRAINING and TEST data
    
    mean_data <- final_data %>% group_by(activity, subject) %>% summarize_at(3:81, funs(mean))  #Summarized data for FEATURE MEANS