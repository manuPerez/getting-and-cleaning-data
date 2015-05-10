library("reshape")
library("reshape2")

directory = "UCI HAR Dataset/"
setwd(directory)

temporalUno = read.table("activity_labels.txt", sep = "")
activity_labels = as.character(temporalUno$V2)
temporalDos = read.table("features.txt", sep = "")
attribute_names = temporalDos$V2
       
#train
x_train = read.table("train/X_train.txt", sep = "")
names(x_train) = attribute_names
y_train = read.table("train/y_train.txt", sep = "")
names(y_train) = "Activity"
y_train$Activity = as.factor(y_train$Activity)
levels(y_train$Activity) = activity_labels
       
train_subjects = read.table("train/subject_train.txt", sep = "")
names(train_subjects) = "subject"
train_subjects$subject = as.factor(train_subjects$subject)
train = cbind(x_train, train_subjects, y_train)
       
#test zone
x_test = read.table("test/X_test.txt", sep = "")
names(x_test) = attribute_names
y_test = read.table("test/y_test.txt", sep = "")
names(y_test) = "Activity"
y_test$Activity = as.factor(y_test$Activity)
levels(y_test$Activity) = activity_labels
       
test_subjects = read.table("test/subject_test.txt", sep = "")
names(test_subjects) = "subject"
test_subjects$subject = as.factor(test_subjects$subject)
test = cbind(x_test, test_subjects, y_test)
       
data = rbind(test, train)
       
id_labels   = c("subject", "Activity")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)
       
tidy_data = dcast(melt_data, subject + Activity ~ variable, mean)
       
write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)

rm(temporalUno, temporalDos, y_train, y_test, x_train, x_test, train_subjects, test_subjects, 
   activity_labels, attribute_names, data, melt_data,test, tidy_data, train, data_labels, directory, id_labels)
