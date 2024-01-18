# ggsoiltexture

The goal of ggsoiltexture is to provide a simple ggplot function for the plotting of soil textural data. It is still in development, mainly for use in pubs. If you use this package please cite this repository.

## Installation

You can install the ggsoiltexture v1.0 from [GitHub](https://github.com/Saryace/ggsoiltexture) with:

``` r
# install.packages("devtools")
devtools::install_github("Saryace/ggsoiltexture")
```

## What do you need?
Dataframe with three variables called:
- sand, as percentage
- silt, as percentage
- clay, as percentage

## More info

- Visit the [lab's YT channel](https://www.youtube.com/@laboratoriobiofisicadesuel2912)

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

```

### Plot

A simple plot can be done directly

``` r
library(tidyverse)
library(ggsoiltexture)
simple_data <- data.frame(id = c("A","B","C","D"),
              clay = c(10,20,25,20,10),
              silt  = c(35,15,45,30,40),
              sand = c(55.65,30,0,50,50),
             om = c(5,15,5,12,7))


simple_plot <-
ggsoiltexture(simple_data)

simple_plot
```
