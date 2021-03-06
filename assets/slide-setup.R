options(htmltools.dir.version = FALSE)
library(knitr)
library(here)
library(tidyverse)
library(xaringanthemer)

opts_chunk$set(
  echo = FALSE,
  warning = FALSE,
  message = FALSE,
  fig.retina = 3,
  comment = ""
)

style_mono_accent("#3465a4",
  inverse_header_color = "#FFFFFF",
  text_font_google = google_font("Fira Sans"),
  header_font_google = google_font("Roboto"),
  code_font_google = google_font("Fira Mono"),
  header_h1_font_size = "2.75rem",
  header_h2_font_size = "1.5rem",
  header_h3_font_size = "1rem"
)

# "#002ab5"
# rgb(78, 92, 104);
