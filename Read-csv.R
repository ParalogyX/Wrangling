library(dslabs)
library(tidyverse)    # includes readr
library(readxl)

# inspect the first 3 lines
read_lines("./data/murders.csv", n_max = 3)

# read file in CSV format
#dat <- read_csv(filename)  #original line
dat <- read_csv("./data/murders.csv")

#read using full path
dat <- read_csv(fullpath)
head(dat)

#Ex：
path <- system.file("extdata", package = "dslabs")
files <- list.files(path)
files

filename <- "murders.csv"
filename1 <- "life-expectancy-and-fertility-two-countries-example.csv"
filename2 <- "fertility-two-countries-example.csv"
dat=read.csv(file.path(path, filename), stringsAsFactors = TRUE)
dat1=read.csv(file.path(path, filename1))
dat2=read.csv(file.path(path, filename2))
dat=read_csv(file.path(path, filename))
dat1=read_csv(file.path(path, filename1))
dat2=read_csv(file.path(path, filename2))


#PREFERABLE TO USE read_csv (not read.csv) as it creates a tibble which is much faster than regular data frame, created by read.csv
#read_csv are from tydiverse and read.scv is R-base function. 