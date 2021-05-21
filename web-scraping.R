# import a webpage into R
library(rvest)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)
h

tab <- h %>% html_nodes("table")

tab <- tab[[2]]
tab

tab <- tab %>% html_table
class(tab)

tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)



#Guacamole recipe
#we will try to extract the recipe name, total preparation time, and list of ingredients

url <- "https://foodnetwork.co.uk/recipes/guacamole/"
h <- read_html(url)

recipe <- h %>% html_node("h1") %>% html_text()
prep_time <- h %>% html_node("strong") %>% html_text()
ingredients <- h %>% html_nodes(".ingredient") %>% html_text()

guacamole <- list(recipe, prep_time, ingredients)
guacamole



#selectors:
#Recipe name: itemprop="name", h1
#Ingridients: class="recipe-tab-container", class="ingredient" for each,  .ingredient
#prep time: itemprop="prepTime" strong



get_recipe <- function(url){
  h <- read_html(url)
  recipe <- h %>% html_node("h1") %>% html_text()
  prep_time <- h %>% html_node("strong") %>% html_text()
  ingredients <- h %>% html_nodes(".ingredient") %>% html_text()
  return(list(recipe = recipe, prep_time = prep_time, ingredients = ingredients))
} 

get_recipe("https://foodnetwork.co.uk/recipes/pancakes-4926/")
