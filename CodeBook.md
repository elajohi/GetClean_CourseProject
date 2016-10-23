# CodeBook for run_analysis.R

## Data
The input data are already described in *features_info.txt* from the
original source. Please refer to this document.


## Output data in *run_anylsis_tidy.txt*:

1. **activity**:
   activity performed by the subject
   
   	    WALKING
        WALKING_UPSTAIRS
	    WALKING_DOWNSTAIRS
	    SITTING
        STANDING
	    LAYING  

2. **subject**:
   id number of the test person performing the activity
   
      	 numbered 1..30
	     
3. **signal**:
   type of measurement performed as described in the input data
   
   	     tBodyAcc
	     tGravityAcc
	     tBodyAccJerk
	     tBodyGyro
	     tBodyGyroJerk
	     tBodyAccMag 
	     tGravityAccMag
	     tBodyAccJerkMag
	     tBodyGyroMag
	     tBodyGyroJerkMag
	     fBodyAcc
	     fBodyAccJerk
	     fBodyGyro
	     fBodyAccMag
	     fBodyAccJerkMag
	     fBodyGyroMag
	     fBodyGyroJerkMag

4. **direction**: 

	     X, Y, Z for 3-axial signals in the X, Y and Z directions
	     NA      otherwise

5. **mean**:
   averaged mean value for each combination of activity, subject, signal
   and direction

6. **std**:
   averaged standard deviation for each combination of activity, subject
   signal and direction
