#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(here)

fastfood <- read_csv(here("data/fastfood.csv")) %>%
  select(-salad, -X1) %>%
  distinct(restaurant, item, .keep_all = TRUE)

restaurants <- unique(fastfood$restaurant)

restaurant_names <- c(
  "mcdonalds",
  "chick-fil-a",
  "sonic-drive-in",
  "arbys",
  "burger-king",
  "dairy-queen",
  "subway",
  "taco-bell"
)

make_plot <- function(rest) {
  fastfood %>%
    filter(restaurant == rest) %>%
    pivot_longer(-c(restaurant, item)) %>%
    ggplot(aes(value, color = restaurant)) +
    geom_density() +
    facet_wrap(~ name, scales = "free")
}

# make_plot(restaurants[1])

complaints <- read_rds(here("data/complaints.rds"))

names <- tibble(
  restaurants,
  restaurant_names
)

top_complaints <- complaints %>%
  unnest_longer(complaints) %>%
  tidytext::unnest_tokens(input = complaints, output = "word", token = "words") %>%
  anti_join(tidytext::stop_words, by = c("word")) %>%
  count(restaurant, word, sort = TRUE) %>%
  group_by(restaurant) %>%
  slice_max(order_by = n, n = 15) %>%
  ungroup() %>%
  left_join(names, by = c("restaurant" = "restaurant_names")) %>%
  select(-restaurant) %>%
  rename(restaurant = restaurants)

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("Old Faithful Geyser Data"),
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("restaurant",
                        "Pick your poison",
                        choices = restaurants)
        ),
        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("mainPlt"),
          textOutput("topComplaints")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$mainPlt <- renderPlot({
    make_plot(input$restaurant)
  })

  output$topComplaints <- renderText({
    top_complaints %>%
      filter(restaurant == input$restaurant) %>%
        pull(word)
  }, sep = "; ")
}

# Run the application
shinyApp(ui = ui, server = server)

