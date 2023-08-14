#' Suburb Processing
#' Process the ABS suburbs dataset for analysis

read_sf("data/staging/ABS/SAL_2021_AUST_GDA2020.shp") |>
    st_transform("EPSG:7855") |>
    mutate(area = units::set_units(st_area(geometry), "km2")) |>
    select(STE_CODE21, STE_NAME21, SAL_CODE21, SAL_NAME21, area) |>
    st_as_sf() |>
    write_sf("data/final/abs_suburbs.gpkg")
