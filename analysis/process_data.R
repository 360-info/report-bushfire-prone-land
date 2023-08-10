library(tidyverse)
library(sf)
library(mapview)

# ACT-----------------------------------------------------

act_unzip <- unzip("data/raw/act_bf_raw.zip", exdir = "data/staging/act")

read_sf("data/staging/act/Bushfire_Prone_Areas.shp") |>
    st_transform("EPSG:3857") |>
    mutate(
        state = "ACT",
        rating = "default"
    ) |>
    select(state, rating)  |>
    st_as_sf()  |>
    write_sf("data/staging/act.gpkg")

# ACT-----------------------------------------------------