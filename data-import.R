

path <- system.file("extdata", package = "dslabs")
#list.files(path)

filename <- "murders.csv"
fullpath <- file.path(path, filename)

file.copy(fullpath, "./data/")

file.exists(file.path("./data/", filename))