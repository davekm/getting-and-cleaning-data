getting-and-cleaning-data
=========================

pulled mean and std dev fields using grepl on column names in features file

since data frames had same columns just used rbind to merge the two into all_data

used ddply, part of plyr package, to calculate means then saved tidy dataset to tidy.csv
