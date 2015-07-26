# Getting-and-Cleaning-Data
Peer Assignment
Code Book
=========

This code book describes the variables, the data and all transformations

Load variables and data 
------------------

Two sets of data: "X_train.txt" ; "X_test.txt" 

Original variables names are in the file ""features.txt" ,each obs corresponds to a particular subject and  activity.
List of subjects is in the files:"subject_train.txt"; "subject_test.txt"
List of activities is in the files:"y_train.txt";"y_test.txt"

Activites are coded as numbers from 1 to 6.
The translation from numbers to the actual name of the activity is given in the file "activity_labels.txt".

filter variables "means" and "standard deviations",
which are characterized by variable names containing "mean()" or "std()".

Transformations
---------------

The raw data now is loaded into R in one data frame
Those are all the observations we'll use  from the training and testing sets merged together,
for all the 561 variables (also called features, measurements), plus two extra columns:
one for the subject ID and another for the activity code.

Activity codes are then replaced by the actual activity names, as given in the file "activity_labels.txt".

Only 66 variable names contain either "mean()" or "std()".
We select those.
The result is a data frame with 10299 obs of 68 variables
(the 66 corresponding to means and standard deviations, plus the two with subject ids and activities).

Finally, we build a second data frame where we compute the means of all 66 variables
grouped according to subject and activity.
Since there are 30 subjects and 6 different activities,
the result is a data frame containing 30*6 = 180 observations of 68 variables.
