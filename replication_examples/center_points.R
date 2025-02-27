library(ggsoiltexture)
library(tidyverse)

center_points <- tibble(
  number = 1:12,
  sand = c(20.00, 6.50, 51.50, 32.50, 10.00, 59.00, 41.00, 18.00, 65.00, 82.00, 7.50, 92.00),
  clay = c(60.00, 47.00, 42.00, 32.50, 33.00, 27.00, 18.00, 15.00, 10.00, 5.00, 5.00, 3.00),
  silt = c(20.00, 46.50, 6.50, 35.00, 57.00, 14.00, 41.00, 67.00, 25.00, 13.00, 87.50, 5.00),
  class = c("clay", "silty clay", "sandy clay", "clay loam", "silty clay loam",
              "sandy clay loam", "loam", "silt loam", "sandy loam", "loamy sand",
              "silt", "sand"))


center_plot <-
ggsoiltexture(center_points,
              show_grid = FALSE,
              class = "USDA") +
  geom_segment(
    aes(x = 30,
        y = 60,
        xend = 70,
        yend = 60),
    color = "red",
    linewidth = 1
  ) +
  geom_segment(
    aes(x = 17.5,
        y = 35,
        xend = 82.5,
        yend = 35),
    color = "red",
    linewidth = 1
  ) +
  geom_segment(
    aes(x = 9,
        y = 18,
        xend = 91.5,
        yend = 18),
    color = "red",
    linewidth = 1
  ) +
  geom_segment(
    aes(x = 67.5,
        y = 35,
        xend = 85,
        yend = 0),
    color = "red",
    linewidth = 1
  ) +
  geom_segment(
    aes(x = 7.5,
        y = 15,
        xend = 30,
        yend = 0),
    color = "red",
    linewidth = 1
  ) +
  geom_point(color = "red", size = 5) +
  geom_text(data = center_points %>%
                   mutate(x = 0.5 * clay + silt,
                          y = clay),
            aes(x = x, y = y, label = number),
            color = "white")


ggsave(center_plot, file = "img/plot4.png")
