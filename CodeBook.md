
Variables in The Script run_analysis.R 

The data in the script comes from the files x_train, y_train, x_test, y_test, subject_train, features.txt, activity_labels.txt and subject_test.

'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.



Subject:

The Values of the variable come from the data provided in the text files of subject_train.txt and subject_test.txt.

Features:

Features.txt provides the names of the variables.
The values of the variables comes from the data provided in the text files of x_train.txt and x_test.txt


Activity :

activity_labels.txt provides the levels of the variable and the values come from the y_train.txt and y_test.txt



run_analysis.R carries out the fives steps as described in the comments of the file.

1. It first reads in all the text files , then it binds the data together using rbind, 

2. the columns with the mean and standard deviation measures are extracted from the dataset and given their names.

3. the activity labels are then applied to the activity data changing the numbers for the laels in the file.

4. The column names are then changed to make it easier to identify 

5. A new tidy data set is generated using Plyr . In this repo it is shown as tidydata.txt

