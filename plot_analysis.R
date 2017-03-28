if(!file.exists("./data")){
  dir.create("./data")
   fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

  #unzip
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
}
setwd("data/UCI HAR Dataset/")
library(data.table)
#read test data files
te<-fread("test/X_test.txt")
tel<-fread("test/y_test.txt")
tes<-fread("test/subject_test.txt")

#read train data files
tr<-fread("train/X_train.txt")
trl<-fread("train/y_train.txt")
trs<-fread("train/subject_train.txt")

#read features file
fe<-fread("features.txt")
colnames(te) = fe$V2
colnames(tr) = fe$V2

#merge columns of test and train
test<-cbind(te,aid=tel$V1,sub=tes$V1)
train<-cbind(tr,aid=trl$V1,sub=trs$V1)

#Merges the training and the test sets to create one data set
data<-rbind(test,train)

#Extracts only the measurements on the mean and standard deviation for each measurement
fn<-fe$V2[grep("*.(mean|std)\\(\\)",fe$V2)]
data<-subset(data,select=c(fn,"aid","sub"))

#Uses descriptive activity names to name the activities in the data set
al<-fread("activity_labels.txt")
colnames(al) = c("aid","aname")
data<-merge(data,al)

#Appropriately labels the data set with descriptive variable names
colnames(data)<-gsub("^t", "time", names(data))
colnames(data)<-gsub("^f", "frequency", names(data))
colnames(data)<-gsub("Acc", "Accelerometer", names(data))
colnames(data)<-gsub("Gyro", "Gyroscope", names(data))
colnames(data)<-gsub("Mag", "Magnitude", names(data))
colnames(data)<-gsub("BodyBody", "Body", names(data))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data1<-aggregate(.~sub+aname,data,mean)
write.table(data1, file = "tidydata.txt",row.name=FALSE)