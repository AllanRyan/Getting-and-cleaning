setwd("~/Getting and Cleaning/project")

if(!file.exists("./data"))(dir.create("./data"))


library(tidyverse)

library(downloader)
download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dest= "bodymove.zip", mode="wb") 
#unzip ("bodymove.zip", exdir = "./data")
unzip(zipfile="bodymove.zip",exdir="./data")


xtrain <-read.table(
           "./data/UCI HAR Dataset/train/X_train.txt",  header = FALSE, sep = "")

ytrain <-read.table(
  "./data/UCI HAR Dataset/train/y_train.txt",  header = FALSE, sep = "")

subtrain <-read.table(
  "./data/UCI HAR Dataset/train/subject_train.txt",  header = FALSE, sep = "")


xtest <-read.table(
  "./data/UCI HAR Dataset/test/X_test.txt",  header = FALSE, sep = "")

ytest <-read.table(
  "./data/UCI HAR Dataset/test/y_test.txt",  header = FALSE, sep = "")

subtest <-read.table(
  "./data/UCI HAR Dataset/test/subject_test.txt",  header = FALSE, sep = "")

features <-read.table(
  "./data/UCI HAR Dataset/features.txt",  header = FALSE, sep = "")

varnames <- as.character(features[,2])

activities <- read.table(
  "./data/UCI HAR Dataset/activity_labels.txt",  header = FALSE, sep = "")



## STEP 1: Merge training and test sets and add column names (from features.txt)colnames(xtrain) <- varnames

colnames(xtrain) <- varnames
colnames(xtest) <- varnames


x_both <- rbind(xtrain,xtest)

## STEP 2: Extract just the colums dealing with means and standard deviations

just_mean_and_std <- x_both[,grepl("-mean|-std",colnames(x_both))]
just_mean_and_std <- just_mean_and_std[,!grepl("mean[Ff]req",
                                               colnames(just_mean_and_std))]


## STEP 3 & 4: Uses descriptive names to label the activities and adds descriptive 
## labels to  variables (activity_name,subject, and for good measure a column labelled 
## "group" which identifies the source of the data as either "train" or "test")

colnames(activities) <- c('activity','activity_name')

colnames(subtest) <- c('subject')
colnames(subtrain) <- c('subject')

colnames(ytrain) <- c('activity')
colnames(ytest) <- c('activity')

xtrain_descriptives <- cbind(subtrain, ytrain)
xtest_descriptive <- cbind(subtest, ytest)

traingroup <- data.frame(group=as.factor(c(rep("train",7352))))

testgroup <- data.frame(group=as.factor(c(rep("test",2947))))

## create two datasets with columns of "group", "subject",  "activity", and 
## "activity_name")
xtrain_descriptives <- cbind(traingroup, xtrain_descriptives)
xtest_descriptives <- cbind(testgroup, xtest_descriptive)

## Combine training and test descriptives into one data frame.
x_descriptives <- rbind(xtrain_descriptives,xtest_descriptives)


x_descriptives <- merge(x_descriptives,activities, by.x="activity", by.y="activity")


## Final source data with variable names, descriptive labels and only relevant
## columns with unprocessed means and standard deviations
Descrips_means_and_std <- cbind(x_descriptives,just_mean_and_std )

write.csv(Descrips_means_and_std, "tidy_raw.csv")


## Step 5: Create second tidy data set with average of each variable for each 
## subject and activity

tidy <- select(Descrips_means_and_std, -group) %>%
      group_by(subject,activity_name) %>%
  summarise_all(mean)

write.csv(tidy, "tidy_processed.csv")

## Remove raw data and intermediate processing objects
rm("features"  , "subtest"  ,  "subtrain",   "testgroup",  "traingroup", "varnames",  
   "xtest"  ,    "xtrain",     "ytest",      "ytrain")


