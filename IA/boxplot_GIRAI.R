# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)

# Fijo el dataset
attach(datos_limpios)

datos_limpios %>% 
  select(GIRAI) %>%
  ggplot() +
  aes(x = GIRAI, y = "") +
  geom_boxplot(width = 0.50, fill = "lightblue", outlier.size = 1) +
  
  scale_x_continuous(breaks = seq(0, 100, 10)) + 
  
  labs(y = "", x = "Valor GIRAI", caption = "Fuente: índice GIRAI 2024") +
  ggtitle("Distribución de valores GIRAI según los países") +
  
  # Fijamos el tema base
  theme_classic() + 
  
  # Tu bloque de theme
  theme(
    axis.ticks.y = element_blank(),
    plot.caption = element_text(face = "italic", color = "gray30", size = 9)
  )

# Resumen estadístico por consola
summary(datos_limpios$GIRAI)