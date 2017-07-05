# This file contains all steps to collect, work with and clean the data set downloaded from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# remove all existing parameters, variables etc.
rm(list=ls(all=TRUE))

# load libraries
library(reshape2)

# set working directory
setwd("~/Coursera/DataScience/Part 3/Homework")

# check if a folder called "ProgAssig4" exists
if (!file.exists("ProgAssig4")){
        dir.create("ProgAssig4")
}

# set working directory new and get directory path
setwd("~/Coursera/DataScience/Part 3/Homework/ProgAssig4")
path <- getwd()

# if the folder "Data" does not exist yet, download zip file, unzip the data and rename the folder, then remove zip-file
if (!file.exists("Data")){
        
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

        TempName <- paste(path,"/Data.zip",sep="")
        download.file(fileURL,TempName)
        dateDownloaded <- date()

        unzip(TempName)
        file.rename("UCI HAR Dataset","Data")
        file.remove("Data.zip")
}

# load activity labels
act_lab <- read.table("Data/activity_labels.txt")
act_lab <- act_lab[,2]

# load features
feat <- read.table("Data/features.txt")
feat <- feat[,2]

# load relevant test data
x_test <- read.table("Data/test/X_test.txt")
y_test <- read.table("Data/test/y_test.txt")
sub_test <- read.table("Data/test/subject_test.txt")

# load relevant training data
x_train <- read.table("Data/train/X_train.txt")
y_train <- read.table("Data/train/y_train.txt")
sub_train <- read.table("Data/train/subject_train.txt")

# rename columns of x_train and x_test
names(x_test) <- feat
names(x_train) <- feat

# extract all columns with "mean" or "std" in name
SelFeat <- grepl("mean|std",feat)
data_test <- x_test[,SelFeat]
data_train <- x_train[,SelFeat]

# merge test and training data
Exp_data <- rbind(data_train,data_test)
subjects_all <- rbind(sub_train,sub_test)
Activity_labels <- rbind(y_train,y_test)

# combine experiment data with information about subjects and activities and rename first 2 columns properly
# then use descriptive activity names to name the activities in the data set
data_all <- cbind(subjects_all,Activity_labels,Exp_data)
colnames(data_all)[1:2] <- c("Subject_ID","Activity_ID")
data_all$Activity_ID <- factor(data_all$Activity_ID,labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

# create a new tidy data set with the average of each variable for each activity and each subject.
melted <- melt(data_all, id=c("Subject_ID","Activity_ID"))
tidy_data <- dcast(melted, Subject_ID + Activity_ID ~ variable, mean)

# save tidy data in file
write.table(tidy_data,"TidyDataSet.txt",row.name=FALSE)

