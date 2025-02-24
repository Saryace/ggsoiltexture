
# ggsoiltexture

The goal of ggsoiltexture is to provide a simple ggplot function for the plotting of soil textural data. It is still in development and under review in a journal for publication. Meanwhile, if you use this package please cite this repository. Hope it is useful!

## Acknowledgements 
The code was development based on the ggplot_piper functions written by [Jonh Dorian](https://gist.github.com/johnDorian/5561272) and inspired by the R package [ggtern](https://github.com/nicholasehamilton/ggtern). Thanks for sharing your knowledge. Also, thanks for the X users that give us feedback about functionalities and new ideas.

## Installation

You can install the last version of ggsoiltexture from [GitHub](https://github.com/Saryace/ggsoiltexture). This package will be available in CRAN after publication in a journal. 

``` r
# install.packages("devtools")
devtools::install_github("Saryace/ggsoiltexture")

```

## What do you need?
Dataframe or tibble with three variables called:
- sand, as percentage (0 - 100)
- silt, as percentage (0 - 100)
- clay, as percentage (0 - 100)

## Main functions:

**`ggsoiltexture`**

This function plots soil texture in a ternary plot. 

## Tutorial

### Data
Your data must to sum up 100%. The function will stop if it is not checked previously

``` r
library(tidyverse)
library(ggsoiltexture)
fail_data <- data.frame(
              clay = c(100,20,25,20,10),
              silt  = c(35,150,45,30,40),
              sand = c(55.65,30,0,500,50))

ggsoiltexture(fail_data)

Error in ggsoiltexture(fail_data) : 
  Some of your textural data do not sum 100%, please check.!

```

### Simple plot

A simple plot can be done directly

``` r
some_data <- data.frame(id = c("A","B","C","D","E"),
                          clay = c(10,20,25,20,10),
                          silt  = c(35,15,45,30,40),
                          sand = c(55,65,30,50,50),
                          om = c(5,15,5,12,7))

another_plot <-
ggsoiltexture(some_data)

another_plot
```

![](img/another_plot.png)

### Adding more layers

Because ggsoiltexture is based on ggplot2, more geoms, themes, can be added

``` r
pub_plot <-
    ggsoiltexture(some_data) +
    geom_point(aes(color = om), size = 6) +
    scale_color_continuous(type = "viridis") +
    labs(color = "Organic\nMatter (%)") +
    geom_label_repel(aes(label = id), box.padding = 0.5) +
    theme(legend.title = element_text(face = "bold"),
          legend.position = "bottom")

pub_plot 

```

![](img/pub_plot.png)

### Adding USDA classification system

Using geom_polygon, a layer showing the USDA classes can be added.

``` r
# load the USDA polygon info

data(usda_polygons)

# then plot

usda_plot <-
ggsoiltexture(some_data) +
  geom_polygon(
    data = usda_polygons,
    aes(fill = label),
    alpha = 0.0,
    size = 0.5,
    color = "black"
  ) +
  geom_text(data = usda_polygons  %>% group_by(label) %>%
              summarise_if(is.numeric, mean, na.rm = TRUE),
            aes(label = label),
            color = 'black',
            size = 3) +
  theme(legend.position = "none")

```

![](img/usda_plot.png)
