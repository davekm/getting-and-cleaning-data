
# read in training and test datasets
test1<-read.table('GCDATA/test/X_test.txt')
act_test<-read.table('GCDATA/test/y_test.txt')
subj_test<-read.table('GCDATA/test/subject_test.txt')

train1<-read.table('GCDATA/train/X_train.txt')
act_train<-read.table('GCDATA/train/y_train.txt')
subj_train<-read.table('GCDATA/train/subject_train.txt')

# column names for test and training data frames
features<-read.table('GCDATA/features.txt', stringsAsFactors=FALSE)

# replace () and - with . in column names
temp1<-gsub('()','',features[,2], fixed=T)
temp2<-gsub('_','.',temp1)
lbls<-c('subject','activity',tolower(gsub('-','.',temp2)))

# save only the mean and std deviation for each measurement
# keep even columns with meanFreq - better to have a little too much data
mlist<-grepl('mean', lbls)
sdlist<-grepl('std', lbls)

# keep subject, activity columns and all columns with mean or std() in name
keep_list<-mlist|sdlist
keep_list[1:2]<-TRUE  # need first two columns of data frame 

# merge training and test datasets
test2<-cbind(subj_test, act_test, test1)
train2<-cbind(subj_train, act_train, train1)
all_data<-rbind(train2, test2)

# add column names
# this looks redundant to above section on column names
#name_list<-c('subject','activity', features[,2])
names(all_data)<-lbls

# save only mean and std_dev columns
all_data2<-all_data[,keep_list]

# calculate the average of each variable for each subject
tidy<-ddply(all_data2, .(subject, activity),colwise(mean))
write.csv(tidy, file='GCDATA/tidy.csv', row.names=F)

# if this worked tidy will be 180 rows by 81 columns
dim(tidy)
names(tidy)
