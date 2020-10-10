# Create different data formats
library(tidyverse)

write_csv(gapminder::gapminder, "_lectures/lecture2/data/gapminder.csv")
writexl::write_xlsx(gapminder::gapminder, "_lectures/lecture2/data/gapminder.xlsx")
write_csv2(gapminder::gapminder, "_lectures/lecture2/data/gapminder_csv2.csv")
write_tsv(gapminder::gapminder, "_lectures/lecture2/data/gapminder_tsv.txt")

raw <- read_lines("_lectures/lecture2/data/gapminder.csv")
text <- c("# Some comment about the data", "And maybe a personal note", raw)
write_lines(text, "_lectures/lecture2/data/gapminder_messier.csv")

read_lines("_lectures/lecture2/data/gapminder_messier.csv") %>%
  head()

enframe(gapminder::country_colors, name = "country", value = "color") %>%
  write_csv("_lectures/lecture2/data/country_colors.csv")

read_csv("_lectures/lecture2/data/country_colors.csv") %>%
  mutate(color = set_names(color, country)) %>%
  pull(color)
