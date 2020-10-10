library(rvest)
library(lubridate)
library(fitdistrplus)
library(tidyverse)

url <- "https://www.speedrun.com/mkw/full_game"
table_url <- "https://www.speedrun.com/ajax_leaderboard.php?variable13256=44495&variable13254=44493&variable13257=44497&variable13258=44499&variable13259=44503&variable13260=44505&variable13263=44514&variable13271=44531&variable13264=44516&variable13272=44517&variable13265=44520&variable13273=44535&variable13266=44522&variable13274=44538&variable13267=44524&variable13275=44541&variable13268=44526&variable13276=44544&variable13269=44528&variable13277=44547&variable13270=44530&variable13278=44550&game=mkw&verified=1&category=5137&platform=&variable3313=&variable13253=&loadtimes=2&video=&obsolete=&date="

ses <- html_session(table_url)

all_times <- ses %>%
  html_table(fill = TRUE) %>%
  {.[[1]]} %>%
  as_tibble(.name_repair = "universal") %>%
  select(rank = Rank, player = Player, time = Real.time) %>%
  mutate(rank = parse_number(rank),
         time = hms(time),
         seconds = seconds(time) %>% as.integer())

all_times$seconds %>%
  hist()

all_times %>%
  ggplot(aes(x = 0, y = time)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter() +
  scale_y_time(labels = scales::label_time(format = "%H:%M h"))


descdist(all_times$seconds, discrete = FALSE)
descdist(log(all_times$seconds), discrete = FALSE)

fit_norm <- fitdist(all_times$seconds, "norm")
fit_lognorm <- fitdist(log(all_times$seconds), "norm")

plot(fit_norm)
plot(fit_lognorm)


