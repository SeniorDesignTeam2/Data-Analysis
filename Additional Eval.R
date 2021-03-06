# load the package
library(CORElearn)
cat(versionCore(),"\n")
# load data
data <- read.csv("D:/Imputed_Full_Data_2.0.csv",header=TRUE)
dt = sort(sample(nrow(data),nrow(data)*0.8))
trainIdxs = data[dt,]
testIdxs = data[-dt,]

attriEval=attrEval(PI.Delay.Cat~TRIAL.PHASE+NUMBER.OF.SITES+NUMBER.OF.COUNTRIES+NUMBER.OF.SUBJECTS+PROJECT.STATUS.CODE+PROJECT.FUNDING.CODE+RESPONSIBLE.UNIT.CODE
                   +PROJECT.TYPE.CODE+PROJECT.SUBTYPE.CODE+PROJECT.PHASE.CODE+DEVELOPMENT.CATEGORY.CODE+DISEASE.AREA.SUBCATEGORY.CODE+STRATEGIC.PRIORITY.CODE+IDP.PTRS
                   +PRODUCT.TYPE.CODE+PRODUCT.TYPE.SUBCATEGORY.CODE+Dosage.Form.Description, data, estimator="InfGain", costMatrix = NULL, outputNumericSplits=FALSE)
infoCore(what = "attrEval")
print (attriEval)