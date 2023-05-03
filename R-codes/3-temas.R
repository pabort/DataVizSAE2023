# ------------------------------------------------------------------------- 
# TEMAS EN GGPLOT2 --------------------------------------------------------
# -------------------------------------------------------------------------

# - Nos permitirá definir un estilo global para la visualización
# - Es posible emplear temas (estilos) disponibles en ggplot2 y/o editar partes de ellos

## Setup ----
library(tidyverse)
library(ggthemes)  # perimité extender los temas disponibles en ggplot2

# base de datos
file_df <- "https://raw.githubusercontent.com/pabort/DataVizSAE2023/master/pinguinos_df.csv"
df <- read_csv(url(file_df))

# ------------------------------------------------------------------------------
# Referencias ----
# - ggplot2 Book: https://ggplot2-book.org/polishing.html
# - ggplot tidyverse: https://ggplot2.tidyverse.org/reference/index.html#themes
# - Temas de ggplot2: https://ggplot2.tidyverse.org/reference/index.html#themes
# ------------------------------------------------------------------------------

# Gráfico `base`
p <- ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm, color = especie)) +
  geom_point() +
  labs(x = 'Longitud aleta (mm)', 
       y = 'Longitud pico (mm)',
       title = 'Pingüinos de Palmer (Antártida)',
       subtitle = 'Dimensiones por especie',
       caption = 'Fuente: Curso SAE en base a datos de Gorman 2020',
       color = 'Especie:') 
p

# `ggplot2` tiene 8 temas por defecto que se pueden agregar
# como una capa más: `theme_*()`

# - theme_gray (default)
# - theme_bw
# - theme_linedraw
# - theme_light
# - theme_dark
# - theme_minimal
# - theme_classic
# - theme_void

p + theme_minimal()

#---------------
# {ggthemes}
# - https://github.com/BTJ01/ggthemes/
# - Extiende la cantidad de temas, escalas y geometrías disponibles en `{ggplot}`
# - Ejemplo temas disponibles: https://github.com/BTJ01/ggthemes/tree/master/inst/examples
#---------------

# Temas disponibles en {ggtheme}
# - https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/

ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm, color = especie)) +
  geom_point() +
  labs(x = 'Longitud aleta (mm)', y = 'Longitud pico (mm)', color = 'Especie:') +
  theme_economist() # también se puede definir la paltea de colores `color`  scale_color_economist()


# --------------------
# Otras librerías con temas basados en tipografías adicionales:
# {hrbrthemes}
# - https://github.com/hrbrmstr/hrbrthemes
# --------------------


# ----------------------------------------------------------------
# CREAR NUESTROS PROPIOS TEMAS ----
# ----------------------------------------------------------------

# Podemos ver todos los argumentos del tema ejecutando la función `theme_gray` (default)
theme_gray

# Alteraremos algunos de los argumentos, partiendo del tema `minimal`
(p1 <- p + theme_bw())


## A1) CAMBIO EN LAS FUENTES DE TODOS LOS ELEMENTOS ----
# Todos los temas tienen como argumento 
# - `base_size`: tamaño base (de referencia) de la fuente
# - `base_family`: familia tipográfica utilizada

# ---------------------------------------------------------
# La librería `showtext` nos perite trabajar con fuentes 
# en nuestro sitema operativo de manera sencilla
# install.packages("showtext")
library(showtext)

# Fuentes gratuitas de Google Fonts: https://fonts.google.com/

font_add_google("IBM Plex Sans",  # nombre de la fuente en Google Font
                "IBM Plex Sans")  # nombre con la que se usará en R



# ---------------------------------------------------------

p + 
  theme_minimal(base_size = 14, base_family = "Roboto Condensed") 

## A2) CAMBIOS EL EL "GROSOR" DE LÍNEAS Y RECTAS
# También se define como argumentos de la función `theme_*()`
p + 
  theme_bw(base_line_size = 1, base_rect_size = 1)


# B. MODIFICACIÓN DE OTROS ELEMENTOS DE TEMAS ----

# Podemos basarnos en un `theme_*()` particular, y luego añadir una 
# nueva capa con a función `theme()` ddonde podremos "alterar" otros
# elementos del tema

## B1. TÍTULOS ----
p1 +
  theme(plot.title = element_text(face = "bold",    # podemos elegir `bold`, `italic`, `bold.italic`
                                  margin = margin(10, 0, 10, 0),  # t, r, b, l
                                  size = 14))

# la función `element_text()` trabaja de la misma manera para:
# `plot.subtitle`, `plot.caption`, `legend.title`, `legend.text`, `axis.title`, `axis.text`.

# B2. Posición del título

# Forma 1: argumento `hajust` en `element_text`: asume valores entre [0,1]
p1 +
  theme(plot.title = element_text(face = "bold",
                                  size = 14,
                                  hjust = 1))

# Forma 2: usar función `plot.title.position`
# (tambié disponible: `plot.caption.position`)
p1 +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")  # la opción por defecto es "panel"

# B2. Usar tipografías particulares solo para el título

p +
  theme(plot.title = element_text(family = "Lobster Two", size = 16),
        plot.subtitle = element_text(family = "Roboto Condensed", size = 14))

# C. LEGENDAS

# C1. Remover Leyendas (agregados desde la variable `color` o `shape` en `aes`)
p1 +
  theme(legend.position = "none")

# alternativamente podría haber usado una nueva capa: `guides(color = "none")` o ``guides(shape = "none")``

ggplot(df, aes(x = aleta_long_mm, y = pico_prof_mm, color = especie, shape = sexo)) +
  geom_point() +
  labs(x = 'Longitud aleta (mm)', y = 'Longitud pico (mm)', color = 'Especie:') +
  guides(shape = "none")

# C2. Remover el título de la legenda
p1 +
  theme(legend.title = element_blank())

# alternativamente, puede incorporarse `NULL` como argumento en la capa de `labs`: `labs(color = NULL)`

# C3. Posición de la legenda: `legend.position = "*"`
# opciones: “top”, “right” (definida por default), “bottom”, y “left”.
p1 +
  theme(legend.position = "bottom")

# También puede ubicarse en cualquier parte del gráfico, indicando
# la cordenada `c(x, y)`
p1 +
  theme(legend.title = element_blank(),
        legend.position = c(0.85, 0.8),
        legend.background = element_rect(fill = "transparent"))  # esto hacer transparente la "caja" que contiene las leyendas

# la función `guide_legend()` permite controlar la direcció de la leyenda
p1 +
  theme(legend.position = "bottom") +
  guides(color = guide_legend(direction = "vertical"))

p1 +
  theme(legend.title = element_blank(),
        legend.position = c(0.8, 0.9),
        legend.background = element_rect(fill = "transparent")) +
  guides(color = guide_legend(direction = "horizontal"))

# `guide_legend` también permite cambiar el título de las leyendass

# C4. Cambiar estilo (estética) del texto de leyenda
p1 +
  theme(legend.title = element_text(family = "Lobster Two",
                                    color = "#9A180A",
                                    face = "bold",
                                    size = 14))

# De igual manera podemos cambiar el texto de las leyendas: `legend.text`

# Relleno de las "cajas" que contienen los símbolos de las leyendas
# `legend.key = element_rect(fill = "*")`
p1 +
  theme(legend.title = element_text(family = "Lobster Two",
                                    color = "#9A180A",
                                    face = "bold",
                                    size = 14),
        legend.key = element_rect(fill = "orange"))


# D. Fondos (Background) y cuadícula (Grid Lines)

# D1. Fondos: `panel.background`
p1 +
  theme(panel.background = element_rect(
    fill = "#64D2AA", color = "#64D2AA", size = 1)
  )

# sobre la capa `panel.background` hay una capa transparente: `panel.border`, que también puede cambiar

p1 +
  theme(panel.border = element_rect(
    fill = "#64D2AA99", color = "#64D2AA", size = 2))

# D2. Cuadícula (grids)
# puede especificarse con `panel.grid`
p1 +
  theme(panel.grid.major = element_line(color = "orange", size = .5),
        panel.grid.minor = element_line(color = "gray70", size = .25))

# y se puede ser muy específico
p1 +
  theme(panel.grid.major = element_line(size = .5, linetype = "dashed"),
        panel.grid.minor = element_line(size = .25, linetype = "dotted"),
        panel.grid.major.x = element_line(color = "red1"),
        panel.grid.major.y = element_line(color = "blue1"),
        panel.grid.minor.x = element_line(color = "red4"),
        panel.grid.minor.y = element_line(color = "blue4"))

# Se pueden remover la cuadrícula usando `element_blank()` (en cualquiera de los niveles de `panel.grid`)
p1 +
  theme(panel.grid.minor = element_blank())

# E. Color de fondo de todo el gráfico
p1 + 
  theme(plot.background = element_rect(fill = "orange",
                                       color = "red4", size = 3))

# F. MÁRGENES DEL GRÁFICO: `plot.margin`

p1 + 
  theme(plot.background = element_rect(fill = "orange",
                                       color = "red4", size = 3),
        plot.margin = margin(t = 1, r = 1, b = 1, l = 1, unit = "cm"))


#### USAR UN TEMA DEFINIDO ----
# vero modificación en "3 - duncion-mi-tema.R"
p1 +
  mi_tema()

# Alternativamente, se puede l tema por defecto
theme_set(theme_gray())

# También se puede actualizar el tema por defecto con `theme_update()`
