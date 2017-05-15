# Getting-and-cleaning
Project
All data acquired from use library(downloader): "https://d396qusza40orc.cloudfront.ne, dest= "bodymove.zip"
download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dest= "bodymove.zip", mode="wb")
The relevant files extracted from this zip file (which I called "bodymove.zip" for convenience) are as follows:

The creation of the resultant tidy data file can be completed by running the run_analysis.R with the some modification of the setwd() instruction (which can be omitted altogether if you want to create a subdirectory within your current working directory.

# Filename	
## File_Structure	
### Content_description
1. features.txt	
+ 561 observations of 2 variables	
+ Variable/column names for X_train.txt and X_test.txt
2. subject_train.txt	
+ 7352 observations of 1 variable	
+ Identity of subjects (1-30) for each row in X_train.txt
3. subject_test.txt	
+ 2947 observations of 1 variable	
+ Identity of subjects (1-30) for each row in X_test.txt
4. activity_labels.txt	
+ 6 observations of 2 variables	
+ Activity labels (6 activities) to correspond with values of common field in y_train.txt and y_test.txt
5. X_train.txt	
+ 7352 observations of 561 variables	
+ Observations and measurements on 561 measures for subjects and activities recorded in same sequence in subject_train.txt and y_train.txt
6. X_test.txt	
+ 2947 observations of 561 variables	
+ Observations and measurements on 561 measures for subjects and activities recorded in same sequence in subject_test.txt and y_test.txt
7. y_train.txt	
+ 7352 observations of 1 variable	
+ The activity number for each of the corresponding records in X_train.txt
8. y_test.txt	
+ 7352 observations of 1 variable	
+ The activity number for each of the corresponding records in X_test.txt
