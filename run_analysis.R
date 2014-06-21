base <- "UCI HAR Dataset/"

#Read all the files

xTrain <- read.table(paste(base, "train/X_train.txt", sep=""))
yTrain <- read.table(paste(base, "train/Y_train.txt", sep=""))

xTest <- read.table(paste(base, "test/X_test.txt", sep=""))
yTest <- read.table(paste(base, "test/Y_test.txt", sep=""))

subjectTrain <- read.table(paste(base, "train/subject_train.txt", sep=""))
subjectTest <- read.table(paste(base, "test/subject_test.txt", sep=""))

vars <- read.table(paste(base, "features.txt", sep=""));
activityLabels = read.table(paste(base, "activity_labels.txt", sep=""))

# 1. Merge the training and the test sets to create one data set.
mergedX <- rbind(xTrain, xTest)
mergedY <- rbind(yTrain, yTest)
mergedSubjects <- rbind(subjectTrain,subjectTest)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
meanColumns <- grep("mean[(][)]", vars[,2])
stdColumns <- grep("std[(][)]", vars[,2])

filterdColumns <- sort(c(meanColumns,stdColumns))

mergedX <- mergedX[,filterdColumns]

# 3. Use descriptive activity names to name the activities in the data set
activityWithLables <- merge(mergedY, activityLabels, by=1, sort=FALSE)
mergedX <- cbind(activityWithLables[,2], mergedX)

mergedX <- cbind(mergedSubjects, mergedX)

# 4. Appropriately label the data set with descriptive variable names.
names(mergedX) <- c("subject","activityLabel", as.character(vars[filterdColumns,2]))

# 5. Creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject. 

tidy <- ddply(mergedX[,3:length(mergedX)], .(mergedX$subject, mergedX$activityLabel), colMeans)
rownames(tidy) <- paste("person",tidy[,1], tidy[,2], sep="_")
tidy <- tidy[,3:ncol(tidy)]

write.csv(tidy,file="tidy.txt")
