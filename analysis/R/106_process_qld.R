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

    paste("polygon processed:", path)

    inter <- st_intersection(suburbs, qld_bf) |>
        mutate(
            bf_area = units::set_units(st_area(geom), "km2"),
        ) |>
        select(SAL_CODE21, bf_area) |>
        st_drop_geometry()

    paste("intersection calculated:", path)

    return(inter)
}

qld_files <- list.files("data/staging/qld", pattern = ".shp$", full.names = TRUE)
inter <- purrr::map_dfr(qld_files, ~qld_process_bf(.x, qld_subs))


# final suburb level dataset ----------------------------

# REMEMBER TO AGGREGATE!

final <- qld_subs |>
    left_join(inter, by = "SAL_CODE21") |>
    group_by(STE_CODE21, STE_NAME21, SAL_CODE21, SAL_NAME21, area)  |>
    summarise(total_bf_area = sum(bf_area), .groups = 'drop')  |>
    mutate(
        bf_area_pct = as.numeric(total_bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")

write_sf(final, "data/final/qld.gpkg")

