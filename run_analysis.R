library(plyr)
library(reshape2)

# Start by downloading the data and storing it in a directory called data
# which will be created if it doesn't exist
if (!file.exists("data")) {
    dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="data/UCI_HAR_Dataset.zip", method="curl")

# Record the date in which we downloaded the file
dateDownloaded <- date()

# Extract the zipped file we just downloaded - it will unzip into a directory
# named 'UCI HAR Dataset'
basewd <- getwd()
setwd(paste(basewd, "data", sep="/"))
unzip("UCI_HAR_Dataset.zip")
setwd(basewd)

datadir <- "data/UCI HAR Dataset"

# The data is split in two samples, train and test. We have to merge them to
# create a single data set.
# We won't load the data in the 'Inertial Signals' subdirectories since we want
# to extract only measurements on the mean and standard deviation for each
# measurement, and the files in 'Inertial Signals' do not contain such data

# Training set: load the subject IDs, then features, then the labels and join
# everything in a single dataframe. Column names for the features are read from
# the file UCI HAR Dataset/features.txt
dfnames <- read.table(paste(datadir, "features.txt", sep="/"),
                      stringsAsFactors=FALSE)

dftrain <- read.table(paste(datadir, "train/subject_train.txt", sep="/"),
                      col.names="subjectID")
dftrain <- cbind(dftrain, 
                 read.table(paste(datadir, "train/X_train.txt", sep="/"),
                            col.names=dfnames[,2]))
dftrain <- cbind(dftrain,
                 read.table(paste(datadir, "train/y_train.txt", sep="/"),
                            col.names="activity_label"))

# Testing set: load the subject IDs, then features, then add the labels and
# finally join with the training set in a single dataframe.
dftest <- read.table(paste(datadir, "test/subject_test.txt", sep="/"),
                     col.names="subjectID")
dftest <- cbind(dftest,
                read.table(paste(datadir, "test/X_test.txt", sep="/"),
                           col.names=dfnames[,2]))
dftest <- cbind(dftest,
                 read.table(paste(datadir, "test/y_test.txt", sep="/"),
                            col.names="activity_label"))

df <- rbind(dftrain, dftest)

# Now we'll select from the combined set only those columns that correspond to
# measurements on the mean and standard deviation for each measurement, plus the
# activity labels.
column.select <- sort(c(1,
                        grep("mean", names(df)),
                        grep("std", names(df)),
                        dim(df)[2]))
df <- df[,column.select]

# Use descriptive activity names
# Load the numerical activity codes and the text descriptions from file
# UCI HAR Dataset/activity_labels.txt
# We use the plyr mapvalues() function to convert from numerical values to text
dfact <- read.table(paste(datadir, "activity_labels.txt", sep="/"),
                    stringsAsFactors=FALSE)
df$activity_label <- mapvalues(df$activity_label,
                               from=dfact[,1],
                               to=dfact[,2])

# Use descriptive variable names
axes <- c("X", "Y", "Z")
vartypes <- c("mean", "stdev")
prefix <- sort(do.call(paste0, expand.grid(vartypes, axes)))
names(df) <- c("subjectID",
               paste0(prefix, "_tBodyAccel"),
               paste0(prefix, "_tGravityAccel"),
               paste0(prefix, "_tBodyAccelJerk"),
               paste0(prefix, "_tBodyGyro"),
               paste0(prefix, "_tBodyGyroJerk"),
               "mean_tBodyAccelMag", "stdev_tBodyAccelMag",
               "mean_tGravityAccelMag", "stdev_tGravityAccelMag",
               "mean_tBodyAccelJerkMag", "stdev_tBodyAccelJerkMag",
               "mean_tBodyGyroMag", "stdev_tBodyGyroMag",
               "mean_tBodyGyroJerkMag", "stdev_tBodyGyroJerkMag",
               paste0(prefix, "_fBodyAccel"),
               paste0("mean", axes, "Freq_fBodyAccel"),
               paste0(prefix, "_fBodyAccelJerk"),
               paste0("mean", axes, "Freq_fBodyAccelJerk"),
               paste0(prefix, "_fBodyGyro"),
               paste0("mean", axes, "Freq_fBodyGyro"),
               "mean_fBodyAccelMag", "stdev_fBodyAccelMag",
               "meanFreq_fBodyAccelMag",
               "mean_fBodyBodyAccelJerkMag", "stdev_fBodyBodyAccelJerkMag",
               "meanFreq_fBodyBodyAccelJerkMag",
               "mean_fBodyBodyGyroMag", "stdev_fBodyBodyGyroMag",
               "meanFreq_fBodyBodyGyroMag",
               "mean_fBodyBodyGyroJerkMag", "stdev_fBodyBodyGyroJerkMag",
               "meanFreq_fBodyBodyGyroJerkMag",
               "activity_label")

# At this point we have merged both testing and training datasets, added the
# activity labels, selected only measurements of means and standard deviations
# and used descriptive variable and activity names. 

# Now the final step: create a second, independent tidy data set with the
# average of each variable for each activity and each subject
# First, melt the data to get 4 columns, using as IDs the subject ID and the
# activity label
dftidy <- melt(df, id.vars=c("subjectID", "activity_label"))

# Create the final dataset: this one has 4 columns, the last one, named
# 'mean_value' contains the mean value of the variable in column 'variable'
# for the activity in 'activity_label' and the subject ID in the 1st column
dftidy <- ddply(dftidy, .(subjectID, activity_label, variable), summarize,
                mean_value=mean(value))

# Store the tidy dataset in a text file
write.csv(dftidy, file="data/HAR_tidy_dataset.txt", row.names=FALSE)
