#Install Packages
##install.packages("tidyverse",dep=T)
##install.packages("psych",dep=T)

#Load Packages
library(tidyverse)
library(psych)
library(haven)

#Load Data
raw_data <- read_csv(file="rawData.csv")

#View and Fix Data
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
#psych::describe(extroversion_items)
#psych::describe(agreeableness_items)

#Fixing Bad Values
is_bad_value <- agreeableness_items<1 | agreeableness_items>5
agreeableness_items[is_bad_value] <- NA
is_bad_value <- affective_commitment<1 | affective_commitment>7
affective_commitment_items[is_bad_value] <- NA

#Fixing Inverted Items
agreeableness_items <- mutate(agreeableness_items, A5=6-A5)
affective_commitment_items <- mutate(affective_commitment_items, AC4=8-AC4)
affective_commitment_items <- mutate(affective_commitment_items, AC5=8-AC5)

#Obtaining Scale Scores
agreeableness <- psych::alpha(as.data.frame(agreeableness_items), check.keys=FALSE)$scores
extroversion <- psych::alpha(as.data.frame(extroversion_items), check.keys=FALSE)$scores
affective_commitment <- psych::alpha(as.data.frame(affective_commitment_items), check.keys=FALSE)$scores

#Combine into analytic_data
analytic_data <- cbind(categorical_variables, agreeableness, extroversion, affective_commitment)

#Saving .RData, CSV, .SAV 
save(analytic_data,file="study1_analytic_data.RData")
write_csv(analytic_data,path="study1_analytic_data.csv")
##library(haven)
##write_sav(analytic_data,path="study1_analytic_data.sav")
