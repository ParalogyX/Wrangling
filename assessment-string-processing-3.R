library(rvest)
library(tidyverse)
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[5]] %>% html_table(fill = TRUE)


polls <- polls[-1,]

head(polls)

colnames(polls) = c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes") 

new_polls<-polls %>% subset(str_detect(remain, "%")) 


print(nrow(new_polls))

#solution from Harvard
names(polls) <- c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")
polls <- polls[str_detect(polls$remain, "%"),-100] #What is this -9
nrow(polls)


temp <- str_extract_all(polls$dates, "\\d+\\s[a-zA-Z]+")
end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)
end_date
