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

# also run stats off flat with centroids
aus |>
    st_transform(st_crs(4326)) |>
    st_centroid(of_largest_polygon = TRUE) |>
    mutate(centroid = st_coordinates(geom)) |>
    mutate(
        cent_lat = centroid[, "Y"],
        cent_lon = centroid[, "X"]) |>
    select(-centroid) |>
    st_drop_geometry() |>
    write_csv(here("data", "bf-prone-processed.csv"))
