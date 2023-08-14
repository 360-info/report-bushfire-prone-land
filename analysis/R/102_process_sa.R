#' Process SA
#' Read in the suburbs data, and the state bushfire prone area.
#' Intersect both datasets and calculate area statistics


# suburb data -------------------------------------------

sa_subs <- read_sf("data/final/abs_suburbs.gpkg") |>
    filter(STE_CODE21 == 4) # SA State Code


# bushfire data -------------------------------------------

sa_bf <- read_sf("data/staging/sa/BushfireProtectionAreas_GDA2020.shp") |>
    st_transform("EPSG:7855") |>
    mutate(
        state = "NT",
        rating = bf_code
    ) |>
    select(state, rating)  |>
    st_make_valid()  |>
    st_union()  |>
    st_as_sf()


# intersect ---------------------------------------------

inter <- st_intersection(sa_subs, sa_bf) |>
    mutate(
        bf_area = units::set_units(st_area(geom), "km2"),
    ) |>
    select(SAL_CODE21, bf_area)  |>
    st_drop_geometry()


# final suburb level dataset ----------------------------

final <- sa_subs |>
    left_join(inter, by = "SAL_CODE21") |>
    mutate(
        bf_area_pct = as.numeric(bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")

write_sf(final, "data/final/sa.gpkg")