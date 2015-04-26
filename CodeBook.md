# Code Book

## Original data

The data for the project is downloaded from this link: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This file unzips into a directory called 'UCI HAR Dataset'. Training and testing
data sets are in the 'train' and 'test' subdirectories, respectively.

## Files used

`subject_train.txt`: provides subject IDs
`X_train.txt`: training data set
`y_train.txt`: training activity labels

We won't load the data in the 'Inertial Signals' subdirectories since we want
to extract only measurements on the mean and standard deviation for each
measurement, and the files in 'Inertial Signals' do not contain such data.

## Data selection

We select from the combined set only those columns that correspond to
measurements on the mean and standard deviation for each measurement, plus the
activity labels and subject IDs.

## Variables in final data set

`subjectID`
`activity_label`
`variable`
`mean_value`