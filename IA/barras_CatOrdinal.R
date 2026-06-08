library(tidyverse) 
attach(datos_limpios)

datos <- datos %>%
  mutate(Actores_no_estatales_sec = factor(
    Actores_no_estatales_sec, 
    levels = c("Muy bajo", "Bajo", "Medio", "Alto", "Muy alto"),
    ordered = TRUE
  ))

# ==========================================
# GRÁFICO DE BARRAS UNIVARIADO 
# ==========================================

ggplot(datos, aes(x = Actores_no_estatales_sec)) +
  geom_bar(fill = "deeppink3") +
  labs(
    title = "Distribución Global del Desarrollo de Actores No Estatales",
    subtitle = "Análisis univariado sobre el total de países relevados",
    x = "Nivel de Desarrollo (Fuentes Secundarias)",
    y = "Cantidad de Países"
  ) +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank() 
  )