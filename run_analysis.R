## ----libraries-----------------------------------------------------------
library(plyr)
library(dplyr)
library(tidyr)
library(readr)

## ----reading data--------------------------------------------------------
# download data
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- paste0("https://d396qusza40orc.cloudfront.net/",
                  "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
if(!file.exists("./data/Dataset.zip")) {
    download.file(fileUrl, destfile = "./data/Dataset.zip" , method = "curl")
}

# unpack data
if(!file.exists("./UCI\ HAR\ Dataset")) {
    unzip("./data/Dataset.zip")
}

# read data
subjectTest <- read.table("./UCI\ HAR\ Dataset/test/subject_test.txt")
xTest <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt")
yTest <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt")
subjectTrain <- read.table("./UCI\ HAR\ Dataset/train/subject_train.txt")
xTrain <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt")
yTrain <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt")
features <- read.table("./UCI\ HAR\ Dataset/features.txt")
activityLabels <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt")

## ----merge---------------------------------------------------------------
# name columns acc to features 
# make.unique adds ".number" to the string which is necessary due to only
# 477 levels but 561 rows
colnames(xTest) <- make.unique(as.character(features$V2))
colnames(xTrain) <- make.unique(as.character(features$V2))
# add a column with factor "train" or "test"
# and subject and labels to dataframes xT...
type_of_dataset <- as.factor(c("train", "test"))
xTest <- mutate(xTest, 
                subject = subjectTest$V1, labels = yTest$V1, 
                dataset = type_of_dataset[2])
xTrain <- mutate(xTrain, 
                 subject = subjectTrain$V1, labels = yTrain$V1, 
                 dataset = type_of_dataset[1])
# merge both dataframes
xComplete <- rbind(xTest, xTrain)
xComplete <- tbl_df(xComplete)

## ----extract-------------------------------------------------------------
xComplete <- xComplete %>%
    select(matches("mean\\(\\)|std\\(\\)|subject|labels|dataset"))

## ----activity labels-----------------------------------------------------
# rename label numbers to activityLabels
xComplete <- xComplete %>%
    merge(activityLabels, by.x = "labels", by.y = "V1", sort = FALSE) %>%
    rename(activity = V2) %>%
    select(-labels)

## ----reshape and relabel-------------------------------------------------
xComplete <- xComplete %>%
    mutate(measurementid = 1:n()) %>%
    gather(
        -(subject:measurementid), key = signal, value = measurement, 
        factor_key = TRUE) %>%
    separate(
        signal, into = c("signal", "functn", "direction"), 
        sep = "-", fill = "right") %>%
    mutate(
        functn = revalue(as.factor(functn),
                         c("mean()" = "mean", "std()" = "std")), 
        signal = as.factor(signal),
        direction = as.factor(direction)) %>%
    spread(key = functn, value = measurement)

## ----second dataset------------------------------------------------------
xComplete <- tbl_df(xComplete)
by_act_subj <- group_by(xComplete, activity, subject, signal, direction)
new_df <- summarize(by_act_subj, 
                    mean = mean(mean, na.rm = TRUE), 
                    std = mean(std, na.rm = TRUE))
new_df <- arrange(new_df, subject)

## ----write data----------------------------------------------------------
write.table(new_df, 
            file = "./data/run_anylsis_tidy.txt", row.names = FALSE, sep = ",") 

