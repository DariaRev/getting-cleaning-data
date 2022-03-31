library(dplyr)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "data.zip"))
unzip("data.zip")

# read training data
train_subj  <- read.table(file.path(path, "UCI HAR Dataset/train/subject_train.txt"))
train_x  <- read.table(file.path(path, "UCI HAR Dataset/train/X_train.txt"))
train_y  <- read.table(file.path(path, "UCI HAR Dataset/train/y_train.txt"))

#read test data
test_subj <- read.table(file.path(path, "UCI HAR Dataset/test/subject_test.txt"))
test_x <- read.table(file.path(path, "UCI HAR Dataset/test/X_test.txt"))
test_y <- read.table(file.path(path, "UCI HAR Dataset/test/y_test.txt"))

#read features
features <- read.table(file.path(path, "UCI HAR Dataset/features.txt"))

#read labels
act_labels <- read.table(file.path(path, "UCI HAR Dataset/activity_labels.txt"))
colnames(act_labels) <- c("activity_id", "activity_label")

#make one table for all
activity <- rbind(
  cbind(train_subj, train_x, train_y),
  cbind(test_subj, test_x, test_y)
)
colnames(activity) <- c("subject_id", features[, 2], "activity_id")


# extract mean and standard
colnamess <- colnames(activity)
columns_keep <- grepl("subject_id|activity_id|mean|std", colnamess)
activity <- activity[, columns_keep]


#use descriptive activity names
activity_names <- merge(activity, act_labels,
                              by = "activity_id",
                              all.x = TRUE)


#label data with descriptive names
#names(activity)
names(activity_names)<-gsub("Acc", "Accelerometer", names(activity_names))
names(activity_names)<-gsub("Gyro", "Gyroscope", names(activity_names))
names(activity_names)<-gsub("BodyBody", "Body", names(activity_names))
names(activity_names)<-gsub("Mag", "Magnitude", names(activity_names))
names(activity_names)<-gsub("^f", "Frequency", names(activity_names))
names(activity_names)<-gsub("^t", "Time", names(activity_names))
names(activity_names)<-gsub("tBody", "TimeBody", names(activity_names))
names(activity_names)<-gsub("-mean()", "Mean", names(activity_names), ignore.case = TRUE)
names(activity_names)<-gsub("-std()", "Standard derivation", names(activity_names), ignore.case = TRUE)
names(activity_names)<-gsub("-freq()", "Frequency", names(activity_names), ignore.case = TRUE)

# create tidy data

activity_means <- activity_names %>% 
  group_by(subject_id, activity_id) %>%
  summarise_each(funs(mean))

# output to file 
write.table(activity_means, "tidy.txt", row.names = FALSE, quote = FALSE)