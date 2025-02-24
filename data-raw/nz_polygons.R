
nz_polygons <- read.csv("data-raw/NZTT.csv") %>%
  mutate(x = 0.5 * CLAY + SILT,
         y = CLAY,
         label = NAME)
