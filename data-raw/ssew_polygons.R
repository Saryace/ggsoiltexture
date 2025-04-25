library(tidyverse)
ssew_polygons <- read.csv("data-raw/SSEW.csv") %>%
  mutate(x = 0.5 * clay + silt,
         y = clay)

