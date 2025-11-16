#' Plot Soil Texture Data Using a Ternary Plot
#'
#' This function creates a ternary plot for soil texture data, showing the proportions of sand, silt, and clay.
#' It allows for customization of the grid display and the addition of soil texture classification polygons.
#'
#' @param data A data frame containing soil texture data. It must include columns `clay`, `silt`, and `sand`,
#'            which represent the percentages of clay, silt, and sand, respectively. The sum of these three
#'            columns must be approximately 100% (within 0.1% tolerance).
#' @param show_grid Logical. If `TRUE` (default), a grid is displayed on the plot to aid interpretation.
#' @param class A character string specifying the soil texture classification system to overlay on the plot.
#'              Supported values are `"USDA"`, `"NZ"`, `"NZG"`, `"AUS"`, `"GERMAN"`, `"SSEW"` and `"SWISS"`. If `NULL` (default),
#'              no classification polygons are displayed.
#'
#' @return A `ggplot` object representing the soil texture ternary plot.
#'
#' @examples
#' # Example data
#' soil_data <- data.frame(
#'   clay = c(20, 30, 40),
#'   silt = c(30, 40, 20),
#'   sand = c(50, 30, 40)
#' )
#'
#' # Basic plot
#' ggsoiltexture(soil_data)
#'
#' # Plot with USDA classification
#' ggsoiltexture(soil_data, class = "USDA")
#'
#' # Plot without grid
#' ggsoiltexture(soil_data, show_grid = FALSE)
#'
#' @importFrom dplyr mutate
#' @importFrom tibble tibble
#' @importFrom ggplot2 ggplot geom_point annotate geom_segment geom_polygon geom_text coord_equal theme_bw theme element_blank
#' @export

ggsoiltexture <- function(data, show_grid = TRUE, class = NULL) {
  if (any(data$clay + data$silt + data$sand > 100.1 | data$clay + data$silt + data$sand < 99.9))
    stop("Some of your textural data do not sum 100%, please check.!")

  soil_data_transformed <- data %>%
    dplyr::mutate(
      x = 0.5 * clay + silt,
      y = clay
    )

  grilla_uno <- tibble::tibble(
    x1 = seq(from = 10, to = 90, by = 10),
    x2 = x1/2,
    y1 = 0,
    y2 = seq(from = 10, to = 90, by = 10))

  grilla_dos <- tibble::tibble(
    x1 = seq(from = 10, to = 90, by = 10),
    x2 = c(55, 60, 65, 70, 75, 80, 85, 90, 95),
    y1 = 0,
    y2 = seq(from = 90, to = 10, by = -10)
  )

  grilla_tres <- tibble::tibble(
    x1 = seq(from = 5, to = 45, by = 5),
    x2 = seq(from = 95, to = 55, by = -5),
    y1 = seq(from = 10, to = 90, by = 10),
    y2 = seq(from = 10, to = 90, by = 10)
  )
  # Add axis labels at 0 and 100
  axis_sand <- tibble::tibble(
    x = seq(from = 0, to = 100, by = 10),
    y = rep(0, 11),
    label = seq(from = 100, to = 0, by = -10),
  )

  axis_clay <- tibble::tibble(
    x = c(50, 45, 40, 35, 30, 25, 20, 15, 10, 5, 0),
    y = seq(from = 100, to = 0, by = -10),
    label = seq(from = 100, to = 0, by = -10),
  )

  axis_silt <- tibble::tibble(
    x = c(100, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50),
    y = seq(from = 0, to = 100, by = 10),
    label = seq(from = 100, to = 0, by = -10)
  )

  # Create the plot
  plot <- ggplot2::ggplot(soil_data_transformed, aes(x, y)) +
    ggplot2::geom_point() +
    ggplot2::annotate("segment", x = 0, y = 0, xend = 100, yend = 0) +
    ggplot2::annotate("segment", x = 0, y = 0, xend = 50, yend = 100) +
    ggplot2::annotate("segment", x = 50, y = 100, xend = 100, yend = 0)

  if (show_grid) {
    plot <- plot +
      ggplot2::geom_segment(
        aes(x = x1, y = y1, xend = x2, yend = y2),
        data = grilla_uno,
        linetype = "dashed",
        linewidth = 0.25,
        colour = "grey50"
      ) +
      ggplot2::geom_segment(
        aes(x = x1, y = y1, xend = x2, yend = y2),
        data = grilla_dos,
        linetype = "dashed",
        linewidth = 0.25,
        colour = "grey50"
      ) +
      ggplot2::geom_segment(
        aes(x = x1, y = y1, xend = x2, yend = y2),
        data = grilla_tres,
        linetype = "dashed",
        linewidth = 0.25,
        colour = "grey50"
      )
  }

  if (!is.null(class)) {
    class_data <- switch(
      class,
      "USDA" = usda_polygons,
      "NZ" = nz_polygons,
      "NZG" = nzg_polygons,
      "AUS" = aus_polygons,
      "GERMAN" = german_polygons,
      "SWISS" = swiss_polygons,
      "SSEW" = ssew_polygons,
      stop("Unknown classification system: ", class)
    )

    plot <- plot +
      ggplot2::geom_polygon(
        data = class_data,
        aes(x, y, fill = label),
        alpha = 0.0,
        linewidth = 0.5,
        color = "black",
        show.legend = FALSE
      ) +
      ggplot2::geom_text(
        data = class_data %>% dplyr::group_by(label) %>% dplyr::summarise_if(is.numeric, mean, na.rm = TRUE),
        aes(x, y, label = label),
        color = 'black',
        size = 2.5
      )
  }

  plot <- plot +
    ggplot2::geom_text(data = axis_sand, aes(x = x, y = y, label = label), size = 2 , vjust = 1.5, hjust = 0.5) +
    ggplot2::geom_text(data = axis_silt, aes(x = x, y = y, label = label), size = 2, angle = 60, vjust = 0.5, hjust = -0.5) + # tilt silt labels
    ggplot2::geom_text(data = axis_clay, aes(x = x, y = y, label = label), size = 2, vjust = 0.5, hjust = 1.5) + # tilt clay labels
    ggplot2::annotate("text", x = 20, y = 52.5, label = "Clay (%) →", angle = 60, size = 3) +
    ggplot2::annotate("text", x = 75, y = 60, label = "Silt (%) →", angle = -60, vjust = 0.5, hjust = -0.5, size = 3) +
    ggplot2::annotate("text", x = 50, y = -5, label = " ← Sand (%)", size = 3) +
    ggplot2::coord_equal(ratio = 1) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.border = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank()
    )

  return(plot)
}
