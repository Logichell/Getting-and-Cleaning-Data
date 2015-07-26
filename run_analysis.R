##Assume that the data have been unzipped into the current working directory "UCI HAR Dataset".
## Load dplyr package
library("dplyr")
## Read file and store variable names in varnames character vector
varnames <- read.table("features.txt", colClasses = c("integer", "character"), nrows = 561)
varnames <- varnames$V2
## Define the number of rows to be read from each data file
## The full data set is extracted with nrows.train <- 7352, nrows.test <- 2947
nrows.train <- 7352
nrows.test <- 2947
## Read subjects' IDs
subjects.train <- tbl_df(read.table("train/subject_train.txt", col.names = "subject", nrows = nrows.train))
subjects.test <- tbl_df(read.table("test/subject_test.txt", col.names = "subject", nrows = nrows.test))
## Read activities
activities.train <- tbl_df(read.table("train/y_train.txt", col.names = "activity", nrows = nrows.train))
activities.test <- tbl_df(read.table("test/y_test.txt", col.names = "activity", nrows = nrows.test))
## Read datasets into data frames in R
data.train <- tbl_df(read.table("train/X_train.txt", col.names = varnames, nrows = nrows.train))
data.test <- tbl_df(read.table("test/X_test.txt", col.names = varnames, nrows = nrows.test))
## combine the subject and activity columns
data.train <- cbind(subjects.train, activities.train, data.train)
data.test <- cbind(subjects.test, activities.test, data.test)
##Merge all data in one data frame
data <- rbind(data.train, data.test)
## Each activity is coded as a number. Retrieve the names:
activities <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
activities <- activities$V2
## Use activity names 
data$activity <- factor(data$activity, labels = activities)
## Determine which variables refer to mean() or std()
## We'll add two columns at the beginning and we want to keep them, so we add two to every element of the index vectors
con.mean <- grep("mean()", varnames, fixed = TRUE) + 2
con.std <- grep("std()", varnames, fixed = TRUE) + 2
con.vars <- sort(c(1, 2, con.std, con.mean))
nvars <- length(con.vars)
## Select columns with "mean" or "std" in their names
data <- data %>%select(con.vars)
## Make tidy data set with average values for each variable, grouped by subject and activity
tidy <-data %>%group_by(subject, activity) %>%summarise_each(funs(mean))
## Export tidy data frame as a text file
write.table(tidy, "../tidydataset.txt", row.names = FALSE)