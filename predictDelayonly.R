#raw dataset (without dataset balancing)

library(randomForest)
library(mlbench)
library(caret)
library(pROC)

data <- read.csv("D:/Imputed_Full_Data_delayonly.csv",header=TRUE)
dt = sort(sample(nrow(data),nrow(data)*0.8))
train = data[dt,]
test = data[-dt,]

# load the package
library(CORElearn)
cat(versionCore(),"\n")
# load data

# build random forests model with certain parameters
# setting maxThreads to 0 or more than 1 forces utilization of several processor cores
modelRF <- CoreModel(PI.Delay.Cat~ TRIAL.PHASE+NUMBER.OF.SITES+NUMBER.OF.COUNTRIES+NUMBER.OF.SUBJECTS+PROJECT.STATUS.CODE+PROJECT.FUNDING.CODE
                     +RESPONSIBLE.UNIT.CODE+PROJECT.TYPE.CODE+PROJECT.SUBTYPE.CODE+PROJECT.PHASE.CODE+DEVELOPMENT.CATEGORY.CODE+DISEASE.AREA.SUBCATEGORY.CODE
                     +STRATEGIC.PRIORITY.CODE+IDP.PTRS+PRODUCT.TYPE.CODE+PRODUCT.TYPE.SUBCATEGORY.CODE, train, model="rf",
                     selectionEstimator="InfGain",minNodeWeightRF=6,
                     rfNoTrees=2000, maxThreads=10)
print(modelRF) # simple visualization, test also others with function plot

pred <- predict(modelRF, test, type="both") # prediction on testing set
print (pred)
#evaluating model
modelEval(model = modelRF, correctClass = test$PI.Delay.Cat, predictedClass = pred$class)