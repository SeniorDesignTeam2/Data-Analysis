library(randomForest)
library(mlbench)
library(caret)

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

tree = randomForest(Delay.or.Not~TRIAL.PHASE+NUMBER.OF.SITES+NUMBER.OF.COUNTRIES+NUMBER.OF.SUBJECTS+PROJECT.STATUS.CODE+PROJECT.FUNDING.CODE+RESPONSIBLE.UNIT.CODE
                    +PROJECT.TYPE.CODE+PROJECT.SUBTYPE.CODE+PROJECT.PHASE.CODE+DEVELOPMENT.CATEGORY.CODE+DISEASE.AREA.SUBCATEGORY.CODE+STRATEGIC.PRIORITY.CODE+IDP.PTRS
                    +PRODUCT.TYPE.CODE+PRODUCT.TYPE.SUBCATEGORY.CODE+Dosage.Form.Description,ntree=2000,data=train)
print(tree)
importance(tree)