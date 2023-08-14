#' Make all of Australia map
#' Combines the state level processed datasets into an Australia map

act <- read_sf("data/final/act.gpkg")
nt <- read_sf("data/final/nt.gpkg")
sa <- read_sf("data/final/sa.gpkg")
wa <- read_sf("data/final/wa.gpkg")
vic <- read_sf("data/final/vic.gpkg")
tas <- read_sf("data/final/tas.gpkg")
nsw <- read_sf("data/final/nsw.gpkg")

aus <- bind_rows(
    act,
    nt,
    sa,
    wa,
    vic,
    tas,
    nsw
)

write_sf(aus, "data/final/aus.gpkg")

mapview(aus, zcol = "bf_area_pct")
