#' Unzip Raw
#' Unzips the raw downloaded data and places into a staging folder to later analysis.
#' Refer to the `data/README.md` for details

# ABS Suburbs data
unzip(here("data/raw/SAL_2021_AUST_GDA2020_SHP.zip"), exdir = here("data/staging/ABS"))

# ACT
unzip(here("data/raw/act_bf_raw.zip"), exdir = here("data/staging/act"))

# NT
unzip(here("data/raw/nt_bf_raw.zip"), exdir = here("data/staging/nt"))

# NSW
unzip(here("data/raw/nsw_bf_raw.zip"), exdir = here("data/staging/nsw"))

# SA
unzip(here("data/raw/sa_bf_raw.zip"), exdir = here("data/staging/sa"))

# WA
unzip(here("data/raw/wa_bf_raw.zip"), exdir = here("data/staging/wa"))

# VIC
unzip(here("data/raw/vic_bf_raw.zip"), exdir = here("data/staging/vic/bfp"))
unzip(here("data/raw/vic_bmo_raw.zip"), exdir = here("data/staging/vic/bmo"))

# TAS
unzip(here("data/raw/tas_bf_raw.zip"), exdir = here("data/staging/tas/bf"))
unzip(here("data/raw/tas_bf1_raw.zip"), exdir = here("data/staging/tas/bf1"))

# QLD
unzip_qld_files <- function(path) {
    unzip(path, exdir = here("data/staging/qld"))
}

files <- list.files(here("data/raw"), pattern = "^qld", full.names = TRUE)
map(files, unzip_qld_files)
