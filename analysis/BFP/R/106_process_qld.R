#' Process QLD
#' Read in the suburbs data, and the state bushfire prone area.
#' Intersect both datasets and calculate area statistics


# suburb data -------------------------------------------

qld_subs <- read_sf("data/final/abs_suburbs.gpkg") |>
    filter(STE_CODE21 == 3) # QLD State Code


# bushfire data -------------------------------------------

qld_process_bf <- function(path, suburbs) {

    qld_bf <- read_sf(path) |>
        st_transform("EPSG:7855") |>
        mutate(
            state = "qld",
            rating = CLASS
        ) |>
        select(state, rating) |>
        st_make_valid() |>
        as_geos_geometry() |>
        geos_make_collection() |>
        geos_unary_union() |>
        st_as_sf()

    inter <- st_intersection(suburbs, qld_bf)

    return(inter)
}

qld_files <- list.files("data/staging/qld",
    pattern = ".shp$",
    full.names = TRUE
)

inter <- purrr::map_dfr(qld_files, ~qld_process_bf(.x, qld_subs))

inter_unique <- inter |>
    group_by(SAL_CODE21) |>
    summarise(
        area = max(area),
        geom = st_union(geom),
        .groups = "drop"
    ) |>
    mutate(
        bf_area = units::set_units(st_area(geom), "km2"),
    ) |>
    select(SAL_CODE21, bf_area) |>
    st_drop_geometry()


# final suburb level dataset ----------------------------

final <- qld_subs |>
    left_join(inter_unique, by = "SAL_CODE21") |>
    mutate(
        bf_area_pct = as.numeric(bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")


# Unit tests --------------------------------------------

stopifnot(

    # only one state
    length(unique(qld_subs$STE_CODE21)) == 1,

    # no dups in intersect
    anyDuplicated(inter_unique$SAL_CODE21) == 0,

    # more than one intersect
    nrow(inter_unique) > 0,

    # less than n intersects
    nrow(inter_unique) < nrow(qld_subs),

    # bf_area_pct >= 0
    min(final$bf_area_pct) >= 0,

    # bf_area_pct <= 1
    all.equal(max(final$bf_area_pct), 1),

    # no na bf_area_pct
    sum(is.na(final$bf_area_pct)) == 0,

    # n final eq n input
    nrow(qld_subs) == nrow(final),

    # no duplicate SAL_CODE21
    anyDuplicated(final$SAL_CODE21) == 0
)

# Export data -------------------------------------------

write_sf(final, "data/final/qld.gpkg")
