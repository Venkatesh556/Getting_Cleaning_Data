library(data.table)
library(dplyr)

if(!file.exists("./data")){
  dir.create("./data")
   fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

  #unzip
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
}
setwd("data/UCI HAR Dataset/")

#read test data files
test<-fread("test/X_test.txt")
test_labels<-fread("test/y_test.txt")
test_subjects<-fread("test/subject_test.txt")

#read train data files
train<-fread("train/X_train.txt")
train_labels<-fread("train/y_train.txt")
train_subjects<-fread("train/subject_train.txt")

#read features file
features<-fread("features.txt")
colnames(test) = features$V2
colnames(train) = features$V2

#merge columns of test and train
test<-cbind(test,activity_id=test_labels$V1,subjects=test_subjects$V1)
train<-cbind(train,activity_id=train_labels$V1,subjects=train_subjects$V1)

#Merges the training and the test sets to create one data set
data<-rbind(test,train)

#Extracts only the measurements on the mean and standard deviation for each measurement
fn<-features$V2[grep("*.(mean|std)\\(\\)",features$V2)]
data<-subset(data,select=c(fn,"activity_id","subjects"))

#Uses descriptive activity names to name the activities in the data set
activity_labels<-fread("activity_labels.txt")
colnames(activity_labels) = c("activity_id","activity_name")
data<-merge(data,activity_labels)

#Appropriately labels the data set with descriptive variable names
colnames(data)<-gsub("^t", "time", names(data))
colnames(data)<-gsub("^f", "frequency", names(data))
colnames(data)<-gsub("Acc", "Accelerometer", names(data))
colnames(data)<-gsub("Gyro", "Gyroscope", names(data))
colnames(data)<-gsub("Mag", "Magnitude", names(data))
colnames(data)<-gsub("BodyBody", "Body", names(data))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data1<-aggregate(.~subjects+activity_name,data,mean)
data1<-data1[order(data1$subject,data1$activity_id),]
write.table(data1, file = "tidydata.txt",row.name=FALSE)