# load the package
library(CORElearn)
cat(versionCore(),"\n")
# load data
data <- read.csv("D:/Imputed_Full_Data_2.0.csv",header=TRUE)
dt = sort(sample(nrow(data),nrow(data)*0.8))
trainIdxs = data[dt,]
testIdxs = data[-dt,]
# build random forests model with certain parameters
# setting maxThreads to 0 or more than 1 forces utilization of several processor cores
modelRF <- CoreModel(PI.Delay.Cat~ TRIAL.PHASE+NUMBER.OF.SITES+NUMBER.OF.COUNTRIES+NUMBER.OF.SUBJECTS+PROJECT.STATUS.CODE+PROJECT.FUNDING.CODE+RESPONSIBLE.UNIT.CODE+PROJECT.TYPE.CODE+PROJECT.SUBTYPE.CODE+PROJECT.PHASE.CODE+DEVELOPMENT.CATEGORY.CODE+DISEASE.AREA.SUBCATEGORY.CODE+STRATEGIC.PRIORITY.CODE+IDP.PTRS+PRODUCT.TYPE.CODE+PRODUCT.TYPE.SUBCATEGORY.CODE, trainIdxs, model="rf",
                     selectionEstimator="MDL",minNodeWeightRF=5,
                     rfNoTrees=1000, maxThreads=4)
print(modelRF) # simple visualization, test also others with function plot

pred <- predict(modelRF, testIdxs, type="both") # prediction on testing set
print (pred)
