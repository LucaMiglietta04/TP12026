# Instalo los paquetes necesarios (si aún no los tengo instalados)
# install.packages("tidyverse")
# install.packages("ggplot2")

# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)

# Fijo el dataset
attach(datos_limpios)

#####################
# Gráfico de barras #
#####################

# 1. Preparación de los datos

resumen_dimensiones <- datos_limpios %>%
  count(Dimension_mejor_puntuada) %>% 
  rename(dimension = Dimension_mejor_puntuada, conteo = n) %>%
  mutate(porcentaje = (conteo / sum(conteo)) * 100)

# 2. Generación del gráfico

ggplot(resumen_dimensiones) +
  aes(x = reorder(dimension, -conteo), y = conteo) + # Ordenado de mayor a menor 
  geom_col(width = 0.6, 
           fill = '#FFE4E1', 
           col = "black") +
  geom_text(aes(label = paste0(conteo, " (", round(porcentaje, 1), "%)")), 
            vjust = -0.5,      
            size = 4,          
            fontface = "bold") + 
  labs(
    title = "Prioridades Globales en IA Responsable",
    subtitle = "Frecuencia y porcentaje de la dimensión con mayor puntaje por país",
    x = "Dimensión",
    y = "Cantidad de países",
    caption = "Fuente: Índice Global de IA Responsable (GIRAI) 2024"
  ) +
  scale_y_continuous(limits = c(0, max(resumen_dimensiones$conteo) * 1.1)) + #para que no corte
  theme_classic()
