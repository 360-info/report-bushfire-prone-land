#' Process NT
#' Read in the suburbs data, and the state bushfire prone area. 
#' Intersect both datasets and calculate area statistics 


# suburb data -------------------------------------------

nt_subs <- read_sf("data/final/abs_suburbs.gpkg") |>
    filter(STE_CODE21 == 7) # NT State Code


# bushfire data -------------------------------------------

nt_bf <- read_sf("data/staging/nt/Boundaries/Datasets/ESRI/Bushfires_NT/Fire_Protection_Zones.shp") |>
    st_transform("EPSG:7855") |>
    mutate(
        state = "NT",
        rating = "default"
    ) |>
    select(state, rating)  |>
    st_as_sf()


# intersect ---------------------------------------------

inter <- st_intersection(nt_subs, nt_bf) |>
    mutate(
        bf_area = units::set_units(st_area(geom), "km2"),
    ) |>
    select(SAL_CODE21, bf_area)  |>
    st_drop_geometry()


# final suburb level dataset ----------------------------

final <- nt_subs |>
    left_join(inter, by = "SAL_CODE21") |>
    mutate(
        bf_area_pct = as.numeric(bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")

write_sf(final, "data/final/nt.gpkg")
   

