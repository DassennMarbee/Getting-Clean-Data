# Getting-Clean-Data Course Project

##Prerequisites for using "run_analysis.R"
* This script should be put in the same directory with "UCI HAR Dataset"
* Packages of "reshape2" and "data.table" must be installed first if not already installed


##Working flow of the script
###Merging data
* Different components were merged respectively, namely subject, feature vectors and activity labels. Each component was merged on training and test sets.
* Subject id and activity labels were dealt as factors. Class of other data remained as numeric or character.
* Subject id from test sets were labeled with "*"
* Levels of activity labels were changed to descriptive labels from "activity_labels.txt"
* Column names of feature factors stayed the same as "features.txt". Only those with "mean()" or "std()" were extracted. 66 variables were extracted.
* Finally, data of subjects, feature vector extracted and activity labels were combined into one, 10299 observations * 68 variables.

###Calculating average
* A new variable Group was created to describe the combination of subject id and activity, constructing 180 groups.(30 subjects * 6 activities)
* The whole dataset was splitted by Group, and then used to calculate mean of columns(column names were the same as feature extracted). The result constructed 66*180 "wide" dataset.
* The whole dataset was melted, with Group as the id and other features as variables. Using dcast to construct a table of 180*67(including Group as one of the columns), which is the "long" dataset.

###Code book
Everything about variables stays the same as "features-info.txt". The method of estimation was also included in the name of variable, such as "-mean()-" and "-std()-"
The Group was the result of *interaction(ActivityVector, Subject)*. So "STANDING.1" means the data was collected in the state that subject 1 was standing. 



>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

>tBodyAcc-XYZ
>tGravityAcc-XYZ
>tBodyAccJerk-XYZ
>tBodyGyro-XYZ
>tBodyGyroJerk-XYZ
>tBodyAccMag
>tGravityAccMag
>tBodyAccJerkMag
>tBodyGyroMag
>tBodyGyroJerkMag
>fBodyAcc-XYZ
>fBodyAccJerk-XYZ
>fBodyGyro-XYZ
>fBodyAccMag
>fBodyAccJerkMag
>fBodyGyroMag
>fBodyGyroJerkMag

>The set of variables that were estimated from these signals are: 

>mean(): Mean value
>std(): Standard deviation