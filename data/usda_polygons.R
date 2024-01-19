delayedAssign("ggsoiltexture", local({
  if (requireNamespace("tibble", quietly = TRUE)) {
    tibble::as_tibble(ggsoiltexture:::usda_polygons)
  } else {
    ggsoiltexture:::usda_polygons
  }
}))
