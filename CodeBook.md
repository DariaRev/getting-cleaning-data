## Data
A full description is available at the site where the data was obtained:
[site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:
[data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

## Process of work
1. Reading files - training and test tables, feature vector and activivty labels
2. Assigning names and merging files in one set
3. Extracting mean and std
4. Making necessary subset
5. Using descriptive activity names to name the activities in the data set - replacing activity identifiers with their names and descriptive variable names wih their full names
6. Grouping dataset to create a new file with tidy data
7. Writing to txt file tidy dataset

## Variables
train_subj, train_x, train_y, test_subj, test_x,test_y, features, act_labels - data from downloaded files
activity - merged dataset
activity_names - merged set with right activity names
activity_means - final tidy dataset

## How to use this and get tidy data?
1. Download the data and unzip it to preferred directory
2. Run the R script
