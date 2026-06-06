library(tidyverse)
attach(datos_limpios)
# Nos aseguramos de que las categorías estén ordenadas
datos <- datos %>%
  mutate(Actores_no_estatales_sec = factor(
    Actores_no_estatales_sec, 
    levels = c("Muy bajo", "Bajo", "Medio", "Alto", "Muy alto"),
    ordered = TRUE
  ))

# GRÁFICO HORIZONTAL NORMADO
ggplot(datos, aes(y = UN_subregion, fill = Actores_no_estatales_sec)) +
  geom_bar(position = "fill") + # Hace que todas las barras miden 100% (proporción)
  scale_fill_brewer(palette = "PuRd") + # Degradé estético y sofisticado (púrpura/rosa) de claro a oscuro
  labs(
    title = "Estructura de Actores No Estatales por Subregión",
    subtitle = "Análisis proporcional sobre el total de países relevados por zona",
    x = "Proporción (0 a 1)",
    y = "Subregión de la ONU",
    fill = "Nivel de Desarrollo"
  ) +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank(),
    legend.position = "bottom" # Pasamos la leyenda abajo para dar más espacio de lectura
  )