#Install Packages
##install.packages("tidyverse",dep=T)
##install.packages("psych",dep=T)

#Load Packages
library(tidyverse)
library(psych)
library(haven)

#Load Data
raw_data <- read_sv(file="rawData.csv")

#View and Fix Data
View(raw_data)
raw_data <- read_csv(file="rawData.csv",na=c("","NA","-999","-888"))
View(raw_data)

#Labelling Data
categorical_variables <- select(raw_data, group, gender)
categorical_variables$group <- as.factor(categorical_variables$group)
categorical_variables$gender <- as.factor(categorical_variables$gender)
levels(categorical_variables$gender) <- list("Male"=1, "Female"=2)

#Creating Item Scales
affective_commitment_items <- select (raw_data, AC1, AC2, AC3, AC4, AC5)
agreeableness_items <- select (raw_data, A1, A2, A3, A4, A5)
extroversion_items <- select (raw_data, E1, E2, E3, E4, E5)

#Descriptive Analysis
psych::describe(extroversion_items)
psych::describe(agreeableness_items)

#Fixing Bad Values
agreeableness_items 
is_bad_value <- agreeableness_items<1 | agreeableness_items>5
agreeableness_items[is_bad_value] <- NA

#Fixing Inverted Items
Agreeableness_items <- mutate(agreeableness_items, A5=6-A5)
