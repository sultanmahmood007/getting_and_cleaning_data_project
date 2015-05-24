### load plyr 

library (plyr)

## file location 
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
## download file from  server 
download.file(fileurl, destfile="./data/UCIHar_dataset.zip",)
## unzip file to directory 

unzip (zipfile= "./data/UCIHar_dataset.zip", exdir= "./data")

## set local file location 

filelocation <- file.path("./data", "UCI HAR Dataset")

## Read the features files x_test.txt and x_train.txt

FeaturesTest  <- read.table(file.path(filelocation, "test" , "X_test.txt" ))
FeaturesTrain <- read.table(file.path(filelocation, "train", "X_train.txt"))

## Read the activity files y_test.txt and y_train.txt 

ActivityTest  <- read.table(file.path(filelocation, "test" , "Y_test.txt" ))
ActivityTrain <- read.table(file.path(filelocation, "train", "Y_train.txt"))

## read the subject files subject_train.txt and subject_test.txt

SubjectTrain <- read.table(file.path(filelocation, "train", "subject_train.txt"))
SubjectTest  <- read.table(file.path(filelocation, "test" , "subject_test.txt"))

## 1. Merge the training and test sets to create one data set##################################################################################

### Bind the data 

Subject <- rbind (SubjectTrain, SubjectTest)
Activity <-rbind (ActivityTrain,ActivityTest)
Features <- rbind (FeaturesTrain,FeaturesTest)


### label the variables

names(Subject)<-c("subject")
names(Activity)<- c("activity")

## applies labels to  features 

FeaturesNames <- read.table(file.path(filelocation, "features.txt"),head=FALSE)

names(Features)<- FeaturesNames$V2

## all columns merged together into data frame 

merged <- cbind(Subject, Activity)
Data <- cbind(Features, merged)


##2. Extract only measurements on the mean and the standard deviation for each measurement#################################################

FN <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]


## seperates data into a subset by the names of features 

selectedNames <- c(as.character(FN),"subject","activity")


Data <- subset(Data, select=selectedNames)


##3.Uses descriptive activity names to name the activities in the data set##################################################################


activitylabels <- read.table(file.path(filelocation,"activity_labels.txt"),header=FALSE)

Activity[,1] <- activitylabels [Activity[, 1 ] , 2 ] 



## 4. Appropratly labels the data set with descriptive variable names############################################################################ 

all_data <- cbind (Features,Activity,Subject)


## makes clearer names 
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

names(Data)

## 5. from the data set in step 4 creates a second independant tidy data set with teh average of each activity and each subject############################ 

### aggregate the data using plyr

cleaned <-aggregate(. ~subject + activity, Data, mean)

#### orders the data using plyr vocab

cleaned2<-cleaned[order(cleaned$subject,cleaned$activity),]

#### creates a seperate text file with the tidy data 

write.table(cleaned2, file = "tidydata.txt",row.name=FALSE)
