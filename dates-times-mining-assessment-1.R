library(dslabs)
library(lubridate)
options(digits = 3)    # 3 significant digits

#Q3
data(brexit_polls)

brexit_polls %>% filter(month(startdate) == 4) %>% nrow()
#or Harvard solution:
sum(month(brexit_polls$startdate) == 4)

brexit_polls %>% filter(round_date(enddate, unit = "week") == ymd("2016-06-12")) %>% nrow()
#or Harvard solution
sum(round_date(brexit_polls$enddate, unit = "week") == "2016-06-12")

#Q4
brexit_polls %>% mutate(end_weekday = weekdays(enddate)) %>% group_by(end_weekday) %>% summarize(n = n()) %>% arrange(desc(n))

#Harvard answer:
table(weekdays(brexit_polls$enddate))


#Q5
data(movielens)

movielens %>% mutate(year = year(as_datetime(timestamp))) %>% group_by(year) %>% summarize(n = n()) %>% arrange(desc(n))
#Harvard solution
dates <- as_datetime(movielens$timestamp)
reviews_by_year <- table(year(dates))    # count reviews by year
names(which.max(reviews_by_year))    # name of year with most reviews

movielens %>% mutate(hour = hour(as_datetime(timestamp))) %>% group_by(hour) %>% summarize(n = n()) %>% arrange(desc(n))
#Harvard solution

reviews_by_hour <- table(hour(dates))    # count reviews by hour
names(which.max(reviews_by_hour))    # name of hour with most reviews
