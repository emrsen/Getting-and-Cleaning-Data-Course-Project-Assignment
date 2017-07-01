library(dplyr)
library(data.table)

urll<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#destination zip
destfile<-paste0(getwd(),"/","DatasetW4Assgn.zip")
#download zip file
download.file(urll,destfile)
#unzip file
unzip("DatasetW4Assgn.zip")

#read features file
features<-read.table("UCI HAR Dataset/features.txt",header = FALSE)
#reading the files in the folder with read.table
activitys_names<-read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
#read train data
features_train<-read.table("UCI HAR Dataset/train/X_train.txt",header = FALSE)
activitys_train<-read.table("UCI HAR Dataset/train/Y_train.txt",header=FALSE)
subjects_train<-read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
#read test data
features_test<-read.table("UCI HAR Dataset/test/X_test.txt",header = FALSE)
activitys_test<-read.table("UCI HAR Dataset/test/Y_test.txt",header=FALSE)
subjects_test<-read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)

#rename colomuns in train set
names(features_train)<-paste0(features[,1]," ",features[,2])
#rename colomuns in test set
names(features_test)<-paste0(features[,1]," ",features[,2])
#rename colomun in activitys set in train
names(activitys_train)<-"activitys"
#rename colomun in activitys set in test
names(activitys_test)<-"activitys"
#rename colomun in subject set in train
names(subjects_train)<-"subject"
#rename colomun in subject set in test
names(subjects_test)<-"subject"

#create a dataframe test column
test_c <- data.frame(matrix(ncol = 1, nrow = nrow(activitys_test)))
test_c[,1] <- "test"
names(test_c) <- "Data Set"
#create a dataframe train column
train_c <- data.frame(matrix(ncol = 1, nrow = nrow(activitys_train)))
train_c[,1] <- "train"
names(train_c) <- "Data Set"

# Cbind train set
train_set=cbind(train_c,subjects_train,activitys_train,features_train)

# Cbind test set
test_set=cbind(test_c,subjects_test,activitys_test,features_test)

#question 1 : full_set is the merges the training and the test sets
full_set <- rbind(train_set,test_set)

#question 2 MeanStd is extraction from full_set on the mean and standard deviation for each measurement
MeanStd <- full_set %>% select(matches('mean()|std()'))
#question 3 : subActFeatures_both with descriptive activies names
full_set_desc <- full_set %>% 
        arrange(activitys) %>% 
        mutate(activitys = as.character(factor(activitys, levels=1:6, 
                                               labels= activitys_names$V2)))

#question 4 :data set with descriptive variable names.
names(full_set_desc)<-gsub("tBodyAcc-","Body acceleration signal in time domain (from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("tBodyAccMag-","Body acceleration signal in time domain applied to Fast Fourier Transform(from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("tBodyAccJerk-","Body acceleration jerk signal in time domain (from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("tBodyAccJerkMag-","Body acceleration jerk signal in time domain applied to Fast Fourrier Transform (from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("tGravityAcc-","Gravity acceleration signal in time domain (from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("tGravityAccMag-","Gravity acceleration signal in time domain applied to Fast Fourier Transform(from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("tBodyGyro-","Body acceleration signal in time domain (from the gyroscope)",names(full_set_desc))
names(full_set_desc)<-gsub("tBodyGyroMag-","Body acceleration signal in time domain applied to Fast Fourrier Transform(from the gyroscope)",names(full_set_desc))
names(full_set_desc)<-gsub("tBodyGyroJerk-","Body acceleration jerk signal in time domain (from the gyroscope)",names(full_set_desc))
names(full_set_desc)<-gsub("tBodyGyroJerkMag-","Body acceleration jerk signal in time domain applied to Fast Fourrier Transform(from the gyroscope)",names(full_set_desc))
names(full_set_desc)<-gsub("fBodyAcc-","Body acceleration signal in frequence domain (from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("fBodyAccMag-","Body acceleration signal in frequence domain applied to Fast Fourier Transform(from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("fBodyAccJerk-","Body acceleration jerk signal in frequence domain (from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("fBodyGyro-","Body acceleration signal in frequence domain (from the gyroscope)",names(full_set_desc))
names(full_set_desc)<-gsub("fBodyAccJerkMag-","Body acceleration jerk signal in frequence domain applied to Fast Fourrier Transform (from the accelerometer)",names(full_set_desc))
names(full_set_desc)<-gsub("fBodyGyroMag-","Body acceleration signal in frequence domain applied to Fast Fourier Transform (from the gyroscope)",names(full_set_desc))
names(full_set_desc)<-gsub("mean()", "MEAN", names(full_set_desc))
names(full_set_desc)<-gsub("std()", "SD", names(full_set_desc))
#question 5 :tidy data set with the average of each variable for each activity and each subject
tidydata<-full_set_desc%>%group_by(subject,activitys,`Data Set`)%>%summarise_all(mean)
write.table(tidydata, "TidyData.txt", row.names=FALSE)