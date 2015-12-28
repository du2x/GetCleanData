library(reshape2)

### Reading data Files ###
trainx_data <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainActivity_data <- read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE)
trainSubject_data <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

testx_data <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
testActivity_data <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE)
testSubject_data <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

### 1 ###
merged = rbind(trainx_data, testx_data)
activityMerged = rbind(trainActivity_data, testActivity_data)
subjectMerged = rbind(trainSubject_data, testSubject_data)


### 2 ###
features = read.table('UCI HAR Dataset/features.txt', header=FALSE)
features = features[,2]
ftmeanindexes = grep('mean()', features)
ftstdindexes = grep('std()', features)
ftindexes = c(ftmeanindexes, ftstdindexes)
ssmerged = merged[, ftindexes]

### 3 ###
fnActivity <- function(num) {
  switch(num,
         "1" = "WALKING",
         "2" = "WALKING_UPSTAIRS",
         "3" = "WALKING_DOWNSTAIRS",
         "4" = "SITTING",
         "5" = "STANDING",
         "6" = "LAYING"
  )
}
ssmerged<-cbind(ssmerged, sapply(activityMerged[,1], fnActivity))

### 4 ###
ftnames <- c(as.character(features[ftmeanindexes]), as.character(features[ftstdindexes]))
ftnames<-gsub("-std\\(\\)", "Std", ftnames)
ftnames<-gsub("-mean\\(\\)", "Mean", ftnames)
names(ssmerged) <- c(ftnames, 'Activity')

#### 5 ####
# create new, independent dataset, from the ssmerged dataset, appending subject column
nd<-cbind(ssmerged, subjectMerged)
# adjust column names
names(nd)<- c(names(ssmerged), 'Subject')
# melt the new dataset
melted<-melt(nd, id=c("Activity", "Subject"), measure.vars=ftnames)
# dcasting grouped by activities and subjects for each variable
result<-dcast(melted, Activity + Subject~ variable, mean)

# writing result to file
write.table(result, file="result.txt", row.name=FALSE)
