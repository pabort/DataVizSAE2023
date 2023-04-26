# TEMAS EN GGPLOT2 --------------------------------------------------------
# - Nos permitirá definir un estilo global para la visualización
# - Es posible emplear temas (estilos) disponibles en ggplot2 y/o editar partes de ellos

## Setup ----
library(tidyverse)
library(ggthemes)  # perimité extender los temas disponibles en ggplot2

# base de datos
file_df <- "https://raw.githubusercontent.com/pabort/DataVizSAE2023/master/pinguinos_df.csv"
df <- read_csv(url(file_df))

# Referencias
# - ggplo2 Book: https://ggplot2-book.org/polishing.html
# - ggplot tidyverse: https://ggplot2.tidyverse.org/reference/index.html#themes

# Temas de ggplot2
# - https://ggplot2.tidyverse.org/reference/index.html#themes

p <- ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm, color = especie)) +
  geom_point() +
  labs(x = 'Longitud aleta (mm)', y = 'Longitud pico (mm)', color = 'Especie:') 
p

# Temas disponibles en {ggtheme}
# - https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/

ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm, color = especie)) +
  geom_point() +
  labs(x = 'Longitud aleta (mm)', y = 'Longitud pico (mm)', color = 'Especie:') +
  theme_economist() # también se pue definir el `color`  scale_color_economist()

# Uso de fuentes
# install.packages("showtext")
library(showtext)

font_add_google("Roboto Condensed",  # nombre de la fuente en Google Font
                "RobotoCondensed")  # nombre con la que se usará en R

p + 
  theme_bw(base_size = 12, base_family = "Roboto Condensed")
