library("rjson")
json_file <- "test.json"
d <- fromJSON(file=json_file, method='C')
m <- 9944

ids <- vector(length = 9944)
for (i in 1:m)
{
  ids[i] = d[i][[1]]$id
}

write(ids, file = "idTest.csv", ncolumns = 1)