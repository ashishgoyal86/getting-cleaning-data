CodeBook for the tidy dataset
=================================

## Data source

This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" which was originally made available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### run_analysis.R

The file run_analysis.R takes the data from the UCIHAR Dataset and processes it. First we read all the data into variables:
- trainX, trainY, testX, testY: the training and test data
- subjectX, subjectY: subjects for train and test
- var: variable names
- activityLabels : descriptive labels for activities

Then begins the transform:
1. First merge the data
2. Then filter the columns to only means and standard deviation.
3. Add descriptive labels to activities
4. Add variable names to columns
5. Calculate average of each variable for each activity and each subject.

### Output
The output file contains one row for each valid combination of person and activity.
Each row contains averages for all the variables (only mean and std filtered in step 2 above) for each combination of person and activity.
