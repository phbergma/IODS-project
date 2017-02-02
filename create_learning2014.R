##Read the dataset in R
learning2014<-read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",header=T)

##Check the dimensions of the dataset
dim(learning2014)
##We can see that the dataset has 183 rows and 60 columns

##Check the structure of the dataset
str(learning2014)
##We can see that all variables except for gender are integer, so they have
##numeric values. Gender is a factor variable that has two levels, M and F for 
##male and female

##Select the questions related to deep, surface and strategic learning
##as instructed in DataCamp
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

##Access the dplyr-library
##install.packages("dplyr")
library(dplyr)

##Take the average of these theme questions to combine them into one variable
##(one variable for each theme)
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra<-rowMeans(strategic_columns)

##Create column 'attitude' by scaling the column "Attitude"
learning2014$attitude <- learning2014$Attitude/10

##Choose the necessary columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

##Select the 'keep_columns' to create a new dataset
lrn2014 <- select(learning2014, one_of(keep_columns))

##Check which variables are in the new data
colnames(lrn2014)

##Change the name of the second column
colnames(lrn2014)[2] <- "age"

##Change the name of "Points" to "points"
colnames(lrn2014)[7]<-"points"

##Exclude the observations where points<=0
learning14<-subset(lrn2014,points>0)

##The data has now 166 observations and 7 variables as was in the instructions
##so Yayy!!

##Set working direcory to the IODS-project folder
setwd("C:/Users/Paula/Documents/GitHub/IODS-project")

##Save the dataset in the data-folder in the IODS-project folder
setwd("C:/Users/Paula/Documents/GitHub/IODS-project/data")
write.csv(learning14,"learning2014.csv",row.names=F)

##Read the data into R again to demonstrate that the dataset creation was successful
learning2014<-read.table("learning2014.csv",header=T,sep=",")
str(learning2014)


