library(tidyverse)
library(ggplot2)
library(dplyr)
attach(datos_limpios)


# Gráfico de Dispersión para el Punto 10
ggplot(datos_limpios, aes(x = Cant_areas_reglas_IA, y = Derechos_humanos)) +
  # Usamos jitter para que los puntos "vibren" un poco y se vean todos
  geom_jitter(color = "darkcyan", alpha = 0.6, width = 0.2) + 
  # Añadimos la línea de tendencia lineal
  geom_smooth(method = "lm", color = "red", se = TRUE) + 
  labs(
    title = "Relación: Marcos Legales vs. Protección Real",
    subtitle = "Vínculo entre la cantidad de áreas reguladas y el puntaje de DDHH",
    x = "Cantidad de Áreas con Reglas (Discreta)",
    y = "Puntaje de Derechos Humanos (Continua)",
    caption = "Fuente: GIRAI 2024"
  ) +
  theme_minimal()