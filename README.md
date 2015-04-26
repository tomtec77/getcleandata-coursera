# getcleandata-coursera
## Coursera Getting and Cleaning Data course assignment

The purpose of this project is to demonstrate how to collect, work with, and
clean a data set, in order to prepare tidy data that can be used for later
analysis.

The data used in this project represent data collected from the accelerometers
from the Samsung Galaxy S smartphone. The variables, the data, and any
transformations or work performed to clean up the data are detailed in file
`CodeBook.md`. 

### Original data

The data for the project is downloaded from this link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the original data is available at the site where the data
was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The downloaded file unzips into a directory called 'UCI HAR Dataset'. The 
dataset obtained from the original experiments has been randomly partitioned
into two sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data. These sets are in the 'test' and 'train'
subdirectories, respectively.


### Project goals

For this project we are asked to:

1. merge the test and train datasets,
2. extract only the measurements on the mean and standard deviation for each
measurement,
3. use descriptive activity names to name the activities in the data set,
4. appropriately label the data set with descriptive variable names, and
5. from the data set in step 4, create a second, independent tidy data set with
the average of each variable for each activity and each subject.

All these steps are carried out in `run_analysis.R`.

### Requirements

The script requires the `plyr` and `reshape2` packages, and expects the data to
be in a subdirectory called 'data'. If this subdirectory doesn't exist, the
script will create it. The script also downloads and unzips the data files.

### Final data set

The `run_analysis.R` script creates a text file named `HAR_tidy_dataset.txt` in
the 'data' subdirectory.