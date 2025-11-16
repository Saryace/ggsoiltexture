library(tidyverse)
nz_polygons <- read.csv("data-raw/NZTT.csv") %>%
  mutate(
    label = case_when(
      label == "Sandy Clay Loam" ~ "Sandy\nClay Loam",
      TRUE ~ as.character(label)
    )
  )
