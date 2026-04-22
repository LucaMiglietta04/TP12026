# Instalo los paquetes necesarios (si aún no los tengo instalados)
# install.packages("tidyverse")
# install.packages("ggplot2")
#install.packages("patchwork")

# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)
library(patchwork)

# Fijo el dataset
attach(datos_limpios)

# Cargo librerías
library(tidyverse)
library(ggplot2)

# 1. Gráfico de proporciones de la Dimensión Mejor Puntuada
g1 <- datos_limpios %>%

  count(Dimension_mejor_puntuada) %>%
  mutate(porcentaje = n / sum(n)) %>%
  
  ggplot() + 

  aes(x = reorder(Dimension_mejor_puntuada, -porcentaje), y = porcentaje) +
#  aes(x = reorder(Dimension_mejor_puntuada, -porcentaje), y = porcentaje, fill = Dimension_mejor_puntuada) +
  
  geom_bar(stat = "identity", width = 0.7, col = "black", fill = "lightgreen") +
  
  # Etiquetas de porcentaje sobre las barras
  geom_text(aes(label = scales::percent(porcentaje, accuracy = 0.1)), 
            vjust = -0.5, size = 4) +
  
  scale_y_continuous(labels = scales::percent, limits = c(0, 0.8)) +
  
  labs(y = "Porcentaje de Países", x = "Dimensión") +
#  labs(y = "Porcentaje de Países", x = "Dimensión", fill = "Categoría") +
  ggtitle("Distribución de dimensiones mejores puntuadas") +
  
  theme_classic()



# 2. Gráfico de promedios a partir de una tabla resumen
g2 <- datos_limpios %>%

  summarize(
    `ddhh` = mean(Derechos_humanos, na.rm = TRUE),
    `gob` = mean(Gobernanza_IA, na.rm = TRUE),
    `cap` = mean(Capacidades_IA, na.rm = TRUE)
  ) %>%
  
  pivot_longer(cols = everything(), 
               names_to = "Dimension", 
               values_to = "Promedio") %>%
  
  ggplot() +
  aes(x = reorder(Dimension, -Promedio), y = Promedio, fill = "lightgreen") +
#  aes(x = reorder(Dimension, -Promedio), y = Promedio, fill = Dimension) +
  
  geom_bar(stat = "identity", width = 0.6, col = "black", fill = "lightgreen") +

  geom_text(aes(label = round(Promedio, 2)), vjust = -0.5) +

  ylim(0, 50) + 
  
  labs(y = "Puntaje Promedio (0-100)", x = "Dimensión") +
  ggtitle("Comparativa de Desempeño Promedio Global") +
  
  theme_classic() +
  guides(fill = "none") 

# Generamos nuestro gráfico comparativo conjunto
g1 + g2 + plot_annotation(title = "Análisis Comparativo de Dimensiones")
