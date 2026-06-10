# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)
library(dplyr)
attach(datos_limpios)

# 1. Calculamos la tabla de frecuencias para la variable discreta
frecuencias_acciones <- datos_limpios %>%
  count(Cant_areas_acciones_gob_IA) %>%
  mutate(Prop = n / sum(n))

# Graficamos la relación directa
ggplot(frecuencias_acciones, aes(x = Cant_areas_acciones_gob_IA, y = n)) +
  geom_segment(aes(xend = Cant_areas_acciones_gob_IA, yend = 0), color = "dodgerblue4", size = 1.5) +
  geom_point(color = "dodgerblue4", size = 4) +
  scale_x_continuous(breaks = 0:max(datos_limpios$Cant_areas_acciones_gob_IA)) +
  labs(
    title = "Densidad de Acciones Gubernamentales en IA",
    x = "Cantidad de Áreas con Acciones (Variable Discreta)",
    y = "Número de Países (Frecuencia)",
    caption = "Fuente: índice GIRAI 2024" # <-- Agregamos la fuente acá
  ) +

  theme_minimal() +
  
  theme(
    plot.caption = element_text(face = "italic", color = "gray30", size = 9)
  )