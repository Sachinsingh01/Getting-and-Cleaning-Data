# This R script run_analysis.R is performing below operations,

# Source - 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#  measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

# Step 1 - Merges the training and the test sets to create one data set.

tmp1 <- read.table("train/X_train.txt")
tmp2 <- read.table("test/X_test.txt")
X <- rbind(tmp1, tmp2)

tmp1 <- read.table("train/subject_train.txt")
tmp2 <- read.table("test/subject_test.txt")
S <- rbind(tmp1, tmp2)

tmp1 <- read.table("train/y_train.txt")
tmp2 <- read.table("test/y_test.txt")
Y <- rbind(tmp1, tmp2)

# Step 2 - Extracts only the measurements on the mean and standard deviation
# for each measurement.

features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indices_of_good_features]
names(X) <- features[indices_of_good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# Step 3 - Uses descriptive activity names to name the activities in the data
# set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# Step 4 - Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned <- cbind(S, Y, X)

# Step 5 - From the data set in step 4, creates a second, independent tidy data
#  set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
meanData = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
    for (a in 1:numActivities) {
        meanData[row, 1] = uniqueSubjects[s]
        meanData[row, 2] = activities[a, 2]
        tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
        meanData[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
        row = row+1
    }
}
write.table(meanData, "tidy_average_data.txt", sep="\t",row.names = FALSE)
