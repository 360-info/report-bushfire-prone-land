#' Make all of Australia map
#' Combines the state level processed datasets into an Australia map

act <- read_sf(here("data/final/act.gpkg"))
nt <- read_sf(here("data/final/nt.gpkg"))
sa <- read_sf(here("data/final/sa.gpkg"))
wa <- read_sf(here("data/final/wa.gpkg"))
vic <- read_sf(here("data/final/vic.gpkg"))
tas <- read_sf(here("data/final/tas.gpkg"))
nsw <- read_sf(here("data/final/nsw.gpkg"))
qld <- read_sf(here("data/final/qld.gpkg"))


aus <- bind_rows(
    act,
    nt,
    sa,
    wa,
    vic,
    tas,
    nsw,
    qld
)

write_sf(aus, here("data/final/aus.gpkg"))
