Inputation_Data_1.0 <- read.csv("//prism.nas.gatech.edu/wberry6/vlab/desktop/Inputation_Data_1.0.csv")
Attach(Inputation_Data_1.0)
library(mice)

Inputed_data = mice(Inputation_Data_1.0, m=1, method = "pmm")
CompleteData = complete(Inputed_data,1)
