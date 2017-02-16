#Read the Human Development - and Gender Inequality -datasets into RStudio
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Check the dimensions and the structure of both datasets
dim(hd)
str(hd)
dim(gii)
str(gii)

#We can see that both datasets have 195 observations. Human Development -dataset 
#has 8 variables and Gender Inequality -dataset has 10.Human Development -data has
#mostly numeric or integer variables (HDI Rank, Human Development Index, 
#Life expectancy at Birth, Expected years of education, Mean years of education,
#GNI per capita rank minus HDI rank) and two character variables, Country and 
#Gross National Income, although I am not sure why the latter one is characteristic. 
#Maybe it is because of the commas?
#Gender Inequality data has also mostly numeric or integer variables
#(GII rank, Gender inequality index, maternal mortality ratio,
#adolescent birth rate, representation in parliament in percents,
#population with secondary education female, population with secondary education male,
#labour force participation female, labour force participation male) and one 
#character variable, country.

#Create summaries of both data
summary(hd)
summary(gii)

#Rename the variables with shorter descriptive names
names(hd) <- c("HDIr", "cntr","HDI","LEatB","EYE","meanYE","GNI","GNIrmHDIr")
names(gii) <- c("GIIr", "cntr","GII","MatMort","AdBirthr","RepParl","Pop2edF","Pop2edM","LFPRF","LFPRM")

##Create 2 new variables. 
#The ratio of females and males population of secondary education
gii$Pop2edR<-gii$Pop2edF/gii$Pop2edM

#The ratio of females and males labour force participation
gii$LFPRMR<-gii$LFPRF/gii$LFPRM
