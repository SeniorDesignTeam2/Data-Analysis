library(randomForest)
library(mlbench)
library(caret)

data <- read.csv("D:/Imputed_Full_Data_2.0.csv",header=TRUE)
dt = sort(sample(nrow(data),nrow(data)*0.8))
train = data[dt,]
test = data[-dt,]
tree = randomForest(PI.Delay.Cat~TRIAL.PHASE+NUMBER.OF.SITES+NUMBER.OF.COUNTRIES+NUMBER.OF.SUBJECTS+PROJECT.STATUS.CODE+PROJECT.FUNDING.CODE+RESPONSIBLE.UNIT.CODE
                    +PROJECT.TYPE.CODE+PROJECT.SUBTYPE.CODE+PROJECT.PHASE.CODE+DEVELOPMENT.CATEGORY.CODE+DISEASE.AREA.SUBCATEGORY.CODE+STRATEGIC.PRIORITY.CODE+IDP.PTRS
                    +PRODUCT.TYPE.CODE+PRODUCT.TYPE.SUBCATEGORY.CODE+Dosage.Form.Description,ntree=1000,data=train)
print(tree)
importance(tree)