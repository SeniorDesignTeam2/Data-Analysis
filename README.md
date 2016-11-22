# Data-Analysis
This is where initial finding formalized and matured.

R is used as our main analytics tool, different R-package is deployed
This zip file of code does not include full recursive code for tuning and go through the each iteration to generate best result. 
Tuning using grid search framework in R can be found below:

library(randomForest)
library(mlbench)
library(caret)

data=x

metric="Accuracy"
# Random Search
control <- trainControl(method="repeatedcv", number=10, repeats=3, search="random")
set.seed(seed)
mtry <- sqrt(ncol(x))
rf_random <- train(target variable~., data=dataset, method="rf", metric=metric, tuneLength=15, trControl=control) #tune length can be customizable
print(rf_random)
plot(rf_random)

# Grid Search
control <- trainControl(method="repeatedcv", number=10, repeats=3, search="grid")
set.seed(seed)
tunegrid <- expand.grid(.mtry=c(1:15))
rf_gridsearch <- train(target variable~., data=dataset, method="rf", metric=metric, tuneGrid=tunegrid, trControl=control) #tune grid can be customizable
print(rf_gridsearch)
plot(rf_gridsearch)

This hyperparameter optimization can not be done using local machine, it will need a 20 core machine and few hours of run time. 
Recursive script need to customized to specific type of analytics engine it is running.

comments are attached in each R file for use and clarification

Follow the following step to achieve similar result
1. Data prep - imputation
2. Data split in R
3. model run on train set
4. model evalution on test set. 
