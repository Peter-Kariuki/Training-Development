###Class imbalance
data <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
# Understanding the structure of the data
str(data)
# change admit to factor
data$admit <- as.factor(data$admit)

# summary of the data
summary(data)

# visualize the admit variable
barplot(prop.table(table(data$admit)),
        col = rainbow(2),
        ylim = c(0,0.7),
        main = "Class Distribution")


### Data Partitioning 70:30 split
set.seed(111)
ind <- sample(2,nrow(data),replace = T,prob = c(0.7,0.3))
train <- data[ind==1,]
test <- data[ind==2,]

##DEveloping predictive models
prop.table(table(train$admit))

## Prediction model (Random Forest)
library(randomForest)
rftrain <- randomForest(admit~.,data = train)

## Model evaluation with test data
library(caret)
library(e1071)
confusionMatrix(predict(rftrain,test),test$admit, positive = "1")
##### poorly predicting class 1 due to the imbalace

## Oversampling for better sensitivty
library(ROSE)
over <- ovun.sample(admit~.,data = train,method = "over",N=386)$data
table(over$admit)
summary(over)

rfover <- randomForest(admit~.,data = over)
confusionMatrix(predict(rfover,test),test$admit,positive = "1")
 #### better sensitivity

### Undersampling
under <- ovun.sample(admit~.,data = train,method = "under",N=184)$data
table(under$admit)
summary(under)

rfunder <- randomForest(admit~.,data = under)
confusionMatrix(predict(rfunder,test),test$admit,positive = "1")


### Both Oversampling and Undersampling
both <- ovun.sample(admit~.,data = train,method = "both",p=0.5,seed = 111, N=285 )$data
table(under$admit)
summary(under)
rfboth <- randomForest(admit~.,data = both)
confusionMatrix(predict(rfunder,test),test$admit,positive = "1")
