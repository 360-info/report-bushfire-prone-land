#' Process WA
#' Read in the suburbs data, and the state bushfire prone area.
#' Intersect both datasets and calculate area statistics


# suburb data -------------------------------------------

wa_subs <- read_sf("data/final/abs_suburbs.gpkg") |>
    filter(STE_CODE21 == 5) # WA State Code


# bushfire data -------------------------------------------

wa_bf <- read_sf("data/staging/wa/Bush_Fire_Prone_Areas_2021_OBRM_019.shp") |>
    st_transform("EPSG:7855") |>
    mutate(
        state = "WA",
        rating = type
    ) |>
    select(state, rating)  |>
    st_make_valid()  |>
    st_union()  |>
    st_as_sf()


# intersect ---------------------------------------------

inter <- st_intersection(wa_subs, wa_bf) |>
    mutate(
        bf_area = units::set_units(st_area(geom), "km2"),
    ) |>
    select(SAL_CODE21, bf_area)  |>
    st_drop_geometry()


# final suburb level dataset ----------------------------

final <- wa_subs |>
    left_join(inter, by = "SAL_CODE21") |>
    mutate(
        bf_area_pct = as.numeric(bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")

write_sf(final, "data/final/wa.gpkg")
