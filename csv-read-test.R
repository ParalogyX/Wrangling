library(tidyverse) 
library(readxl)

dat <- read_csv("./data/b'paralogyx_computational_thinking_using_python_grades.csv", skip = 0, n_max = 7, col_names = F)
dat2 <- read_csv("./data/b'paralogyx_computational_thinking_using_python_grades.csv", skip = 8, col_names = T)

print(paste("Course name: ", dat2$name, ". Grade: ", dat2$letter_grade, sep = ""))
