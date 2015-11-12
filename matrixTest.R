#install.packages("rjson")
library("rjson")
json_file <- "test.json"
d <- fromJSON(file=json_file, method='C')
m <- 9944
#testdt <- json_data[1]$id

map <- new.env(hash = T, parent = emptyenv()) 
j <- 1

for (i in 1:m){
  ingr <- d[i][[1]]$ingredients
  for (k in ingr)
    if (is.null(map[[k]]))
    {
      map[[k]] = j
      j = j + 1
    }
}

n <- 6713
#f <- matrix(data =0, nrow = m, ncol = n)


for (i in 1:m){
  f <- rep (0, n)
  ingr <- d[i][[1]]$ingredients
  for (k in ingr)
    f[map[[k]]] <- 1
  #f[n+1]=d[i][[1]]$cuisine
  write(f, file = "matrixTest.csv", ncolumns = n, append = TRUE, sep = " ");
  print(i / m * 100)
}

#tf <- as.table(f)
#write.table(tf, "table.csv")


