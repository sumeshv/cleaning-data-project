# cleaning-data-project
Course project for Getting and Cleaning Data

The downloaded files from the url http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones needs to be extracted in the work directory without changing the folder structures or file names. It will look like the one mentioned below assuming the work directory is <b>"D:\Coursera"</b>, after extracting the zip file the structure would be  "D:\Coursera\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset\" follwed by as set of sub-folders and *.txt files

Save the file <b>run_analysis.R</b> in the work directory and execute the function " <b>tidy_data(file_path)</b> " which will return the final tidy data set. File path is the root directory where the downloaded data is available. Continuing with the above example it will be like  <b>summarized_tidy_data <- tidy_data(<i>"getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"</i>)</b>.
The final output will be written to a file by name <b>tidy_output.txt</b> in the work directory. 
