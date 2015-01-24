# cleaning-data-project
Course project for Getting and Cleaning Data

Pre-requisete is to install dplyr and tidyr libraries. The downloaded files from the url http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones needs to be extracted in the work directory without changing the folder structures or file names. It will look like the one mentioned below assuming the work directory is <b>"D:\Coursera"</b>, after extracting the zip file the structure would be  "D:\Coursera\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\" follwed by as set of sub-folders and *.txt files

Save the file run_analysis.R in the work directory and execute the function " tidy_data(file_path) " which will return the final tidy data set. File path is the root directory where the downloaded data is available. Continuing with the above example it will be like  summarized_tidy_data <- tidy_data("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset").
The final output can be written to a file using write.table(summarized_tidy_data,file="D:/Coursera/data/avg_output.txt",row.name=FALSE,sep=",")

