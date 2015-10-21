install.packages('e1071', dependencies = TRUE)
library('e1071')
library('rpart')

data <- read.table("matrix.csv", header=FALSE, sep=" ")

#NB <- naiveBayes(class ~ , data = data)
#summary(NB)

#prediction <- predict(NB, data)
