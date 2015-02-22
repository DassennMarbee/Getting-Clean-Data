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
Everything about variables stays the same as "features-info.txt". 
The Group was the result of interaction(ActivityVector, Subject). So "STANDING.1" means the data was collected in the state that subject 1 was standing. 