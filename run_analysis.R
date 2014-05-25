library(plyr)
library(reshape2)

# Activity labels
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              col.names = c("id", "activity"))
# Features
features <- read.table("./UCI HAR Dataset//features.txt", 
                       col.names = c("id", "feature"))

# My selected features. 
# The first field is the seleted feature id.
# The second field is feature label, which transform from features in features.txt 
# to be a suitable factor.
features.selected <- read.table("./UCI HAR Dataset/feature_labels.txt",
                                col.names = c("id", "feature"))


## Read data and merge to one dataset.
# Read training data
train.x <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(train.x) <- features$id
train.y <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                      col.names = c("activity.id"))
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                            col.names = c("subject"))
train.data <- cbind(train.subject, cbind(train.x, train.y))

# Read test data
test.x <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(test.x) <- features$feature.id
test.y <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                     col.names = c("activity.id"))
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           col.names = c("subject"))
test.data <- cbind(test.subject, cbind(test.x, test.y))

# Merge training data, test data, and the activity name
all.dataset <- merge(merge(train.data, test.data, all = TRUE), 
                 activity.labels, by.x = "activity.id", by.y = "id", all = TRUE)


## Create a new dataset only contains the subjects, activities,
## and selected features.

dataset <- all.dataset[, c("subject", "activity", features.selected$id)]
colnames(dataset) <- c("subject", "activity", 
                       as.character(features.selected$feature))


## Create the tidy data set

melt.data <- melt(dataset, id = c("subject", "activity"),
             measure.vars = features.selected$feature)
tidy.data <- dcast(melt.data, subject + activity ~ variable, fun.aggregate = mean)

#write.table(tidy.data, "./tidy_data.txt")

#tidy.data

