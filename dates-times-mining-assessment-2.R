library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

head(gutenberg_metadata)

#Q6
pr_and_pr <- gutenberg_metadata %>% filter(str_detect(title, 'Pride and Prejudice')) 

#Q7
gutenberg_works() %>% filter(str_detect(title, 'Pride and Prejudice')) 

#Harvard's answer:
gutenberg_works(title == "Pride and Prejudice")$gutenberg_id


#Q8
pr_and_pr_text <- gutenberg_download(1342)

words <- pr_and_pr_text %>% unnest_tokens(word, text)
nrow(words)

words <- words %>% filter(!word %in% stop_words$word )
#Haravrd solution:
words <- words %>% anti_join(stop_words)

nrow(words)

words <- words %>% filter(!str_detect(word, "[0-9]")) #or !str_detect(word, "\\d")
nrow(words)

words_count <- words %>% group_by(word) %>% summarise(n = n()) %>% arrange((desc(n)))

words_count %>% filter(n > 100) %>% nrow()

names(which.max(words_count$n))

words_count$word


#From Harvard:

words %>%
  count(word) %>%
  filter(n > 100) %>%
  nrow()

words %>%
  count(word) %>%
  top_n(1, n) %>%
  pull(word)

words %>%
  count(word) %>%
  top_n(1, n) %>%
  pull(n)


#Q12
afinn <- get_sentiments("afinn")

afinn_sentiments <- words %>% inner_join(afinn, by = "word")
nrow(afinn_sentiments)

sum(afinn_sentiments$value > 0)/nrow(afinn_sentiments)
#or just mean(afinn_sentiments$value > 0)
sum(afinn_sentiments$value == 4)
