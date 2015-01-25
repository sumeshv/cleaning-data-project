##################################################################################
#
#This file will have functions to perfrom the following list of
#activities on the Samsung Data files(data path=<wd>./UCI HAR Dataset/*):
#
#1.Merges the subject_*.txt,x_*.txt & y_*.txt files to one data set
#in order to have the subject and activites in a single data set
#2.Processses the test and train files to have summarized data
#3.Returns the average for the individual measurements.
#

#This function will be responsible for co-ordinating the process of 
#cleaning up data from multiple files and returning the final summary
#data.This accepts the root dir of data source location and the rest of
#the files will be extracted from the sub-folders. The pre-reqisite
#is to have all the data files as per the downloaded struture. 
#eg:Assuming the work directory (getwd()) to be as "d:/Coursera" the 
#downloaded files needs to be have the folder structure of
#D:\Coursera\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\
#The structure is simillar to what you get when you unzip the downloaded
#file. Function call as per the above eg will be
#
#  data<-tidy_data("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
#
# The output file will be available under work directory by name tidy_output.tx
#
###################################################################################


tidy_data<-function(data_file_dir){
  
  library(plyr)
  library(dplyr)
  library(tidyr)
  
  #Mapping activity codes to the description. This will be used while providing names
  #to each activity code in the data set. This could have been done by reading from
  #the downloaded file as well.
 
  activity.code <- c(WALKING=1, WALKING_UPSTAIRS=2, WALKING_DOWNSTAIRS=3, SITTING=4,  STANDING=5,LAYING=6)
   
  #A function "tidy_subset(...)" is written which will be re-used for parsing test 
  #and train files  
 
  #Reading the downloaded test files.
  test_data<-tidy_subset(data_file_dir,"Test",activity.code)
  test_rows <- nrow(test_data)
  message("Total test_rows:",test_rows)
  #Reading the training files
  train_data<-tidy_subset(data_file_dir,"Training",activity.code)
  train_rows <- nrow(train_data)
  message("Total train_rows:",train_rows)
  
  ################################################################################
  # 1. Merges the training and the test sets to create one data set.
  ################################################################################ 
  merged_data <- rbind(test_data,train_data)
  message("Merging both the test and train file- completed.")

  ################################################################################
  # 2. Extracts only the measurements on the mean and standard deviation for each 
  #    measurement. 
  ################################################################################ 
  
  #Read the list of features provided in the features.txt file. Use the values 
  #in this file to assign the columns names for the data set
  features <- read.table("./data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt",header=F)

  colnames(merged_data) <- c("User","Activity_Code","Activity_Description",as.character(features[,2]))
  
  #Selecting the column names containing user,activity,mean and Std values
  req_columns <- grepl("User|Activity_Code|Activity_Description|-mean\\(\\)|-std\\(\\)",colnames(merged_data))   
  merged_data <- merged_data[req_columns]
  
  ################################################################################
  # 3. Uses descriptive activity names to name the activities in the data set
  ################################################################################ 
  
  #Done as part of setp 1 inside tidy_subset(...) function
  
  
  ################################################################################
  # 4. Appropriately labels the data set with descriptive variable names. 
  ################################################################################ 
  
  #List of descriptive column names which will be used to rename the existing
  #column name. A better way would have been by using regular expressions but 
  #due to time constraints going with a crude approach.
  
  col_names<- c(
                "t.Body.Acc_Mean_X","t.Body.Acc_Mean_Y","t.Body.Acc_Mean_Z",
                "t.Body.Acc_SD_X","t.Body.Acc_SD_Y","t.Body.Acc_SD_Z",
                "t.Gravity.Acc_Mean_X","t.Gravity.Acc_Mean_Y","t.Gravity.Acc_Mean_Z",
                "t.Gravity.Acc_SD_X","t.Gravity.Acc_SD_Y","t.Gravity.Acc_SD_Z",
                "t.Body.Acc.Jerk_Mean_X","t.Body.Acc.Jerk_Mean_Y","t.Body.Acc.Jerk_Mean_Z",
                "t.Body.Acc.Jerk_SD_X","t.Body.Acc.Jerk_SD_Y","t.Body.Acc.Jerk_SD_Z",
                "t.Body.Gyro_Mean_X","t.Body.Gyro_Mean_Y","t.Body.Gyro_Mean_Z",
                "t.Body.Gyro_SD_X","t.Body.Gyro_SD_Y","t.Body.Gyro_SD_Z",
                "t.Body.Gyro.Jerk_Mean_X","t.Body.Gyro.Jerk_Mean_Y","t.Body.Gyro.Jerk_Mean_Z",
                "t.Body.Gyro.Jerk_SD_X","t.Body.Gyro.Jerk_SD_Y","t.Body.Gyro.Jerk_SD_Z",
                "t.Body.Acc.Mag_Mean","t.Body.Acc.Mag_SD","t.Gravity.Acc.Mag_Mean",
                "t.Gravity.Acc.Mag_SD","t.Body.Acc.Jerk.Mag_Mean","t.Body.Acc.Jerk.Mag_SD",
                "t.Body.Gyro.Mag_Mean","t.Body.Gyro.Mag_SD","t.Body.Gyro.Jerk.Mag_Mean",
                "t.Body.Gyro.Jerk.Mag_SD","f.Body.Acc_Mean_X","f.Body.Acc_Mean_Y",
                "f.Body.Acc_Mean_Z","f.Body.Acc_SD_X","f.Body.Acc_SD_Y","f.Body.Acc_SD_Z",
                "f.Body.Acc.Jerk_Mean_X","f.Body.Acc.Jerk_Mean_Y","f.Body.Acc.Jerk_Mean_Z",
                "f.Body.Acc.Jerk_SD_X","f.Body.Acc.Jerk_SD_Y","f.Body.Acc.Jerk_SD_Z",
                "f.Body.Gyro_Mean_X","f.Body.Gyro_Mean_Y","f.Body.Gyro_Mean_Z","f.Body.Gyro_SD_X",
                "f.Body.Gyro_SD_Y","f.Body.Gyro_SD_Z", "f.Body.Acc.Mag_Mean","f.Body.Acc.Mag_SD", 
                "f.Body.Body.Acc.Jerk.Mag_Mean","f.Body.Body.Acc.Jerk.Mag_SD", "f.Body.Body.Gyro.Mag_Mean", 
                "f.Body.Body.Gyro.Mag_SD", "f.Body.Body.Gyro.Jerk.Mag_Mean", "f.Body.Body.Gyro.Jerk.Mag_SD"
                )
  
  #Setting the new column names as per the above list
  colnames(merged_data) <- c("User","Activity_Code","Activity_Description",col_names)
  message("Assigning variable names completed.")
  
  
  ################################################################################
  # 5. From the data set in step 4, creates a second, independent tidy data set 
  #    with the average of each variable for each activity and each subject. 
  ################################################################################ 
  
  
  #Grouping based on Activity and Subject to calculate average of all the measurements  
  summarized_tidy_data<-ddply(merged_data,.(User,Activity_Code,Activity_Description),.fun=function(x) {colMeans(x[,4:69])}) 
  
  write.table(summarized_tidy_data,file="./tidy_output.txt",row.name=FALSE,sep=",")
  message("Writing the tidy data set to ./tidy_output.txt file completed.")
  
  
  #When I notice the above data set it doesn't looks tidy. There are many variables
  #which could have been split into separate columns names like domain, axis,Mean,SD
  #and the individual observation can have values for these. I am leaving this now due
  #to time constraints.
  
  
  return(summarized_tidy_data)    
}


# Method written to re-use the same logic for processing test and 
# train files. This functions return a data set after combining
# activity, subject and X_* files for both test & train

tidy_subset <- function(file_dir, type="Test",activity.code){
  #work directorty, starting point of data files
  wd<-getwd()
  data_x<-data.frame()
  data_user<-data.frame()
  data_activity<-data.frame()
  test_file_dir<- paste(wd,file_dir,"test",sep="/")
  train_file_dir<- paste(wd,file_dir,"train",sep="/")
  #if the training data needs to be processed
  if(identical(type,"Training")){
    #look for training data
    data_x<-read.table(paste(train_file_dir,"X_train.txt",sep="/"),header=F)
    data_activity<-read.table(paste(train_file_dir,"y_train.txt",sep="/"),header=F)
    data_user<-read.table(paste(train_file_dir,"subject_train.txt",sep="/"),header=F)
  }else{
    #look for test data
    data_x<-read.table(paste(test_file_dir,"X_test.txt",sep="/"),header=F)
    data_activity<-read.table(paste(test_file_dir,"y_test.txt",sep="/"),header=F)
    data_user<-read.table(paste(test_file_dir,"subject_test.txt",sep="/"),header=F)
  }
  
  #Assigning the activity name for each code
  colnames(data_activity)=c("Activity_Code")
  data_activity$Activity_Description <- names(activity.code)[match(data_activity$Activity_Code, activity.code)]
  
  combined_data <- cbind(data_user,data_activity,data_x)
  return(combined_data)                   
}
