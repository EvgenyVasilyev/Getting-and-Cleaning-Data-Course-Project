
This is CodeBook for my Course project "Getting and Cleanind Data" on Coursera

Logic of code:
1. Download zip file
2. Unpack zip file and set working directory
3. Read text files:
features         - dataframe from features.txt
activity_labels  - dataframe from activity_labels.txt
subject_train    - dataframe from train/subject_train.txt
X_train          - dataframe from train/X_train.txt
y_train          - dataframe from train/y_train.txt
subject_test     - dataframe from test/subject_test.txt
X_test           - dataframe from test/X_test.txt
y_test           - dataframe from test/y_test.txt
4. merge "train" and "test" tables into X_complete, y_complete, subject_complete (also dataframes)
5. set correct names (for X_complete - from features.txt - read it to X_complete_names)
6. merge all tables into MergedData (dataframe) via tmpbind (also dataframe)
7. perform tasks (see code comments for details):
-Merges the training and the test sets to create one data set.
-Extracts only the measurements on the mean and standard deviation for each measurement. 
-Uses descriptive activity names to name the activities in the data set
-Appropriately labels the data set with descriptive variable names. 
-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

DESTINATION DATAFRAME FOR STEP 4 IS MergedData_meanstd
DESTINATION DATAFRAME FOR STEP 5 IS TidyData
FILENAME FOR STEP 5 IS tidydata.txt