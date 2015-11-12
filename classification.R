#install.packages('e1071', dependencies = TRUE)
library('e1071')
library('rpart')

train <- read.table("matrix.csv", header=FALSE, sep=" ")
test <- read.table("matrixTest.csv", header=FALSE, sep=" ")

#n <- nrow(train)

svmclass <- svm(train[,6714] ~ . , data = train, kernel = "linear")
prediction <- predict(svmclass, test)
n <- length(prediction)
result <- vector(length = n)
for (i in 1:n)
{
  result[i] = levels(factor(prediction[[i]]))
}
write(result, file = "predTest.csv", ncolumns = 1)
