# Data  

## `bf-prone-processed.csv`

Processed statistics on the fraction of each suburb that is covered by a state government "bushfire prone area", "fire protection area" or similarly named overlay.

This Australia-wide dataset combines all state and territory agency datasets describing land areas classified as 'Bushfire Prone'. Definitions and methodologies vary widely from state-to-state. This map attempts to unify the basic definitions to contrast policy and highlight considerations for planning, the built environment and living with fire.

Columns include:

- `STE_CODE21`: state code from the Australian Bureau of Statistics
- `STE_NAME21`: state name from the ABS
- `SAL_CODE21`: suburb code from the ABS
- `SAL_NAME21`: suburb code from the ABS
- `area`: area of the suburb in square kilometres
- `bf_area`: area of the suburb in square kilometres that is bushfire prone (or similar)
- `bf_area_pct`: fraction of the suburb (0 to 1) that is bushfire prone (or similar)
- `cent_lat`: latitude of the suburb's centroid (using the largest polygon)
- `cent_lon`: longitude of the suburb's centroid (using the largest polygon)

Produced by `/analysis/BFP`.

## `/final/anim`, `/final/anim_wa`

Processed image sequence (on a transparent background) of burnt areas of south-east Australia (`anim`) and Western Australia (`anim_wa`) over time, for compositing in video.

Produced by `/analysis/burned_area`.

## `/suburb-tiles`

Vector tiles based on the Australian Bureau of Statistics' [ASGS Edition 3 Suburbs and Localities](https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files) (licensed under [CC BY 4.0](https://www.abs.gov.au/website-privacy-copyright-and-disclaimer#copyright-and-creative-commons)).

To generate the tiles from the ABS shapefile (assuming it has been downloaded as a shapefile and unzipped), use `ogr2ogr` and `tippecanoe`:

```sh
# convert shapefile to wgs84 geojson
ogr2ogr -f GeoJSON suburbs.geojson SAL_2021_AUST_GDA2020_SHP/SAL_2021_AUST_GDA2020.shp

# turn geojson into directory of tiles
tippecanoe -zg --no-tile-compression --output-to-directory suburb-tiles suburbs.geojson
```


## Not included with the repository

### Bushfire prone land datasets (`raw/fire_history`)

These data are the raw downloads from the state agencies. They are not included with the repository, but the analysis scripts require them to be present.

#### NSW  

**File:** `data/raw/nsw_bf_raw.zip`  
**Link:** https://datasets.seed.nsw.gov.au/dataset/bush-fire-prone-land  
**Metadata:** https://datasets.seed.nsw.gov.au/dataset/bush-fire-prone-land  
**User Guide:** http://www.rfs.nsw.gov.au/__data/assets/pdf_file/0011/4412/Guideline-for-Councils-to-Bushfire-Prone-Area-Land-Mapping.pdf  
**Licence:** [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)  
**Date Accessed:** 2023-08-10  

#### QLD  

**File:**                     
    `"data/raw/qld_capeyork_bf_raw.zip"`                   
    `"data/raw/qld_centralqueensland_bf_raw.zip"`        
    `"data/raw/qld_centralwestqueensland_bf_raw.zip"`    
    `"data/raw/qld_darlingdowns_bf_raw.zip"`             
    `"data/raw/qld_farnorthqueensland_bf_raw.zip"`        
    `"data/raw/qld_mackayisaacandwhitsunday_bf_raw.zip"` 
    `"data/raw/qld_northqueensland_bf_raw.zip"`            
    `"data/raw/qld_northwestqueensland_bf_raw.zip"`      
    `"data/raw/qld_southeastqueensland_bf_raw.zip"`       
    `"data/raw/qld_southerngulfofcarpentaria_bf_raw.zip"`
    `"data/raw/qld_southwestqueensland_bf_raw.zip"`       
    `"data/raw/qld_widebayburnett_bf_raw.zip"`            

**Link:** https://www.data.qld.gov.au/dataset/bushfire-prone-area-queensland-series  
**Metadata:** https://www.data.qld.gov.au/dataset/bushfire-prone-area-queensland-series/resource/c157d61a-ce1e-4834-a35d-d94ae2421e5a  
**User Guide:** https://www.data.qld.gov.au/dataset/bushfire-hazard-area-bushfire-prone-area-mapping-methodology-for-queensland  
**Licence:** [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)    
**Date Accessed:** 2023-08-10   

#### VIC 

**File:** 
    `data/raw/vic_bf_raw.zip`  
    `data/raw/vic_bmo_raw.zip`  
**Link:** https://discover.data.vic.gov.au/dataset/designated-bushfire-prone-area-bpa2   
**Metadata:** https://metashare.maps.vic.gov.au/geonetwork/srv/api/records/93136d30-5c02-597f-bdec-c26928766b41/formatters/sdm-html?root=html&output=html   
**User Guide:** https://www.planning.vic.gov.au/guides-and-resources/guides/all-guides/bushfire-map-reviews  
**Licence:** [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)  
**Date Accessed:** 2023-08-10  

#### SA  

**File:** `data/raw/sa_bf_raw.zip`  
**Link:** https://data.sa.gov.au/data/dataset/bushfire-protection-areas  
**Metadata:** https://data.sa.gov.au/data/dataset/bushfire-protection-areas/resource/81b2721e-fbd8-482e-ab0a-d84a55ecb496?inner_span=True  
**User Guide:** https://data.sa.gov.au/data/dataset/bushfire-protection-areas   
**Licence:** [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)  
**Date Accessed:** 2023-08-10  

#### ACT  

**File:** `data/raw/act_bf_raw.zip`  
**Link:** https://actmapi-actgov.opendata.arcgis.com/datasets/7c4ae4305e6b43cfb2135cf7fde498f4/about  
**Metadata:** https://www.arcgis.com/sharing/rest/content/items/7c4ae4305e6b43cfb2135cf7fde498f4/info/metadata/metadata.xml?format=default&output=html   
**User Guide:** https://www.data.act.gov.au/dataset/Bushfire-Prone-Areas/5yyj-ridt  
**Licence:** [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)   
**Date Accessed:** 2023-08-10    

#### WA 

**File:** `data/raw/wa_bf_raw.zip`   
**Link:** https://catalogue.data.wa.gov.au/dataset/bush-fire-prone-areas-2021-obrm-019  
**Metadata:** https://services.slip.wa.gov.au/public/rest/services/SLIP_Public_Services/Bush_Fire_Prone_Areas/MapServer/16  
**User Guide:** https://www.dfes.wa.gov.au/waemergencyandriskmanagement/obrm/Documents/OBRM-Map-of-Bush-Fire-Prone-Areas-FAQ.pdf  
**Licence:** [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)  
**Date Accessed:** 2023-08-10    

#### NT

**File:** `data/raw/nt_bf_raw.zip`  
**Link:** https://nt.gov.au/emergency/bushfire/prepare-and-plan/fire-protection-zones  
**Metadata:** https://nt.gov.au/emergency/bushfire/prepare-and-plan/fire-protection-zones  
**User Guide:** https://nt.gov.au/emergency/bushfire/prepare-and-plan/fire-protection-zones  
**Licence:** [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)  
**Date Accessed:** 2023-08-10    

#### TAS

**File:**  
    `data/raw/tas_bf_raw.zip`  
    `data/raw/tas_bf1_raw.zip`  
**Link:** https://listdata.thelist.tas.gov.au/opendata/  
**Metadata:** https://www.thelist.tas.gov.au/app/content/data/geo-meta-data-record?detailRecordUID=d4c9d9cd-ef64-4fdd-917d-a757c67db697   
**User Guide:** https://www.fire.tas.gov.au/Show?pageId=colBushfireProneAreas   
**Licence:** [Creative Commons Attribution 3.0 Australia](https://creativecommons.org/licenses/by/3.0/au/)   
**Date Accessed:** 2023-08-10   

### Historical bushfire boundaries

Locations and extents of historical bushfires and burning events, from Geoscience Australia (GA).  

**file:** `data/fire_history/Historical_Bushfire_Boundaries.geojson`   
**Link:** https://digital.atlas.gov.au/datasets/f2553df517b24672bc931afc9f3f8ac3_17/about  
**Licence:** [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)  

The animated fire extents exported from this raw data source are stored as a library of `.png` files in `data/final/anim` and are projected using the below CRS. See `analysis/burned_area/burned_area.qmd` for more details. 

```
Coordinate Reference System:
  User input: EPSG:3857 
  wkt:
PROJCRS["WGS 84 / Pseudo-Mercator",
    BASEGEOGCRS["WGS 84",
        ENSEMBLE["World Geodetic System 1984 ensemble",
            MEMBER["World Geodetic System 1984 (Transit)"],
            MEMBER["World Geodetic System 1984 (G730)"],
            MEMBER["World Geodetic System 1984 (G873)"],
            MEMBER["World Geodetic System 1984 (G1150)"],
            MEMBER["World Geodetic System 1984 (G1674)"],
            MEMBER["World Geodetic System 1984 (G1762)"],
            MEMBER["World Geodetic System 1984 (G2139)"],
            ELLIPSOID["WGS 84",6378137,298.257223563,
                LENGTHUNIT["metre",1]],
            ENSEMBLEACCURACY[2.0]],
        PRIMEM["Greenwich",0,
            ANGLEUNIT["degree",0.0174532925199433]],
        ID["EPSG",4326]],
    CONVERSION["Popular Visualisation Pseudo-Mercator",
        METHOD["Popular Visualisation Pseudo Mercator",
            ID["EPSG",1024]],
        PARAMETER["Latitude of natural origin",0,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8801]],
        PARAMETER["Longitude of natural origin",0,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8802]],
        PARAMETER["False easting",0,
            LENGTHUNIT["metre",1],
            ID["EPSG",8806]],
        PARAMETER["False northing",0,
            LENGTHUNIT["metre",1],
            ID["EPSG",8807]]],
    CS[Cartesian,2],
        AXIS["easting (X)",east,
            ORDER[1],
            LENGTHUNIT["metre",1]],
        AXIS["northing (Y)",north,
            ORDER[2],
            LENGTHUNIT["metre",1]],
    USAGE[
        SCOPE["Web mapping and visualisation."],
        AREA["World between 85.06°S and 85.06°N."],
        BBOX[-85.06,-180,85.06,180]],
    ID["EPSG",3857]]
```
