library(raster)
library(tmap)
library(cptcity)
# reading a raster

dem <- raster('dem_01.tif')
class <- c(-Inf, 100 , 1,
            100, 150 , 2,
            150, 250 , 3,
            250, Inf ,4)

m_class <- matrix(new_class,ncol = 3,byrow = T)
r_class <- raster::reclassify(dem, m_class)
r_class <- as.factor(r_class)
levels(r_class)[[1]]$names <- c('very low','low',
                                'medium','high')
tm_shape(r_class) + 
  tm_raster(palette = cpt(pal = 'grass_bcyr',n = 4))


