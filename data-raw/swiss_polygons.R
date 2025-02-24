
swiss_polygons <- read.csv("data-raw/swiss_cantonZurich_texture.csv") %>%
  mutate(x = 0.5 * clay + silt,
         y = clay,
         label = ENGLISH_TRANSLATION) %>%
  slice(1, 2, 4, 3, 5:n()) # for ensuring that sandy soils are ordered in a closed polygon


