library(dplyr)

#Initial Download
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/file.zip",method="auto")
unzip("./data/file.zip");
setwd("./UCI HAR Dataset");

#Reading in test data
testSubj = read.table("test/subject_test.txt");
testX = read.table("test/X_test.txt");
testY = read.table("test/Y_test.txt");
colLabels = read.table("features.txt")$V2
testBind = cbind(testX,testY,testSubj);
colnames(testBind) = colLabels;
colnames(testBind)[562] = "activity";
colnames(testBind)[563] = "subject";

#Reading in train data
trainSubj = read.table("train/subject_train.txt");
trainX = read.table("train/X_train.txt");
trainY = read.table("train/Y_train.txt");
trainBind = cbind(trainX,trainY,trainSubj);
colnames(trainBind) = colLabels;
colnames(trainBind)[562] = "activity";
colnames(trainBind)[563] = "subject";

#Concatinating Data
fullData = rbind(testBind, trainBind);
search = c(".*mean.*", ".*std");
fullSubset = fullData[,grep(paste(search, collapse = "|"), names(fullData))]
fullActivity = rbind(testY,trainY);
fullSubj = rbind(testSubj, trainSubj);
fullSubset = cbind(fullSubset,fullActivity,fullSubj)
colnames(fullSubset)[80] = "activity";
colnames(fullSubset)[81] = "subject";

#Naming Activities
labels = read.table("activity_labels.txt")[,2];
fullSubset$activity[fullSubset$activity == 1] = "WALKING";
fullSubset$activity[fullSubset$activity == 2] = "WALKING UPSTAIRS";
fullSubset$activity[fullSubset$activity == 3] = "WALKING DOWNSTAIRS";
fullSubset$activity[fullSubset$activity == 4] = "SITTING";
fullSubset$activity[fullSubset$activity == 5] = "STANDING";
fullSubset$activity[fullSubset$activity == 6] = "LAYING";

#Averaging each activity
test <- fullSubset %>% group_by(subject,activity);
t = test %>% summarise_each(funs(mean)) %>% as.data.frame

#Writing file
write.table(t, "TidyData.txt", row.name=F)