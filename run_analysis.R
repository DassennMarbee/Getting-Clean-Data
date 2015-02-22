###install.packages("data.table")
library("data.table")

##Merge training set and test set over different objects
###Merge subject
subject_training<-read.table("./UCI HAR Dataset/train/subject_train.txt",header = F,as.is = T)
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",header = F,as.is = T)
flbel<-function(x)paste(x,"*",sep = "") #### Label the subjects used for test set
tmp_sub_test<-data.frame(matrix(as.character(sapply(as.character(subject_test$V1),flbel)),byrow = T))
tmp_sub_training<-data.frame(matrix(as.character(subject_training$V1),byrow = T))
names(tmp_sub_test)<-"Subject"
names(tmp_sub_training)<-"Subject"
Subject<-as.factor(rbind(tmp_sub_training,tmp_sub_test)$Subject)
###Merge feature vectors
Vectors_training<-read.table(file = "./UCI HAR Dataset/train/X_train.txt",header = F,as.is = T)
Vectors_test<-read.table(file = "./UCI HAR Dataset/test/X_test.txt",header = F,as.is = T)
FeatureVector<-as.data.frame(rbind(Vectors_training,Vectors_test))
###Merge activity labels
Label_training<-read.table(file = "UCI HAR Dataset/train/y_train.txt",header = F,as.is = T)
Label_test<-read.table(file = "UCI HAR Dataset/test/y_test.txt",header = F,as.is = T)
ActivityVector<-as.factor(rbind(Label_training,Label_test)$V1)
Levels<-read.table(file = "./UCI HAR Dataset/activity_labels.txt",header = F)
levels(ActivityVector)<-Levels$V2 #### Using descriptive activity labels

##Extracts only the measurements on the mean and standard deviation
FeatureNames<-read.table(file = "UCI HAR Dataset/features.txt",header = F,as.is = T)
names(FeatureVector)<-FeatureNames$V2
index_mean<-grep(pattern = "mean()",x = names(FeatureVector),fixed = T)
index_std<-grep(pattern = "std()",x = names(FeatureVector),fixed = T)
index<-append(index_mean,index_std)
FeatureExtracted<-as.data.frame(as.matrix(FeatureVector)[,index])

##Merge Everthing
mydata<-as.data.frame(cbind(Subject,FeatureExtracted,ActivityVector))
####write.table(x = mydata,file = "MergedDataSet.txt",row.names = F)

##Independent tidy data set with the average of each variable for BOTH each activity and each subject.
mydata$Group<-interaction(mydata$ActivityVector,mydata$Subject)
groups<-split(mydata,mydata$Group)
mycolMeans<-function(x) colMeans(x[,names(FeatureExtracted)])
newdata<-as.data.frame(sapply(groups,mycolMeans))
Variable<-rownames(newdata)
newdata<-as.data.frame(cbind(Variable,newdata))
write.table(newdata,file = "Average_wide.txt",row.names = F)

##Independent tidy data set with the average of each variable for BOTH each activity and each subject.
library(reshape2)
meltdata<-melt(mydata,id="Group",measure.vars = names(FeatureExtracted))
newdata2<-dcast(meltdata,Group~variable,mean)
write.table(newdata2,file = "Average_long.txt",row.names = F)