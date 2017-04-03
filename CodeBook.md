Getting and Cleaning Data Project
=================================
Description
-----------
Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

Source Data
-----------
The dataset being used is: [Human Activity Recognition Using Smartphones] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  


Data Set Information
--------------------
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Functions used in plot_analysis.R
---------------------------------
file.exists() - to check for directory "data",if it is not present it will create directory data using dir.create()  
download.file() - It downloads Human Activity Recognition Using Smartphones data and keep it in data/Dataset.zip  
unzip - to unzip the Dataset.zip and creates the "UCI HAR Dataset"" directory
setwd - to set current working directory. In this we hardcoded to data/UCI HAR Dataset/  
fread - to read text files X_test.txt,....  
cbind - to bind columns  
rbind - to bind rows  
subset - subset the data "data" and select only particler column names  
gsub - substitute the particler pattern with the given pattern in all places  

Variables used in plot_analysis.R
---------------------------------
test, test_labels, test_subjects, train, train_labels, train_subjects, features and activity_labels are the assignment variables of files X_test.txt, y_test.txt, subject_test.txt, X_train.txt, y_train.txt, subject_train.txt, features.txt and activity_labels.txt.  
data - actual data which comes after merge test and train data sets.  
fn - Extracts only the measurements on the mean and standard deviation for each measurement and assigned to fn  
activity_id - renamed the column name "V1" of test_labels and train_labels  
subjects - renamed the column name "V1" of test_subjects and train_subjects  
activity_name - renamed the column name "V2" of activity_labels  
data1 - average of each variable in "data" for each activity and each subject  


