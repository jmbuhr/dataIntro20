library(tidyverse)

gapminder <- gapminder::gapminder


write_dataset <- function(continent, data) {
  path <- glue::glue("_lectures/lecture3/data/{continent}.csv")
  write_csv(data, path)
}

nested_gapminder <- gapminder %>%
  nest_by(continent) %>%
  ungroup()

walk2(nested_gapminder$continent, nested_gapminder$data, write_dataset)
