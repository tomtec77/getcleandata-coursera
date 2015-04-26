# Code Book

## Original data

The data for the project is downloaded from this link: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This file unzips into a directory called 'UCI HAR Dataset'. Training and testing
data sets are in the 'train' and 'test' subdirectories, respectively.

## Files used

Description for the training set (the testing set provides similar files):

- `subject_train.txt`: provides subject IDs
- `X_train.txt`: training data set
- `y_train.txt`: training activity labels

We won't load the data in the 'Inertial Signals' subdirectories since we want
to extract only measurements on the mean and standard deviation for each
measurement, and the files in 'Inertial Signals' do not contain such data.

Additionally, file `activity_labels.txt` provides descriptive names for the 
activity levels and `features.txt` provides initial names for the variables
(which are later changed).

## Data selection

We select from the combined set only those columns that correspond to
measurements on the mean and standard deviation for each measurement, plus the
activity labels and subject IDs. We discard all features that do not contain
either 'mean' or 'std' in the name (as read initially from `features.txt`).

## Variables in final data set

- `subjectID` (integer)  
  Numeric subject ID (1-30)
  
- `activity_label` (character)  
  Label which describes the type of activity. Possible values:  
  LAYING  
  SITTING  
  STANDING  
  WALKING  
  WALKING_DOWNSTAIRS  
  WALKING_UPSTAIRS
  
- `variable` (character)  
  Name of the variable whose mean is provided in column `mean_value`.
  meanX_tBodyAccel  
  meanY_tBodyAccel  
  meanZ_tBodyAccel  
  stdevX_tBodyAccel  
  stdevY_tBodyAccel  
  stdevZ_tBodyAccel  
  meanX_tGravityAccel
  meanY_tGravityAccel   
  meanZ_tGravityAccel 
  stdevX_tGravityAccel      
  stdevY_tGravityAccel  
  stdevZ_tGravityAccel  
  meanX_tBodyAccelJerk          
  meanY_tBodyAccelJerk  
  meanZ_tBodyAccelJerk 
  stdevX_tBodyAccelJerk         
  stdevY_tBodyAccelJerk     
  stdevZ_tBodyAccelJerk 
  meanX_tBodyGyro   
  meanY_tBodyGyro  
  meanZ_tBodyGyro 
  stdevX_tBodyGyro      
  stdevY_tBodyGyro      
  stdevZ_tBodyGyro 
  meanX_tBodyGyroJerk  
  meanY_tBodyGyroJerk       
  meanZ_tBodyGyroJerk 
  stdevX_tBodyGyroJerk  
  stdevY_tBodyGyroJerk  
  stdevZ_tBodyGyroJerk 
  mean_tBodyAccelMag        
  stdev_tBodyAccelMag   
  mean_tGravityAccelMag  
  stdev_tGravityAccelMag        
  mean_tBodyAccelJerkMag        
  stdev_tBodyAccelJerkMag  
  mean_tBodyGyroMag         
  stdev_tBodyGyroMag    
  mean_tBodyGyroJerkMag     
  stdev_tBodyGyroJerkMag    
  meanX_fBodyAccel 
  meanY_fBodyAccel   
  meanZ_fBodyAccel          
  stdevX_fBodyAccel     
  stdevY_fBodyAccel  
  stdevZ_fBodyAccel          
  meanXFreq_fBodyAccel      
  meanYFreq_fBodyAccel  
  meanZFreq_fBodyAccel      
  meanX_fBodyAccelJerk      
  meanY_fBodyAccelJerk  
  meanZ_fBodyAccelJerk      
  stdevX_fBodyAccelJerk         
  stdevY_fBodyAccelJerk  
  stdevZ_fBodyAccelJerk      
  meanXFreq_fBodyAccelJerk      
  meanYFreq_fBodyAccelJerk 
  meanZFreq_fBodyAccelJerk      
  meanX_fBodyGyro           
  meanY_fBodyGyro  
  meanZ_fBodyGyro       
  stdevX_fBodyGyro      
  stdevY_fBodyGyro  
  stdevZ_fBodyGyro      
  meanXFreq_fBodyGyro   
  meanYFreq_fBodyGyro   
  meanZFreq_fBodyGyro           
  mean_fBodyAccelMag        
  stdev_fBodyAccelMag  
  meanFreq_fBodyAccelMag  
  mean_fBodyBodyAccelJerkMag    stdev_fBodyBodyAccelJerkMag 
                          
meanFreq_fBodyBodyAccelJerkMag          mean_fBodyBodyGyroMag         stdev_fBodyBodyGyroMag 
      
     meanFreq_fBodyBodyGyroMag      mean_fBodyBodyGyroJerkMag     stdev_fBodyBodyGyroJerkMag 
                           
 meanFreq_fBodyBodyGyroJerkMag 
                        
`mean_value`: (numeric)  
  Mean value of variable listed in `variable`