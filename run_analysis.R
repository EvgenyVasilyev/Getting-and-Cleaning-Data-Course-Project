#Turning on library dplyr
library(dplyr)

#Downloadig .zip archive
File_Name <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(File_Name,"UCI HAR Dataset.zip")

#unzipping and changing working directory
unzip("UCI HAR Dataset.zip")
setwd("./UCI HAR Dataset")

#Reading files to tables

features <- read.table("features.txt", quote="\"")
activity_labels <- read.table("activity_labels.txt", quote="\"")

subject_train <- read.table("train/subject_train.txt", quote="\"")
X_train <- read.table("train/X_train.txt", quote="\"")
y_train <- read.table("train/y_train.txt", quote="\"")

subject_test <- read.table("test/subject_test.txt", quote="\"")
X_test <- read.table("test/X_test.txt", quote="\"")
y_test <- read.table("test/y_test.txt", quote="\"")

#First task: Merges the training and the test sets to create one data set.
#test+train+names
X_complete <- rbind(X_train,X_test)
X_complete_names <- read.table("features.txt",head=FALSE)
names(X_complete) <- X_complete_names$V2
y_complete <- rbind(y_train,y_test)
names(y_complete) <- c("activity")
subject_complete <- rbind(subject_train,subject_test)
names(subject_complete) <- c("subject")
#Final Merge
tmpbind <- cbind(subject_complete,y_complete)
MergedData <- cbind(X_complete,tmpbind)

#Second task: Extracts only the measurements on the mean and standard deviation for each measurement.
NamesToLook_meanstd <- X_complete_names$V2[grep("mean\\(\\)|std\\(\\)",X_complete_names$V2)]
NamesToLook <- c(as.character(NamesToLook_meanstd),"subject","activity")
MergedData_meanstd <- subset(MergedData,select=NamesToLook)

#Third task: Uses descriptive activity names to name the activities in the data set
#get activities
activityLabels <- read.table("activity_labels.txt",header = FALSE)
names(activityLabels) <- c("activity","nameofactivity")
#join activities
MergedData_meanstd <- join(MergedData_meanstd,activityLabels)
#remove numeric activities values
#NamesToLook <- c(as.character(NamesToLook_meanstd),"subject","nameofactivity")
MergedData_meanstd <- subset(MergedData_meanstd,select=c(as.character(NamesToLook_meanstd),"subject","nameofactivity"))
names(MergedData_meanstd)<-gsub("nameofactivity", "activity", names(MergedData_meanstd))

#Appropriately labels the data set with descriptive variable names. 
names(MergedData_meanstd) <- gsub("BodyBody", "Body", names(MergedData_meanstd))
names(MergedData_meanstd) <- gsub("Gyro", "Gyroscope", names(MergedData_meanstd))
names(MergedData_meanstd) <- gsub("^f", "frequency", names(MergedData_meanstd))
names(MergedData_meanstd) <- gsub("^t", "time", names(MergedData_meanstd))
names(MergedData_meanstd) <- gsub("Mag", "Magnitude", names(MergedData_meanstd))
names(MergedData_meanstd) <- gsub("Acc", "Accelerometer", names(MergedData_meanstd))

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
TidyData <- aggregate(. ~subject + activity, MergedData_meanstd, mean)
TidyData <- TidyData[order(TidyData$subject,TidyData$activity),]
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)

