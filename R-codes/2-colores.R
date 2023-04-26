# TRABAJANDO CON COLORES EN GGPLOT ----------------------------------------

## SETUP ----
library(tidyverse)

# base de datos
file_df <- "https://raw.githubusercontent.com/pabort/DataVizSAE2023/master/pinguinos_df.csv"
df <- read_csv(url(file_df))

# Referencias
# - definición de Colores en R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf 
# - trabajando con colores en ggplot2: https://r-graph-gallery.com/ggplot2-color.html
# - R Cookbook: http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

# 1. Los colores se ppueden definir en `color` y `fill`
# `color`: especifica el color del contorno
# `fill`: color del relleno

ggplot(df, aes(x = especie, y = peso_g, fill = especie)) +
  geom_boxplot(color = 'grey', size = 0.5) +
  labs(x = 'Especie', y = 'Peso (gramos)', fill = 'Especie:')

# 2. Especificando un color único para la geometría

ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm)) +
  geom_point(color = 'steelblue', size = 2) +
  #  geom_point(color = 'steelblue', fill = 'red', shape = 21, size = 2) + # stroke=1
  labs(x = 'Longitud aleta (mm)', y = 'Longitud pico (mm)')


# ASIGNAR COLOR A VARIABLES ----
# - Se puede modeoficar colores de variables definidas en `aes()`
# - Los colores se modefican mediante: `scale_color_*` y/o `scale_fill_*`
# - La elección de una paleta de colores está condicionada al tipo: categóricas y continuas

## VARIABLES CATEGÓRICAS ----

# Colores por default
p <- ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm, color = especie)) +
  geom_point() +
  labs(x = 'Longitud aleta (mm)', y = 'Longitud pico (mm)', color = NULL) 
p

# 3. Selección manual de colores
p + scale_color_manual(values = c('dodgerblue4',
                                  'goldenrod1',
                                  'darkorchid3'))
                                  
# Paletas de colores (cualitativas) incorporadas

# - ColorBrewer: https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3
# - las paaletas están disponibles en `{ggplot2}`
# - para usarla, debemos llamar a la función: `scale_*_brewer()`
# - Consultar paleta de colores definidas: `RColorBrewer::display.brewer.all()`

p + scale_color_brewer(palette = 'Set3')

# Paletas disponibles en otros paquetes

# - {ggthemes}: https://jrnold.github.io/ggthemes/reference/index.html#section-color-scales
#   En las 'ayudas' de cada función suele dar alguna referencia de los colores de la paleta

library(ggthemes)
p + scale_color_tableau()


# - {ggsci}: https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html
#   paleta de colores de journals científicos y algunass revista de ciencia ficción
#install.packages('ggsci')
library(ggsci)

p + scale_color_aaas()

# Se queremos ver la comopsición de paleta de colores:
# paleta <- pal_aaas("default")(9) # nos permite obtener los códigos Hex de la paleta
# library(scales)
# show_col(paleta) # permite ver gráficamente la paleta


## VARIABLES CUANTITATIVAS ----
# Utilizaremos dos funciones alternativamente:
# - `scale_*_gradient()`: escala (gradiente) secuencial
# - `scale_*_gradient2()`: escala (gradiente) divergente

p <- ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm, color = peso_g)) +
  geom_point() +
  labs(x = 'Longitud aleta (mm)', y = 'Longitud pico (mm)', color = 'Peso (g)') 

p + scale_color_continuous()  # definida por defaul
p + scale_color_gradient()

peso_medio <- mean(df$peso_g, na.rm = TRUE)

p + scale_color_gradient2(midpoint = peso_medio)

# Definción manual del color
# - Escala secuencial: `scale_*_gradient()`
p + scale_color_gradient(low = "darkkhaki",
                         high = "darkgreen")

# - Escala divergente: `scale_*_gradient2()`

p + scale_color_gradient2(midpoint = peso_medio, 
                          low = "#dd8a0b",
                          mid = "grey",
                          high = "#32a676")

# Paletas de colores (cuantitativas) incorporadas
# Paleta `viridis`: https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html#the-color-scales
# - Fácil de visulaizalizar para daltónicos
# - Buena impresión en escala de grises
# - Opciones: “magma”, “plasma”, “inferno”, “viridis”,“cividis”, “mako”, “rocket”, “turbo” (alternativa rainbow).

p + scale_color_viridis_c(option = 'cividis') 

# - esta paleta también puede ser usada vara variables discretas/categóricas
ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm, color = especie)) +
  geom_point() +
  labs(x = 'Longitud aleta (mm)', y = 'Longitud pico (mm)', color = NULL) +
  scale_color_viridis_d()

# Paletas disponibles en otros paquetes
# - {rcartocolor}: https://github.com/Nowosad/rcartocolor
# install.packages('rcartocolor')
library(rcartocolor)
p + scale_color_carto_c(palette = "BurgYl")

# - {scico}: https://github.com/thomasp85/scico
# install.packages('scico')
library(scico)
p + scale_color_scico(palette = "berlin")
