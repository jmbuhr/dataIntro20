library(omdbapi)
library(tidyverse)

res <- search_by_title("Star Wars")
ids <- res$imdbID
starwars_movies <- map_dfr(ids, find_by_id) %>%
  distinct(Title, .keep_all = TRUE) %>%
  mutate(year = parse_number(Year)) %>%
  select(-Year)

write_rds(starwars_movies, "_lectures/lecture7/data/starwars_movies.rds")








