data=read.csv("C:/Users/Manjunath/Desktop/DS_Mrinal/Assignment/Assignment/MBA Starting Salaries Data.csv",header = T)
names(data)
head(data)
str(data)

library(ggplot2)
library(corrgram)
library(tidyr)
library(dplyr)

dataset=subset(data,data$salary!=999 & data$salary!=998)

qqnorm(dataset$age, pch = 1, frame = FALSE)
qqline(dataset$age, col = "steelblue", lwd = 2)

qqnorm(dataset$salary, pch = 1, frame = FALSE)
qqline(dataset$salary, col = "steelblue", lwd = 2)

par(mfrow=c(2, 2))  # divide graph area in 2 columns
boxplot(dataset$age, main="Age", sub=paste("Outlier rows: ", boxplot.stats(dataset$age)$out))  
boxplot(dataset$gmat_qpc, main="GMAT_Quant", sub=paste("Outlier rows: ", boxplot.stats(dataset$gmat_qpc)$out))  
boxplot(dataset$work_yrs, main="work_yrs", sub=paste("Outlier rows: ", boxplot.stats(dataset$work_yrs)$out))  

par(mfrow=c(2, 2))
scatter.smooth(x=dataset$age, y=dataset$salary, col="blue",ylim=c(0, 250000), xlim=c(20, 50), 
               main=" Age & Salary", ylab="Salary", xlab="Age (Yrs)")
scatter.smooth(x=dataset$gmat_tot, y=dataset$salary,col="red", main="GMAT Score ~ Salary") 
scatter.smooth(x=dataset$work_yrs, y=dataset$salary,col="green", main="Work Exp ~ Salary") 

library(e1071)
par(mfrow=c(1, 2))  # divide graph area in 2 columns
plot(density(dataset$age), main="Density Plot: Age", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(dataset$age), 2)))  # density plot for 'age'
polygon(density(dataset$age), col="red")

plot(density(dataset$gmat_qpc), main="Density Plot", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(dataset$gmat_qpc), 2)))  # density plot for 'gmat quants'
polygon(density(dataset$gmat_qpc), col="red")

plot(density(dataset$salary), main="Density Plot", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(dataset$salary), 2)))  # density plot for 'salary'
polygon(density(dataset$salary), col="red")


library(corrplot)
corrplot(cor(dataset))
cor(dataset$salary, dataset$age)
cor(dataset$salary, dataset$gmat_qpc)

dataset2=subset(dataset, !(dataset$salary %in% c(0, 998, 999)))

t.test(dataset2$gmat_tot, dataset2$gmat_qpc)

model1= lm(salary ~ age+gmat_tot+work_yrs, data=dataset2)

modelSummary = summary(model1)  
modelSummary 
modelCoeffs = model1$coefficients

set.seed(100)
trainingRowIndex = sample(1:nrow(dataset2), 0.8*nrow(dataset2))  # row indices for training data
trainingData = dataset2[trainingRowIndex, ]  # model training data
testData  = dataset2[-trainingRowIndex, ]   # test data

lmMod = lm(salary ~ age+gmat_tot+work_yrs, data=trainingData)  # build the model
Pred = predict(lmMod, testData)  # predict distance
summary (lmMod)  # model summary

actuals_preds = data.frame(cbind(actuals=testData$salary, predicteds=Pred))  # make actuals_predicteds dataframe.
correlation_accuracy = cor(actuals_preds)  
head(actuals_preds)

# accuracy test

min_max_accuracy = mean(apply(actuals_preds, 1, min) / apply(actuals_preds, 1, max))  
min_max_accuracy
mape = mean(abs((actuals_preds$predicteds - actuals_preds$actuals))/actuals_preds$actuals)
mape

