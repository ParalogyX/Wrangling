library(tidyverse)
library(pdftools)
options(digits = 3)    # report 3 significant digits

fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
#system("cmd.exe", input = paste("start", fn))

txt <- pdf_text(fn)
x <- str_split(txt[9], '\n')
s <- x[[1]]
class(s)
length(s) #it gives me 41, but correct answer is 40 (just guessed, because last is an empty)

s <- str_trim(s)
str_sub(s[1], -1, -1)

header_index <- str_which(s, "2015")[1] #also shifted to 1. COrrect answer is 2, in spite here I get 3. Looks like line 2 is empty and should be removed

header <- s[header_index]
month <- str_split(header, "\\s+", simplify = T)[1]
header <- str_split(header, "\\s+", simplify = T)[2:5]


#HarvardX solution:
tmp <- str_split(s[header_index], "\\s+", simplify = TRUE)
month <- tmp[1]
header <- tmp[-1]


month
header[3]



#Q8
tail_index <- str_which(s, "Total") #the same

#Q9
n <- str_count(s, "\\d+")
sum(n == 1)

#Q10


s <- s[-c(seq(tail_index, length(s))),drop=F]
s <- s[-c(seq(1, header_index)),drop=F]
n <- str_count(s, "\\d+")
s <- s[-c(which(n == 1))]
length(s)

#HarvardX solution:
out <- c(1:header_index, which(n==1), tail_index:length(s))
s <- s[-out]
length(s)

s <- str_remove_all(s, "[^\\d\\s]")
s <- str_split_fixed(s, "\\s+", n = 6)[,1:5]


colnames(s) <- c("day",header)

tab <- as.data.frame(s) %>% mutate_all(parse_number)  %>% mutate(month = month)

mean(tab$`2015`)
mean(tab$`2016`)

filter(tab, day >= 1 & day <= 19) %>% .$`2017` %>% mean()
filter(tab, day >= 20 & day <= 30) %>% .$`2017` %>% mean()


#HarvardX solution:

tab <- s %>% 
  as_data_frame() %>% 
  setNames(c("day", header)) %>%
  mutate_all(as.numeric)
mean(tab$"2017"[1:19]) #START USE THIS INSTEAD OF FILTER!!!
mean(tab$"2017"[20:30])


tab <- tab %>% gather(year, deaths, -day) %>%
  mutate(deaths = as.numeric(deaths))
tab


tab %>% filter (year != 2018) %>% ggplot(aes(day, deaths, color = year)) + geom_point() + 
  geom_vline(xintercept = 20) + geom_line()

#HarvardX solution:
tab %>% filter(year < 2018) %>% 
  ggplot(aes(day, deaths, color = year)) +
  geom_line() +
  geom_vline(xintercept = 20) +
  geom_point()
