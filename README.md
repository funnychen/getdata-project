> This document explains run_analysis.R.

run_analysis.R does the follow things:

+ Read the training and test data, merging subject, x, y and activity labels into `all.dataset`.
+ Create a new dataset only contains the subjects, activities, and selected features.
+ Create a tidy dataset with the average of each variable for each activity and each subject. 

### Create all.dataset

1. Load the activity label into `activity.labels`, column names are
 + id: activity id
 + activity: activity name
2. Load the features into `features`, column names are
 + id: feature id
 + feature: feature name
3. Create `feature_labels.txt` whit seleted features, column names are
 + id: seleted feature id
 + feature: factor for the x describes bellow, which transformed from features in features.txt by replacing `-` to `.` and remove `()`
4. Load the selected features into `feature.selected`
5. Read the training and test dataset and create `train.data` and `test.data` by merging subject, x and y. Notice that, the column names of `train.x` and `test.x` are set to the feature id. So that, it can be easily replace to the filted by the seleted features.
6. Create `all.dataset` by merging `train.data`, `test.data` and `activity.labels`. `all.dataset` is a data.frame with 10299 rows and 68 columns(`subject`, `activity`, `activity.id`, and 561 features).

### Create dataset with seleted features

`dataset` is a subset of `all.dataset` with `subject`, `activity` and 66 selected features. The selected freature's column name is set to the `feature.selected$feature`.

### Create tidy dataset

The tidy dataset is created by the function `melt()` and `dcast()`, to compute the mean of features by each subject and each activity.

