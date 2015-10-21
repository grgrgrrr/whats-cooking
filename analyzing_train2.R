library("rjson")
#данные
json_file <- "train.json"
train_data <- fromJSON(file=json_file, method='C')

count_cuisines <- 20

#гистограммы кол-ва ингридиентов в  каждой кухне
for (i in 1:count_cuisines)
{
  #name_ingridients <- vector(length = )
  curr_cuisine <- name_cuisines[i]
  #те рецепты, которые принадлежат текущей кухне
  cond <- lapply(train_data, function(x) x$cuisine == curr_cuisine)
  curr_receipes <- train_data[unlist(cond)]
  count_curr_receipes <- length(curr_receipes)
  
  #ассоциативный массив для ингридиентов
  map_ingridients <- new.env(hash = T, parent = emptyenv())
  
  for (i in 1:count_curr_receipes){
    ingr <- curr_receipes[i][[1]]$ingredients
    for (k in ingr)
      if (is.null(map[[k]]))
      {
        map_ingridients[[k]] = 1
      }
      else
      {
        map_ingridients[[k]] = map[[k]] + 1
      }
  }
  
  #записываем значения в вектор для отрисовки
  count_ingridients<- length(map_ingridients)
  plot_vector <- rep(0, count_ingridients) 
  ingridients <- as.list(map_ingridients)
  for (i in 1:count_ingridients)
  {
    plot_vector[i] <- ingridients[[i]]
  }
  
  dat <- data.frame(x=c(1:count_ingridients), y=c(plot_vector))
  barplot(dat$y, names.arg=c(1:count_ingridients), ylim=c(0,7000), main = curr_cuisine)
  
  print(curr_cuisine)
  print(count_curr_receipes)
  print(count_ingridients)
}

