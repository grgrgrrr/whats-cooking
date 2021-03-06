library("rjson")
json_file <- "train.json"
train_data <- fromJSON(file=json_file, method='C')

name_cuisines <- read.table('names.csv', header=TRUE)
count_cuisines <- 20

for (i in 1:count_cuisines)
{
  curr_cuisine <- name_cuisines[i, 'country']
  cond <- lapply(train_data, function(x) x$cuisine == curr_cuisine)
  curr_receipes <- train_data[unlist(cond)]
  count_curr_receipes <- length(curr_receipes)
  
  map_ingridients <- new.env(hash = T, parent = emptyenv())
  
  for (i in 1:count_curr_receipes){
    ingr <- curr_receipes[i][[1]]$ingredients
    for (k in ingr)
      if (is.null(map_ingridients[[k]]))
      {
        map_ingridients[[k]] = 1
      }
      else
      {
        map_ingridients[[k]] = map_ingridients[[k]] + 1
      }
  }
  

  count_ingridients<- length(map_ingridients)
  plot_vector <- rep(0, count_ingridients) 
  ingridients <- as.list(map_ingridients)
  for (i in 1:count_ingridients)
  {
    plot_vector[i] <- ingridients[[i]]
  }
  
  dat <- data.frame(x=c(1:count_ingridients), y=c(plot_vector))
  barplot(dat$y, names.arg=c(1:count_ingridients), ylim=c(0,2000), main = curr_cuisine)
  
  #print(curr_cuisine)
  #print(count_curr_receipes)
  #print(count_ingridients)
}

