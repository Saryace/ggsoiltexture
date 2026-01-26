library(tidyverse)
aus_polygons <- read.csv("data-raw/Australia.csv") %>%
  mutate(
    label = case_when(
      label == "Sandy clay loam" ~ "Sandy\nclay loam",
      label == "Sandy clay" ~ "Sandy\nclay",
      TRUE ~ as.character(label)
    )
  )

# save w/ save(aus_polygons, file = 'data/aus_polygons.rda')
