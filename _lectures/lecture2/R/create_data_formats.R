# Create different data formats
library(tidyverse)

squirrels <- read_csv("_lectures/lecture2/data/nyc_squirrels.csv")

writexl::write_xlsx(squirrels, "_lectures/lecture2/data/nyc_squirrels_excel.xlsx")
write_csv2(squirrels, "_lectures/lecture2/data/nyc_squirrels_csv2.csv")
write_tsv(squirrels, "_lectures/lecture2/data/nyc_squirrels_tsv.txt")

raw <- read_lines("_lectures/lecture2/data/nyc_squirrels.csv")
text <- c("# Measurement time XXX", "Instrument id onknown", raw)
writeLines(text, "_lectures/lecture2/data/nyc_squirrels_messier.csv")
