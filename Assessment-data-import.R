library(tidyverse)

dat <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data", col_names = F)

head(dat)

#rows
nrow(dat)

#coulumns
ncol(dat)