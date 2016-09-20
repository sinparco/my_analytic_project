#Run Libray
library(haven)

#Run Data
my.spss.data.complete <- read_spss("dataComplete.sav")

#View SPSS data
str(my.spss.data.complete)

#Change Format
my.spss.data.complete$group <- as_factor(my.spss.data.complete$group)
