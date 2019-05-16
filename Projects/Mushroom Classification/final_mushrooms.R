#packages
library(ggplot2)
library(caret)
library(randomForest)
library(e1071)
library(arules)
library(arulesViz)
library(rminer)
library(kernlab)
library(klaR)
library(cba)

#import data
mushrooms <- read.csv("~/Syracuse - Grad School/IST 565 - Data Mining/mushrooms-data.csv")

#explore
str(mushrooms)
summary(mushrooms)
View(head(mushrooms))

#check for null values
table(is.na(mushrooms))

#plot exploration
for (i in 1:23) {
  plot(mushrooms[ ,i], main=colnames(mushrooms)[i],
       ylab = "Count", col="darkolivegreen3", las = 0)
}

#all mushrooms are classified as either edible (e) or poisonous (p)
#our goal is to determine if we can classify mushrooms as e/p based on their given attributes

#how many mushrooms are poisonous vs edible?
table(mushrooms$class)
edible.percent <- round(sum(mushrooms$class=='e')/(sum(mushrooms$class=='e')+sum(mushrooms$class=='p')), 4)*100
poison.percent <- 1 - edible.percent
cat("Percent of edible class:", edible.percent,"%")
cat("Percent of poisonous class:", poison.percent, "%")

#convert factors to numeric for analysis
mushrooms_data <- mushrooms[,2:23]
mushrooms_class <- mushrooms[,1]
mushrooms_data <- sapply(mushrooms_data, function(x) as.numeric(as.factor(x)))
mushrooms_new <- data.frame(class = mushrooms_class, mushrooms_data)

#veil.type removed because of zero variance, shown from the distribution plots
mushrooms_new$veil.type <- NULL

#split data into training 70% and testing 30%
set.seed(0)
sample <- sample(2, nrow(mushrooms_new), replace = TRUE, prob = c(0.7, 0.3))
training <- mushrooms_new[sample == 1,]
testing <- mushrooms_new[sample == 2,]

#extract correct class from testing set
testing_class <- testing[,1]
  
#remove classes from testing for modeling
testing_noclass <-testing[,2:22]

#check data sets
dim(training)
dim(testing)

#naive bayes model
nb_model <- naiveBayes(class ~ ., data = training, laplace = 1)
nb_class <- predict(nb_model, newdata = testing_noclass)

#accuracy compared to original labels
confusionMatrix(testing_class, nb_class)

#random forest with 100 trees
rndf_model <- randomForest(class ~ ., data = training, ntree = 100, importance = TRUE)
rndf_class <- predict(rndf_model, newdata = testing_noclass)

#view variable importance - #1 Odor, #2 stalk root, #3 sp
rndf_imp <- varImpPlot(rndf_model, main = "Variable Importance Plot - Random Forest")
rndf_imp

#accuracy compared to original labels
confusionMatrix(testing_class, rndf_class)
