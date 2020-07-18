# Installing some packages necessary 
pkgs <- c('raster', 'tmap', 'cptcity','tidyverse')
install.packages(pkgs)

# Activate or calling installed packages 
library(raster)
library(tmap)
library(cptcity)
library(tidyverse)

# reading a raster
dem <- raster('../Data/DEM.gpkg')

# definition some class for raster 
class <- c( -Inf, 3000 , 1,
            3000, 3500 , 2,
            3500, 4000 , 3,
            4000, Inf  , 4)
class %>%
  matrix(ncol = 3,byrow = T) -> m_class

dem %>% 
  reclassify(m_class) %>% 
  as.factor() -> r_class

levels(r_class)[[1]]$names <- c('very low','low',
                                'medium','high')
# Map with rater layer 
r_class %>% 
tm_shape() + 
  tm_raster(palette = cpt(pal = 'grass_bcyr',
                          n = 4),
            legend.hist = TRUE) +
  tm_layout(frame = FALSE,
            legend.outside = TRUE) -> map

# Map exporting
tmap_save(tm = map,
          filename = '../Map/reclass_raster.png',
          width = 10,
          height = 5)

