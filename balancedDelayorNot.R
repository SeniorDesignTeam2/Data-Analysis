library(randomForest)
library(mlbench)
library(caret)
library(pROC)
library(unbalanced)

data <- read.csv("D:/Imputed_Full_Data_2.0.csv",header=TRUE)
n= ncol(data)
output=factor (data$PI.Delay.Binary2)
input=data[1:33]
data<-ubBalance(X= input, Y=output, type="ubSMOTE", percOver=300, percUnder=150, verbose=TRUE)
#iterate throught different value from <50% and value choose base on cross validate with method below choose highest AUC, sensitivity and specfic
#try 260,160 to get less sample data size

balancedData<-cbind(data$X,data$Y)
colnames(balancedData)[34]="Delay.or.Not"

dt = sort(sample(nrow(balancedData),nrow(balancedData)*0.8))
train = balancedData[dt,]
test = balancedData[-dt,]
# load the package
library(CORElearn)
cat(versionCore(),"\n")
# load data

# build random forests model with certain parameters
# setting maxThreads to 0 or more than 1 forces utilization of several processor cores
modelRF <- CoreModel(Delay.or.Not~ TRIAL.PHASE+NUMBER.OF.SITES+NUMBER.OF.COUNTRIES+NUMBER.OF.SUBJECTS+PROJECT.STATUS.CODE+PROJECT.FUNDING.CODE
                     +RESPONSIBLE.UNIT.CODE+PROJECT.TYPE.CODE+PROJECT.SUBTYPE.CODE+PROJECT.PHASE.CODE+DEVELOPMENT.CATEGORY.CODE+DISEASE.AREA.SUBCATEGORY.CODE
                     +STRATEGIC.PRIORITY.CODE+IDP.PTRS+PRODUCT.TYPE.CODE+PRODUCT.TYPE.SUBCATEGORY.CODE, train, model="rf",
                     selectionEstimator="InfGain",minNodeWeightRF=10,
                     rfNoTrees=1000, maxThreads=10)
print(modelRF) # simple visualization, test also others with function plot

pred <- predict(modelRF, test, type="both") # prediction on testing set
print (pred)
#evaluating model
modelEval(model = modelRF, correctClass = test$Delay.or.Not, predictedClass = pred$class)
require(ExplainPrediction)


#not run this yet... take couple hours to generate a graph... dont think worth it.
explainVis(modelRF, train, test, method="EXPLAIN",visLevel="model",
           problemName="data", fileType="none", classValue=1, displayColor="color") 