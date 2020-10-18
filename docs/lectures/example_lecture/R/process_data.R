library(tidyverse)

file <- file("https://ftp.ncbi.nlm.nih.gov/refseq/release/vertebrate_mammalian/vertebrate_mammalian.1.1.genomic.fna.gz")
lines <- read_lines(file)

genes <- tibble(
  raw = lines,
  group = cumsum(str_detect(lines, "^>"))
) %>%
  group_by(group) %>%
  mutate(entry = first(raw)) %>%
  group_by(entry) %>%
  slice(-1) %>%
  summarise(gene = paste(raw, collapse = ""))

genes %>%
  write_rds("_lectures/example_lecture/data/genes.rds")

genes <- read_rds("_lectures/example_lecture/data/genes.rds")

genes %>%
  separate(entry, into = c("nc", "genus", "species", "locus"),
           sep = "\\s", extra = "merge") %>%
  distinct(locus)

