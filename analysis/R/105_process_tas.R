#' Process TAS
#' Read in the suburbs data, and the state bushfire prone area.
#' Intersect both datasets and calculate area statistics


# suburb data -------------------------------------------

tas_subs <- read_sf("data/final/abs_suburbs.gpkg") |>
    filter(STE_CODE21 == 6) # TAS State Code

# bushfire data -------------------------------------------

tas_bf_standard <- read_sf("data/staging/tas/bf/Tasmanian_Planning_Scheme_Code_Overlay_statewide.shp",
    query = "SELECT * FROM Tasmanian_Planning_Scheme_Code_Overlay_statewide WHERE OV_NAME = 'Bushfire-prone areas'") |>
    st_transform("EPSG:7855") |>
    mutate(
        state = "TAS",
        rating = "default"
    ) |>
    select(state, rating) 

tas_bf_interim <- read_sf("data/staging/tas/bf1/interim_planning_scheme_overlay_statewide.shp",
    query = "SELECT * FROM interim_planning_scheme_overlay_statewide WHERE O_NAME = 'Bushfire Prone Areas'") |>
    st_transform("EPSG:7855") |>
    mutate(
        state = "TAS",
        rating = "default"
    ) |>
    select(state, rating) 

tas_bf <- rbind(tas_bf_standard, tas_bf_interim) |>
    st_union() |>
    st_as_sf()


# intersect ---------------------------------------------

inter <- st_intersection(tas_subs, tas_bf) |>
    mutate(
        bf_area = units::set_units(st_area(geom), "km2"),
    ) |>
    select(SAL_CODE21, bf_area)  |>
    st_drop_geometry()


# final suburb level dataset ----------------------------

final <- tas_subs |>
    left_join(inter, by = "SAL_CODE21") |>
    mutate(
        bf_area_pct = as.numeric(bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")

write_sf(final, "data/final/tas.gpkg")
