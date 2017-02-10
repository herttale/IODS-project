# Hertta Lehvavirta 7.2.2017
# in this script I will modiy a dataset from <https://archive.ics.uci.edu/ml/machine-learning-databases/00356/> for further analysis

# 1. Read both student-mat.csv and student-por.csv into R (from the data folder) and explore the structure and dimensions of the data. 
getwd()
setwd("C:/Users/hertta.lehvavirta/Documents/Kouluhommia/IODSGit/IODS-project/data")

Math = read.csv2(file = "student-mat.csv" )
Portug = read.csv2(file = "student-por.csv" )

dim(Math)
dim(Portug)

str(Math)
str(Portug)

library(dplyr)

joinCol <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
mptable <- inner_join(Math, Portug, by = joinCol, suffix = c(".math",".por"))

str(mptable)
dim(mptable)

mpfinal <- select(mptable, one_of(joinCol))

notjoined_columns <- colnames(Math)[!colnames(Math) %in% joinCol]


notjoined_columns

for(column_name in notjoined_columns) {
 
  two_columns <- select(mptable, starts_with(column_name))
  
  first_column <- select(two_columns, 1)[[1]]
  
  
  if(is.numeric(first_column)) {
    mpfinal[column_name] <- round(rowMeans(two_columns))
  } else {
    mpfinal[column_name] <- first_column
  }
}


glimpse(mpfinal)


mpfinal <- mutate(mpfinal, alc_use = (Dalc + Walc) / 2)
mpfinal <- mutate(mpfinal, high_use = alc_use > 2)

glimpse(mpfinal)

write.table(x = mpfinal,file = "students_alc")



