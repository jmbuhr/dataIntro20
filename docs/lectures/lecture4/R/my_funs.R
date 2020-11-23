say_hello <- function() {
  print("Hello!")
}

create_country_plot <- function(name) {
  filterd_gapminder <- gapminder %>%
    filter(country == name)

  model <- lm(lifeExp ~ year, data = filterd_gapminder)
  glance_model <- glance(model)

  text <- substitute(
    R^2 == rsq,
    list(rsq = round(glance_model$r.squared, 2) )
  )

  filterd_gapminder %>%
    ggplot(aes(year, lifeExp)) +
    geom_line() +
    geom_smooth(method = "lm") +
    geom_point() +
    labs(
      x = "Year",
      y = "Life Expectancy",
      title = name,
      subtitle = text
    )
}
