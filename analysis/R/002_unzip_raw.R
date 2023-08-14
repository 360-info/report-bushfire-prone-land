#' Unzip Raw
#' Unzips the raw downloaded data and places into a staging folder to later analysis.
#' Refer to the `data/REAME.md` for details

# ABS Suburbs data
unzip("data/raw/SAL_2021_AUST_GDA2020_SHP.zip", exdir = "data/staging/ABS")

# ACT
unzip("data/raw/act_bf_raw.zip", exdir = "data/staging/act")

# NT 
unzip("data/raw/nt_bf_raw.zip", exdir = "data/staging/nt")

# NSW 
unzip("data/raw/nsw_bf_raw.zip", exdir = "data/staging/nsw")

# SA
unzip("data/raw/sa_bf_raw.zip", exdir = "data/staging/sa")

# WA
unzip("data/raw/wa_bf_raw.zip", exdir = "data/staging/wa")

# VIC
unzip("data/raw/vic_bf_raw.zip", exdir = "data/staging/vic/bfp")
unzip("data/raw/vic_bmo_raw.zip", exdir = "data/staging/vic/bmo")

# TAS
unzip("data/raw/tas_bf_raw.zip", exdir = "data/staging/tas/bf")
unzip("data/raw/tas_bf1_raw.zip", exdir = "data/staging/tas/bf1")

# QLD
unzip_qld_files <- function(path) {
    unzip(path, exdir = "data/staging/qld")
}

files <- list.files("data/raw", pattern = "^qld", full.names = TRUE)
map(files, unzip_qld_files)