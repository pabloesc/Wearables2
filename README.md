# ReadMe document for Course Project: Getting and cleaning data

@pabloesc

RunAnalysis.R is a script prepared for generating output of file: Average. Average dataset is the result of several cleaning and tidying jobs in R from file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Data description:
>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

Script is done through 5 different Steps:

#1. Merges the training and the test sets to create one data set. 
Extracts only the measurements on the mean and standard deviation for each measurement. 

For this step basic R functions were used for reading text files into variables: 

- features = columns of x data
- activities = description of y data
- test data: x_test, y_test and subject_test
- training data: x_train, y_train and subject_train

rbind and cbind commands were used to subset and merge the dataset, features had to be coerced to character type
```sh
$ rbind(x_train,x_test)
```


res is the output dataset of this step.


#2. Extracts only the measurements on the mean and standard deviation for each measurement
For this step, we subset the dataframe omitting the columns we don't want to get. The goal is to get a new dataset (res_extract) with columns with words: mean and std.

For this step I've used the search command grep:
```sh
 grep('mean', names(res), value=TRUE)
 ```
#3. Uses descriptive activity names to name the activities in the data set

This step was in fact done in step1.

In order to substitute the numbering of activities with a descriptive label I've used join command from plyr package:
```sh
join(y_merged,activity_labels,by="V1")
```

#4. Appropriately labels the data set with descriptive variable names. 
I've used the text file features to name properly the variables/columns of the dataset.

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Using the plyr commands with the %>% command and summarise_each I have shown the average of each variable for each activity and each subject.

```sh
average <- average %>% group_by(subject,activity) %>% summarise_each(funs(mean))
```

# Last Step: showing dataset average
Finally the dataset average is shown 

**Free Software, Hell Yeah!**