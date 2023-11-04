#' Process NSW
#' Read in the suburbs data, and the state bushfire prone area.
#' Intersect both datasets and calculate area statistics


# suburb data -------------------------------------------

nsw_subs <- read_sf("data/final/abs_suburbs.gpkg") |>
    filter(STE_CODE21 == 1) # NSW State Code


# bushfire data -------------------------------------------

nsw_bf <- read_sf("data/staging/nsw/BFPL20230713.shp") |>
    st_transform("EPSG:7855") |>
    mutate(
        state = "NSW",
        rating = d_Category
    ) |>
    select(state, rating) |>
    st_make_valid() |>
    as_geos_geometry() |>
    geos_make_collection() |>
    geos_unary_union() |>
    st_as_sf()


# intersect ---------------------------------------------

inter <- st_intersection(nsw_subs, nsw_bf) |>
    mutate(
        bf_area = units::set_units(st_area(geom), "km2"),
    ) |>
    select(SAL_CODE21, bf_area) |>
    st_drop_geometry() |>
    group_by(SAL_CODE21) |>
    summarise(bf_area = sum(bf_area), .groups = "drop")


# final suburb level dataset ----------------------------

final <- nsw_subs |>
    left_join(inter, by = "SAL_CODE21") |>
    mutate(
        bf_area_pct = as.numeric(bf_area / area),
        bf_area_pct = replace_na(bf_area_pct, 0)
    ) |>
    st_transform("EPSG:3857")


# Unit tests --------------------------------------------

stopifnot(

    # only one state
    length(unique(nsw_subs$STE_CODE21)) == 1,

    # no dups in intersect
    anyDuplicated(inter$SAL_CODE21) == 0,

    # more than one intersect
    nrow(inter) > 0,

    # less than n intersects
    nrow(inter) < nrow(nsw_subs),

    # bf_area_pct >= 0
    min(final$bf_area_pct) >= 0,

    # bf_area_pct <= 1
    all.equal(max(final$bf_area_pct), 1),

    # no na bf_area_pct
    sum(is.na(final$bf_area_pct)) == 0,

    # n final eq n input
    nrow(nsw_subs) == nrow(final),

    # no duplicate SAL_CODE21
    anyDuplicated(final$SAL_CODE21) == 0
)

# Export data -------------------------------------------

write_sf(final, "data/final/nsw.gpkg")
