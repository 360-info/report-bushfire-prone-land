#' Make all of Australia map
#' Combines the state level processed datasets into an Australia map

act <- read_sf("data/final/act.gpkg")
nt <- read_sf("data/final/nt.gpkg")

aus <- bind_rows(act, nt)

write_sf(aus, "data/final/aus.gpkg")

mapview(aus, zcol = "bf_area_pct")
