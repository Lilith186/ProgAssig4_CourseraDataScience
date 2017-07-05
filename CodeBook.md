# CodeBook for the R-file "run\_analysis.R"

## Descripton of the original data

The data was downloaded from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A detailed description of the experiments performed and the data collected can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In short, the data contains information about recordings of 30 subjects performing activities of daily living while carrying a waist-mounted smartphone.


## Description of the variables (of "run\_analysis.R")

* act\_lab: a factor with 6 levels describing the activities the subject performed
* feat: a factor withe 477 levels describing all features recorded
* x\_test: a data frame (test data) with 2947 observations and 561 variables described in the original data source (see above). 
* y\_test:  a data frame with 2947 observations of one variable describing the activity ID (1-6) for the test data
* sub\_test: a data frame with 2947 observations of one variable containing the subject IDs for the test data
* x\_train: a data frame (training data) with 7352 observations and 561 variables described in the original data source (see above). 
* y\_train: a data frame with 7352 observations of one variable describing the activity ID (1-6) for the training data
* sub\_train: a data frame with 7352 observations of one variable containing the subject IDs for the training data
* data\_test: a data frame (test data) with 2947 observations of  79 variables (only the features containing measurements on the mean and standard deviation)
* data\_train: a data frame (training data) with 7352 observations of  79 variables (only the features containing measurements on the mean and standard deviation)
* Exp\_data: combined data frame (data\_train + data\_test)
* subjects\_all: combined data frame (sub\_train + sub\_test)
* Activity\_labels: combined data frame (y\_train + y\_test)
* data\_all: combined data frame (subjects\_all + Activity\_labels + Exp\_data) of 10299 observations of 81 variables (the second column "Activity\_labels" contains a factor with 6 levels, see "act\_lab") 
* melted: a melted data frame (generated from data\_all) with 813621 observations of  4 variables ("Subject\_ID", "Activity\_ID", "variable" and respective "value")
* tidy\_data: tidy data frame with the average of each variable for each activity and each subject (180 observations of 81 variables).


## Transformation steps

1. all existing variables are removed from the workspace
2. all libraries necessary to perform the analysis are loaded
3. a working directory is set
4. if not existing, the data is downloaded and saved in a respective directory (also, working directory is updated according to the new folders created)
5. the activity labels and features are read into the varibales "act_lab" and "feat"
6. the relevant test and training data are read into respective variables (x\_test, y\_test, sub\_test, x\_train, y\_train, sub\_train)  
7. the column names of x\_train and x\_test are renamed according to the features in "feat"
8. two new data frames are created that only contain measurements on the mean and standard deviation of each feature (data\_test and data\_train)
9. the test and training data are merged together
10. the measurements and the information about subjects and activities are combined and the first 2 columns are renamed properly
11. the activity ID column gets descriptive activity names
12. a new melted data frame (generated from data\_all) 4 variables ("Subject\_ID", "Activity\_ID", "variable" and respective "value") is created
13. a tidy data frame with the average of each variable for each activity and each subject is generated with the function dcast
14. the new tidy data frame is stored in a text-file named "TidyDataSet.txt"
