# Author: Hertta Lehvävirta 
# Date: 1.2.1017
# In this script I will modify my data for further analysis

# First I'll read provided data to a new table -variable:

learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = T)

# Next I'll study the dimensions and structure of the table:

dim(learning2014)
str(learning2014)

# The result is 184 rows and 60 columns. Every column in the table is a factor type vector.

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points 
# by combining questions in the learning2014 data:

library(dplyr)

deep <- c("D03","D11","D19","D27","D07","D14","D22","D30","D06","D15","D23","D31")

deepCol <- select(learning2014,one_of(deep))

learning2014$deep <- rowMeans(deepCol)

surf <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

surfCol <- select(learning2014,one_of(surf))

learning2014$surf <- rowMeans(surfCol)

stra <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

straCol <- select(learning2014,one_of(stra))

learning2014$stra <- rowMeans(straCol)

lrn <- select(learning2014, one_of("gender", "Age", "Attitude", "deep", "stra", "surf", "Points"))

# Exclude observations where the exam points variable is zero. (The data should then have 166 observations 
# and 7 variables)

lrn_filtered <- filter(lrn,learning2014$Points > 0)

# the result is 166 observations and 7 variables

# Set the working directory of you R session the iods project folder (study how to do this with RStudio). 
# Save the analysis dataset to the ‘data’ folder, using for example write.csv() or write.table() functions. 
# You can name the data set for example as learning2014(.txt or .csv). See ?write.csv for help or search the 
# web for pointers and examples. Demonstrate that you can also read the data again by using read.table() or 
# read.csv().  (Use `str()` and `head()` to make sure that the structure of the data is correct)

setwd("C:/Users/hertta.lehvavirta/Documents/Kouluhommia/IODSGit/IODS-project/data")
getwd()

write.table(lrn_filtered,"learn2014Data")

my_table <- read.table("learn2014Data")
str(my_table)

# data.frame':	166 obs. of  7 variables:
# $ gender  : Factor w/ 2 levels "F","M": 1 2 1 2 2 1 2 1 2 1 ...
# $ Age     : int  53 55 49 53 49 38 50 37 37 42 ...
# $ Attitude: int  37 31 25 35 37 38 35 29 38 21 ...
# $ deep    : num  3.58 2.92 3.5 3.5 3.67 ...
# $ stra    : num  3.38 2.75 3.62 3.12 3.62 ...
# $ surf    : num  2.58 3.17 2.25 2.25 2.83 ...
# $ Points  : int  25 12 24 10 22 21 21 31 24 26 ...

head(my_table)
