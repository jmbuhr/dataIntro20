r# Create different data formats
library(tidyverse)

write_csv(gapminder::gapminder, "_lectures/lecture2/data/gapminder.csv")
writexl::write_xlsx(gapminder::gapminder, "_lectures/lecture2/data/gapminder.xlsx")
write_csv2(gapminder::gapminder, "_lectures/lecture2/data/gapminder_csv2.csv")
write_tsv(gapminder::gapminder, "_lectures/lecture2/data/gapminder_tsv.txt")

raw <- read_lines("_lectures/lecture2/data/gapminder.csv")
text <- c("# Some comment about the data", "And maybe a personal note", raw)
write_lines(text, "_lectures/lecture2/data/gapminder_messier.csv")

enframe(gapminder::country_colors, name = "country", value = "color") %>%
  write_csv("_lectures/lecture2/data/country_colors.csv")

read_csv("_lectures/lecture2/data/country_colors.csv") %>%
  mutate(color = set_names(color, country)) %>%
  pull(color)

write_delim(x = gapminder::gapminder,
          file = "_lectures/lecture2/data/obscure_file.tsv",
          delim = "~")

#  made with http://www.graphreader.com/2dreader
read_csv("_lectures/lecture2/data/exercise1_raw.csv", col_names = FALSE) %>%
  mutate(y = n():1) %>%
  pivot_longer(cols = c(-y), names_pattern = "X(.+)",

               names_to = "x") %>%
  mutate(x = as.integer(x)) %>%
  filter(is.na(value)) %>%
  mutate(value = 1) %>%
  write_delim("_lectures/lecture2/data/exercise1.txt",
              delim = "|")

sol <- read_lines("_lectures/lecture2/data/exercise1.txt") %>%
  read_delim(delim = "|")

sol %>%
  ggplot(aes(x, y)) +
  geom_point() +
  coord_equal()
