library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)

nodes <- html_nodes(h, "table")

html_text(nodes[[8]])
html_table(nodes[[8]])

html_table(nodes[[3]],fill = F)

for (i in 1:4) {
  print(html_table(nodes[[i]], fill = T))
}

sapply(nodes[2:4], html_table)

last_three <- tail(nodes, n =3)
sapply(last_three, html_table)

#the same
html_table(nodes[[length(nodes)-2]])
html_table(nodes[[length(nodes)-1]])
html_table(nodes[[length(nodes)]])

tab1 <- html_table(nodes[[10]]) %>% subset(select = -1)



tab2 <- html_table(nodes[[19]])

tab1 <- tab1[-1,] %>% setNames(c("Team", "Payroll", "Average"))
tab2 <- tab2[-1,] %>% setNames(c("Team", "Payroll", "Average"))

tab_joined <- full_join(tab1, tab2, by = "Team")


#From Harvard:
tab_1 <- html_table(nodes[[10]])
tab_2 <- html_table(nodes[[19]])
col_names <- c("Team", "Payroll", "Average")
tab_1 <- tab_1[-1, -1]
tab_2 <- tab_2[-1,]
names(tab_2) <- col_names
names(tab_1) <- col_names
full_join(tab_1,tab_2, by = "Team")


#Q4-5
library(tidyverse)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
h <- read_html(url)
tab <- html_nodes(h, "table")
length(tab)
html_table(tab[[1]], fill=T)


for (i in 1:20) {
  tab_s <- html_table(tab[[i]], fill=T)
  if (ncol(tab_s) == 9 & names(tab_s)[1] == "Date(s) conducted") {
  #if (i>3) {
    print(i)
  }
}
