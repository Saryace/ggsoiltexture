library(ggsoiltexture)
library(tidyverse)
library(ggpomological)
theme_set(theme_pomological())


usda_1927 <- tribble(
  ~ Clay,
  ~ Sand,
  ~ Silt,
  ~ Label,
  1.00,
  0.00,
  0.00,
  "Clay",
  0.50,
  0.50,
  0.00,
  "Clay",
  0.30,
  0.50,
  0.20,
  "Clay",
  0.30,
  0.20,
  0.50,
  "Clay",
  0.50,
  0.00,
  0.50,
  "Clay",
  0.50,
  0.50,
  0.00,
  "Sandy\nClay",
  0.30,
  0.50,
  0.20,
  "Sandy\nClay",
  0.30,
  0.70,
  0.00,
  "Sandy\nClay",
  0.50,
  0.00,
  0.50,
  "Silty\nClay",
  0.30,
  0.20,
  0.50,
  "Silty\nClay",
  0.30,
  0.00,
  0.70,
  "Silty\nClay",
  0.20,
  0.80,
  0.00,
  "Sandy Clay\nLoam",
  0.30,
  0.70,
  0.00,
  "Sandy Clay\nLoam",
  0.30,
  0.50,
  0.20,
  "Sandy Clay\nLoam",
  0.20,
  0.50,
  0.30,
  "Sandy Clay\nLoam",
  0.30,
  0.50,
  0.20,
  "Clay Loam",
  0.20,
  0.50,
  0.30,
  "Clay Loam",
  0.20,
  0.30,
  0.50,
  "Clay Loam",
  0.30,
  0.20,
  0.50,
  "Clay Loam",
  0.20,
  0.30,
  0.50,
  "Silty Clay\nLoam",
  0.30,
  0.20,
  0.50,
  "Silty Clay\nLoam",
  0.30,
  0.00,
  0.70,
  "Silty Clay\nLoam",
  0.20,
  0.00,
  0.80,
  "Silty Clay\nLoam",
  0.00,
  1.00,
  0.00,
  "Sand",
  0.00,
  0.80,
  0.20,
  "Sand",
  0.20,
  0.80,
  0.00,
  "Sand",
  0.20,
  0.80,
  0.00,
  "Sandy Loam",
  0.00,
  0.80,
  0.20,
  "Sandy Loam",
  0.00,
  0.50,
  0.50,
  "Sandy Loam",
  0.20,
  0.50,
  0.30,
  "Sandy Loam",
  0.20,
  0.50,
  0.30,
  "Loam",
  0.00,
  0.50,
  0.50,
  "Loam",
  0.20,
  0.30,
  0.50,
  "Loam",
  0.00,
  0.50,
  0.50,
  "Silt Loam",
  0.20,
  0.30,
  0.50,
  "Silt Loam",
  0.20,
  0.00,
  0.80,
  "Silt Loam",
  0.00,
  0.00,
  1.00,
  "Silt Loam"
) %>%  mutate(x = 0.5 * (Clay * 100) + (Silt * 100),
              y = Clay * 100)

labels <-    usda_1927 %>%
  mutate(x = 0.5 * (Clay*100) + (Silt*100),
         y = Clay*100) %>%
  group_by(Label) %>%
  dplyr::summarise(Clay = mean(Clay),
                   Sand = mean(Sand),
                   Silt = mean(Silt),
                   x = mean(x),
                   y = mean(y))

historical_plot <-
  ggsoiltexture(tibble(sand=33,silt=33,clay=34)) +
  geom_polygon(data = usda_1927,
               aes(x = x, y = y, fill = Label),
               alpha = 0,
               size = 0.5,
               color = '#a89985',
               show.legend = FALSE) +
  geom_text(
    data = labels,
    aes(x = x, y = y, label = Label),
    color = '#6b452b',
    size = 2.5,
    family = "Courier"
  ) +
  ggtitle("Davis and Bennett, 1927, Fig. 2") +
  theme(rect = element_rect(fill = "transparent"),
        panel.background = element_rect(fill = "transparent",
                                              colour = NA_character_))

paint_pomological(historical_plot, res = 110, outfile = "img/plot3.png")
