#' Process ACT
#' Read in the suburbs data, and the state bushfire prone area. 
#' Intersect both datasets and calculate area statistics 


# suburb data -------------------------------------------

act_subs <- read_sf("data/final/abs_suburbs.gpkg") |>
    filter(STE_CODE21 == 8) # ACT State Code


# bushfire data -------------------------------------------

act_bf <- read_sf("data/staging/act/Bushfire_Prone_Areas.shp") |>
    st_transform("EPSG:7855") |>
    mutate(
        state = "ACT",
        rating = "default"
    ) |>
    select(state, rating)  |>
    st_as_sf()


# intersect ---------------------------------------------

inter <- st_intersection(act_subs, act_bf) |>
    mutate(
        bf_area = units::set_units(st_area(geom), "km2"),
    ) |>
    select(SAL_CODE21, bf_area)  |>
    st_drop_geometry()


# final suburb level dataset ----------------------------

final <- act_subs |>
    left_join(inter, by = "SAL_CODE21") |>
    mutate(
        bf_area_pct = as.numeric(bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")

write_sf(final, "data/final/act.gpkg")
   