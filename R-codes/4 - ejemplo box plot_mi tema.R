# Elegir Tema por defecto (definido con la función: `mi_tema()` en "3 - funcion-mitema.R"
theme_set(mi_tema())
# La siguiente línea, nos uede servir para actualizar el tema por defecto
#mi_tema <- theme_update(panel.background = element_rect(fill = "orange"))

p <- ggplot(df, aes(x= especie, y = peso_g, fill = especie)) +
  geom_boxplot() +
  labs(x = NULL, 
       y = 'Peso (g)',
       title = 'Pingüinos de Palmer (Antártida)',
       subtitle = 'Peso por especie',
       caption = 'Fuente: Curso SAE en base a datos de Gorman 2020',
       fill = NULL) +
  mi_tema()
p

# Podemos incorporar la media en los boxplot con la función 
# `stat_summary()`: es una capa más, como una geometría, pero con una denominación particular

p +
  stat_summary(fun=mean, geom="point", color="white", size=2) +
  guides(color = "none")  # Para eeliminar la leyenda redundante por la capa anterior
  
  
# -----------------------------------------------------------
# Agregar imagen/logo a los gráficos (por ejemplo un logo)
# Necesitaremos tener instaladas las siguientes librerías:
# `png`, `RCurl` y `grid`
# Se puede incoporar cualquier imagen, en cualquier posición
# -----------------------------------------------------------

# Leemos la url o ruta del directorio donde está guardada la imagen (con el nombre de la imagen inluido)
# (en este caso, el logo de ggplot2)
path <- "https://raw.githubusercontent.com/pabort/DataVizSAE2023/master/logo_ggplot2.png"
# Leemos la imagen en R (no es necesaria usar `getURLContent` si tenemos la imagen alojada en nuestro directorio)
img <- png::readPNG(RCurl::getURLContent(path))
# Rsterizamos la imagen para poder trabajarla en el "lienzo" del plot
img_r <- grid::rasterGrob(img, interpolate = T)

# Ahora si incorporamos la imagen con la función `annotation_custom`
# Deberemos elegir la coordenada donde estará posicionada, atendiendo
# a la escala de las variables representadas en los ejes (es conveniente verlo el resultado de manera externa, con el Zoom)
# En este caso, lo ubicamoss arriba a la derecha (jugando con los argumentos: `ymax`, `imin`, etc, puede ubicarse en cualquier parte del gráfico)
p <- p +
  annotation_custom(img_r, ymin = 6500, ymax = 7300, xmin = 2.8, xmax = 4) +
  coord_cartesian(clip = "off")  # `clip = "off"` nos perite la imagen puede posicionarse por fuera de las coordenadas de los gráficos (caso contrario no se podría ver)
p

# -----------------
# Guardar plot
# -----------------
ggsave("boxplot.png", plot = p, width = 8, height = 6) # al guardar, es importante definir un tamañoa adecuado que no distorsione los elementos
