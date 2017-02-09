#################
#Paula Bergman
#7.2.2017
#Data wrangling to create the alcohol consumption dataset
#Data downloaded from the website 
#https://archive.ics.uci.edu/ml/machine-learning-databases/00356/

#Set the working directory
setwd("C:/Users/Paula/Documents/GitHub/IODS-project/data")

#Read the datasets into RStudio
mat<-read.table("student-mat.csv",header=T,sep=";")
por<-read.table("student-por.csv",header=T,sep=";")

#Check the dimensions and the structure of the datasets
dim(mat)
str(mat)
#We can see that the mat-data  consists of 395 observations and 33 variables, 
#17 of which are of type factor and the rest integer.
dim(por)
str(por)
#We can see that the por-data consists of 649 observations and 33 variables, 
#which are exactly the same than in the mat-data.

#Access the dplyr library
library(dplyr)

#Join the datasets by using the variables "school", "sex", "age", "address", 
#"famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery",
#"internet" as (student) identifiers. This way only the students present in 
#both datasets will be included in the data
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu",
             "Mjob","Fjob","reason","nursery","internet")
mat_por <- inner_join(mat, por, by = join_by)
mat_por<-inner_join(mat,por,by=join_by,suffix=c(".mat",".por"))

dim(mat_por)
str(mat_por)
#Now the dataset has 382 observations and 53 variables. Those variables that I 
#used for joining, are there only once but for the rest of the variables there are
#two of each, separated with the endings .mat and .por

#Create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

#The columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

#For every column name not used for joining...
for(column_name in notjoined_columns) {
  #select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  #select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  #if that first column vector is numeric...
  if(is.numeric(first_column)) {
    #take a rounded average of each row of the two columns and
    #add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    #add the first column vector to the alc data frame
    alc[column_name] <- select(two_columns, 1)[[1]]
  }
}

#Create an alcohol consumption variable alc_use to the joined data by 
#taking the average of alcohol consumption variables in the data. 
#Those are Dalc = Daily alcohol consumption and Walc = Weekly alcohol consumption
alc$alc_use<-(alc$Dalc+alc$Walc)/2

#Create a variable high_use to the joined data to describe whether the student
#uses alcohol a high amount or not
alc$high_use<-ifelse(alc$alc_use>2,TRUE,FALSE)

#Glimpse at the joined and modified data to make sure everything is in order
glimpse(alc)

#It seems that everything is in the order: There are 382 observations and
#35 variables as it is supposed to be.

#Save the joined dataset into the data-folder in csv-form. Since the working
#directory is already set into that folder, it doesn't have to be referenced 
#anymore.
write.csv(alc,"alc.csv",row.names=F)
