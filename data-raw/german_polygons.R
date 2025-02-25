library(tidyverse)
german_polygons <- read.csv("data-raw/ger_texture.csv") %>%
  add_row(CODE = "Tu3",
             NAME_GER = "Mittel schluffiger Ton",
             NAME = "Moderately Silty Clay",
             sand = 0,
             silt = 55,
             clay = 45) %>%
  group_by(CODE) %>%
  arrange(-desc(silt))

german_polygons <-
german_polygons %>%
  mutate(x = 0.5 * clay + silt,
         y = clay,
         label = CODE)




