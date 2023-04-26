# Lectura de base de datos

file_df <- "https://raw.githubusercontent.com/pabort/DataVizSAE2023/master/pinguinos_df.csv"

df <- read_csv(url(file_df))
# librerías a instalar/cargar
# install.packages("ggplot2")
# install.packages("dplyr")
#
# Alternativamente, 'tidyverse' incluye estas y más

library(tidyverse)

# base de datos
file_df <- "https://raw.githubusercontent.com/pabort/DataVizSAE2023/master/pinguinos_df.csv"

df <- read_csv(url(file_df))


ggplot(data = df,
       mapping = aes(x = aleta_long_mm, y = peso_g)) +
  geom_point()


# plot 2
ggplot(data = df) +
  geom_point(mapping = aes(x = aleta_long_mm,
                           y = peso_g,
                           colour = especie))


# plot 2
ggplot(data = df) +
  geom_point(mapping = aes(x = aleta_long_mm,
                           y = peso_g),
             colour = 'blue')

# plot 3
ggplot(data = df) +
  geom_point(mapping = aes(x = aleta_long_mm,
                           y = peso_g,
                           shape = aleta_long_mm > 200))

# plot 2


ggplot(data = na.omit(df),
       mapping = aes(x = sexo, y = peso_g)) +
  geom_jitter(aes(colour = especie), na.rm = TRUE) +
  geom_boxplot(na.rm = TRUE)


# barplot
df_cant <- df %>% 
  count(especie, name = 'cantidad')

ggplot(data = df_cant) +
  geom_bar(mapping = aes(x = especie, y = cantidad),
           stat = 'identity')

# Densidad

ggplot(data = df) +
  geom_histogram(aes(x = peso_g)) +
  geom_density(aes(x = peso_g))

# 

ggplot(data = df) +
  geom_point(mapping = aes(x = aleta_long_mm,
                           y = peso_g,
                           colour = especie)) +
  scale_colour_brewer(type = 'seq')

#
ggplot(data = df) +
  geom_point(mapping = aes(x = aleta_long_mm, y = peso_g)) +
  scale_x_continuous(breaks = c(180, 200, 220)) +
  scale_y_continuous(limits = c(0,NA))

#
ggplot(na.omit(df)) +
  geom_point(aes(x = aleta_long_mm, y = peso_g)) +
  facet_wrap(sexo ~ especie, ncol = 2)
