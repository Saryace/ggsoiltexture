library(tidyverse)
usda_polygons <- read.csv("data-raw/usda_polygons.csv") %>%
  mutate(
    label = case_when(
      label == "Loamy Sand" ~ "Loamy\nSand",
      TRUE ~ as.character(label)
    )
  )
