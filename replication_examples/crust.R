library(ggsoiltexture)
library(tidyverse)

crust_polygons <- tibble(
  sand = c(35, 0, 0, 35, 50, 35, 35, 0, 0, 50, 75, 50, 50, 0 , 0, 45,
           75, 45, 0, 0, 30, 50, 70, 100,
           70, 50, 30,0, 0, 70),
  clay = c(0, 0, 15, 15, 0, 0, 15, 15, 20, 20, 0, 0, 20, 20, 30, 30,
            0, 30, 30, 50, 50, 30, 30, 0,
           30,30,50,50,100,30),
  silt = 100 - sand - clay,
  crust =  c("Very High","Very High","Very High","Very High",
             "High","High","High","High","High","High",
             "Moderate","Moderate","Moderate","Moderate","Moderate","Moderate",
             "Low","Low","Low","Low","Low","Low","Low","Low",
             "Very Low","Very Low","Very Low","Very Low","Very Low","Very Low")
) %>%
  mutate(x = 0.5 * clay + silt,
         y = clay)

crust <-
ggsoiltexture(tibble(sand=33,silt=33,clay=34),
              class = NULL) +
  geom_polygon(data = crust_polygons,
               aes(x = x, y = y, fill = crust),
               color = "transparent",
               alpha = 0.7) +
  geom_polygon(data = usda_polygons,
               aes(x = x, y = y, fill = label),
               alpha = 0,
               color = "grey20",
               show.legend = FALSE) +
  geom_text(data = usda_polygons %>%
              dplyr::group_by(label) %>%
              dplyr::summarise_if(is.numeric, mean, na.rm = TRUE),
            aes(label = label),
            size = 3.5) +
  scale_fill_manual(
    name = "Textural Crusting\nSusceptibility",  # Legend title
    values = c("Very High" = "#eda75d",
               "High" = "#eebecf",
               "Moderate" = "#c4e45b",
               "Low" = "#f9f15c",
               "Very Low" = "#bcdee9"
               )  #
  )

ggsave(crust, file = "img/plot5.png")
