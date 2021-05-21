library(Lahman)
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)    # take entries 1-10
top %>% as_tibble()

Master %>% as_tibble()

top_names <- top %>% left_join(Master) %>%
  select(playerID, nameFirst, nameLast, HR)

top_salary <- Salaries %>% filter(yearID == 2016) %>%
  right_join(top_names) %>%
  select(nameFirst, nameLast, teamID, HR, salary)

top_awards <- AwardsPlayers %>% filter(yearID == 2016) %>% 
  right_join(top_names) %>%
  select(nameFirst, nameLast, HR, awardID, playerID) %>% group_by(player_id) %>% summarise(n = n())


not_top_awards <- AwardsPlayers %>% filter(yearID == 2016) %>% 
  left_join(top_names) %>%
  select(nameFirst, nameLast, HR, awardID, playerID)



Awards2016 <- AwardsPlayers %>% filter(yearID == 2016)
#Awarded from top
top_awarded <- intersect(top_names$playerID, Awards2016$playerID)
length(top_awarded)
#Awarded not from top
all_awarded <- unique(Awards2016$playerID)


length(all_awarded) - length(top_awarded)

#answer from Harvard
length(setdiff(Awards2016$playerID, top_names$playerID))
