#скрипт для создания гистограммы по количеству рецептов из каждой кухни
library("rjson")
#данные
json_file <- "train.json"
train_data <- fromJSON(file=json_file, method='C')
count_recipes <- length(train_data)

#ассоциативный массив для подсчета кол-ва рецептов одной кухни
map_cuisines <- new.env(hash = T, parent = emptyenv()) 
name_cuisines <- vector(length = 20)
j <- 1
for (i in 1:count_recipes)
{
  cuisine <- train_data[i][[1]]$cuisine
  if (is.null(map_cuisines[[cuisine]]))
  {
    map_cuisines[[cuisine]] = 1
    name_cuisines[j] <- cuisine
    j<-j+1
  }
  else
  {
    map_cuisines[[cuisine]] <- map_cuisines[[cuisine]] + 1
  }
}

#записываем значения в вектор для отрисовки
count_cuisines <- length(map_cuisines)
plot_vector <- rep(0, count_cuisines) 
cuisines <- as.list(map_cuisines)
for (i in 1:count_cuisines)
{
  plot_vector[i] <- cuisines[[i]]
}

#гистограмма кол-ва рецептов из каждой кухни
write(name_cuisines, file = "names.csv")
dat <- data.frame(x=c(1:20), y=c(plot_vector))
barplot(dat$y, names.arg=c(name_cuisines), ylim=c(0,8000), xlim=c(0,30), las=2, cex.axis=1, cex.names=0.6)
