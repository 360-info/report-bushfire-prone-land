#' NSW Fire History
#' A combined fires layer for NSW from all bush fire fighting agencies.
fires_raw <- read_sf("data/staging/fire_history/NPWSFireHistory.shp")

fires_raw |>
    select(label = Label) |>
    separate(label, into = c("year", "type"), sep = "(?<=\\d) ") |>
    mutate(year = as.numeric(substr(year, 1, 4))) |>
    st_transform("EPSG:3857") |>
    write_sf("data/final/fire_history.gpkg")