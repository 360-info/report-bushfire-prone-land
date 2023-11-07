#' Process TAS
#' Read in the suburbs data, and the state bushfire prone area.
#' Intersect both datasets and calculate area statistics


# suburb data -------------------------------------------

tas_subs <- read_sf(here("data/final/abs_suburbs.gpkg")) |>
    filter(STE_CODE21 == 6) # TAS State Code

# bushfire data -------------------------------------------

tas_bf_standard <- read_sf(here("data/staging/tas/bf/Tasmanian_Planning_Scheme_Code_Overlay_statewide.shp"),
    query = "SELECT * FROM Tasmanian_Planning_Scheme_Code_Overlay_statewide WHERE OV_NAME = 'Bushfire-prone areas'"
) |>
    st_transform("EPSG:7855") |>
    mutate(
        state = "TAS",
        rating = "default"
    ) |>
    select(state, rating)

tas_bf_interim <- read_sf(here("data/staging/tas/bf1/interim_planning_scheme_overlay_statewide.shp"),
    query = "SELECT * FROM interim_planning_scheme_overlay_statewide WHERE O_NAME = 'Bushfire Prone Areas'"
) |>
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
    select(SAL_CODE21, bf_area) |>
    st_drop_geometry() |>
    group_by(SAL_CODE21) |>
    summarise(bf_area = sum(bf_area), .groups = "drop")


# final suburb level dataset ----------------------------

final <- tas_subs |>
    left_join(inter, by = "SAL_CODE21") |>
    mutate(
        bf_area_pct = as.numeric(bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")


# Unit tests --------------------------------------------

stopifnot(

    # only one state
    length(unique(tas_subs$STE_CODE21)) == 1,

    # no dups in intersect
    anyDuplicated(inter$SAL_CODE21) == 0,

    # more than one intersect
    nrow(inter) > 0,

    # less than n intersects
    nrow(inter) < nrow(tas_subs),

    # bf_area_pct >= 0
    min(final$bf_area_pct) >= 0,

    # bf_area_pct <= 1
    all.equal(max(final$bf_area_pct), 1),

    # no na bf_area_pct
    sum(is.na(final$bf_area_pct)) == 0,

    # n final eq n input
    nrow(tas_subs) == nrow(final),

    # no duplicate SAL_CODE21
    anyDuplicated(final$SAL_CODE21) == 0
)

# Export data -------------------------------------------

write_sf(final, here("data/final/tas.gpkg"))
