delayedAssign("usda_polygons", local({
  if (requireNamespace("tibble", quietly = TRUE)) {
    tibble::as_tibble(usda_polygons:::usda_polygons)
  } else {
    usda_polygons:::usda_polygons
  }
}))
