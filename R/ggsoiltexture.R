#' ggsoiltexture
#'
#' This function plots a ternary diagram
#' @name ggsoiltexture
#' @param data The name of the data frame.
#' @param sand The name of variable sand as percentage.
#' @param silt The name of variable silt as percentage.
#' @param clay The name of variable clay as percentage.
#' @return ggplot2 graphical object
#' @examples
#'
#' simple_data <- data.frame(id = c("A","B","C","D"),
#'              clay = c(10,20,25,20,10),
#'              silt  = c(35,15,45,30,40),
#'              sand = c(55.65,30,0,50,50),
#'              om = c(5,15,5,12,7))
#'
#' ggsoiltexture(data = simple_data)
#'
#' ## Create color for organic matter (variable = om)
#'
#' ggsoiltexture(data = simple_data) +
#'   geom_point(aes(color = om))
#'
#' @importFrom dplyr %>% mutate
#' @importFrom ggplot2 ggplot geom_point geom_segment aes theme_bw
#' @export


ggsoiltexture <- function(data) {

  if(any(data$clay + data$silt + data$sand > 100.1 | data$clay + data$silt + data$sand < 99.9))
    stop("Some of your textural data do not sum 100%, please check.!")

  soil_data_transformed = data %>%
    dplyr::mutate(
      x = 0.5 * clay + silt,
      y = clay
    )

  grilla_uno <- tibble::tibble(
    x1 = c(20, 40, 60, 80),
    x2 = c(10, 20, 30, 40),
    y1 = c(0, 0, 0, 0),
    y2 = c(20, 40, 60, 80))

  grilla_dos <- tibble::tibble(
    x1 = c(20, 40, 60, 80),
    x2 = c(60, 70, 80, 90),
    y1 = c(0, 0, 0, 0),
    y2 = c(80, 60, 40, 20)
  )

  grilla_tres <- tibble::tibble(
    x1 = c(10, 20, 30, 40),
    x2 = c(90, 80, 70, 60),
    y1 = c(20, 40, 60, 80),
    y2 = c(20, 40, 60, 80)
  )

  axis_sand <- tibble::tibble(
    x = c(20, 40, 60, 80),
    y = c(-5, -5, -5, -5),
    label = c(80, 60, 40, 20)
  )

  axis_clay <- tibble::tibble(
    x = c(35, 25, 15, 5),
    y = c(80, 60, 40, 20),
    label = c(80, 60, 40, 20)
  )

  axis_silt <- tibble::tibble(
    x = c(95, 85, 75, 65),
    y = c(20, 40, 60, 80),
    label = c(80, 60, 40, 20)
  )

  ggplot2::ggplot(soil_data_transformed, aes(x, y)) +
    ggplot2::geom_point() +
    ## Creo los segmentos
    ggplot2::geom_segment(aes(
      x = 0 ,
      y = 0,
      xend = 100,
      yend = 0
    )) +
    ggplot2::geom_segment(aes(
      x = 0,
      y = 0,
      xend = 50,
      yend = 100
    )) +
    ggplot2::geom_segment(aes(
      x = 50,
      y = 100,
      xend = 100,
      yend = 0
    )) +
    ggplot2::geom_segment(
      aes(
        x = x1,
        y = y1,
        yend = y2,
        xend = x2
      ),
      data = grilla_uno,
      linetype = "dashed",
      linewidth = 0.25,
      colour = "grey50"
    ) +
    ggplot2::geom_segment(
      aes(
        x = x1,
        y = y1,
        yend = y2,
        xend = x2
      ),
      data = grilla_dos,
      linetype = "dashed",
      linewidth = 0.25,
      colour = "grey50"
    ) +
    ggplot2::geom_segment(
      aes(
        x = x1,
        y = y1,
        yend = y2,
        xend = x2
      ),
      data = grilla_tres,
      linetype = "dashed",
      linewidth = 0.25,
      colour = "grey50"
    ) +
    ggplot2::geom_text(data = axis_sand,
                       aes(x = x,
                           y = y,
                           label = label),
                       size = 3) +
    ggplot2::geom_text(data = axis_silt,
                                aes(x = x,
                                    y = y,
                                    label = label),
                                size = 3) +
    ggplot2::geom_text(data = axis_clay,
                       aes(x = x,
                           y = y,
                           label = label),
                       size = 3) +
    ggplot2::geom_text(aes(15, 50, label = "Clay (%) →"),
                       angle = 60,
                       size = 4) +
    ggplot2::geom_text(aes(82.5, 50, label = "Silt (%) →"),
                       angle = -60,
                       size = 4) +
    ggplot2::geom_text(aes(50, -10, label = " ← Sand (%)"), size = 4) +
    ggplot2::coord_equal(ratio = 1) +
    ggplot2::theme_bw() +
    ggplot2::theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                   panel.border = element_blank(), axis.ticks = element_blank(),
                   axis.text.x = element_blank(), axis.text.y = element_blank(),
                   axis.title.x = element_blank(), axis.title.y = element_blank())
}
