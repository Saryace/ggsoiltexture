library(tidyverse)
nz_polygons <- read.csv("data-raw/NZTT.csv") %>%
  mutate(x = 0.5 * CLAY + SILT,
         y = CLAY,
         label = NAME) %>%
  mutate(
    label = case_when(
      label == "Sandy Clay Loam" ~ "Sandy\nClay Loam",
      TRUE ~ as.character(label)
    )
  )
