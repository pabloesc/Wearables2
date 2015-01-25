#run_Analysis.R - Program assignment from Coursera Data Science - Getting
#and cleaning Data. 
#
#@pabloesc

library(plyr)
library(reshape)
#------------------ STEP 1
#Merges the training and the test sets to create one data set.

#------------------READ DATA
#features = columns of x data
#activities = description of y data
features <- read.table ("./data/files/UCI HAR Dataset/features.txt")
activity_labels <-  read.table ("./data/files/UCI HAR Dataset/activity_labels.txt")

#read test data:
x_test <- read.table ("./data/files/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table ("./data/files/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table ("./data/files/UCI HAR Dataset/test/subject_test.txt")

#read training data:
x_train <- read.table ("./data/files/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table ("./data/files/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table ("./data/files/UCI HAR Dataset/train/subject_train.txt")

#------------------MERGE DATA
#merge x data
x_merged <- rbind(x_train,x_test)
names(x_merged)<- as.character(features$V2)

#merge subject data
subject_merged <- rbind (subject_train,subject_test)
names (subject_merged) <- c("subject")

#merge y data and change number with description
y_merged <- rbind(y_train,y_test)
y_activity <- join(y_merged,activity_labels,by="V1")
y_activity <- subset(y_activity,select = V2)
names(y_activity) <- c("activity")

#---------------res is the MERGED DATA
res <- cbind(x_merged,subject_merged,y_activity)
#---------------FINISH STEP 1

#---------------STEP 2
#Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_columns <- grep('mean', names(res), value=TRUE)
standard_columns <- grep('std', names(res), value=TRUE)
res_extract <- res[,c(mean_columns,standard_columns)]
res_extract <- cbind(res_extract,subject_merged,y_activity)
#---------------FINISH STEP 2 : res_extract is the extracted Data

#Uses descriptive activity names to name the activities in the data set
# OK DONE in STEP1 with join of dplyr and subsetting

#Appropriately labels the data set with descriptive variable names. 
# OK DONE in STEP1

#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
#---------------STEP 5
average <- res_extract
average <- average %>% group_by(subject,activity) %>% summarise_each(funs(mean))
#---------------FINISH STEP5

#---------------OUTPUT
average

#write file
#write.table() using row.name=FALSE
#write.table(average,file="result.txt",row.names=FALSE)

