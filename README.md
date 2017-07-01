# week4-getting-and-cleaning-data
## Files in this repo

* README.md -- you are reading it right now
* CodeBook.md -- codebook describing variables, the data and transformations
* run_analysis.R -- actual R code


## Description of the DATA
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

### Description of the code
Code developed and tested in R Studio V 1.0.143
Running environment Windows 10

Source data file downloaded from the given URL and unzipped with the default folder names in the working directory

Extracted files read as table from the relevant folders into data frames simular names with the file names

Columns in train and test tests updated

Data set column created indicating data from train or test set

All dataframes in test and train sets binded

train and test dataframes merged full set created

mean() or std() values are refined

descriptive aticity names filled

dataset variable names re defined by descriptive names

tidy data set created by calculating mean for each individual, activity type and data set

tidy data saved into text file

## librarys used in run_analysis.R

* library(dplyr)
* library(data.table)
