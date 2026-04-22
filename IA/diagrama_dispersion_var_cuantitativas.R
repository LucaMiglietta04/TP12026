library(tidyverse)
library(ggplot2)
library(dplyr)
library(ggrepel)
attach(datos_limpios)


datos_resumen <- datos_limpios %>%
  group_by(NU_subregion) %>% 
  summarise(
    ddhh_mediana = median(Derechos_humanos, na.rm = TRUE),
    cant_reglas_mediana = median(Cant_areas_reglas_IA, na.rm = TRUE)
  )

ggplot(datos_resumen, aes(x = cant_reglas_mediana, y = ddhh_mediana)) +
  geom_point(size = 4, color = "darkcyan") +
  ggrepel::geom_text_repel(aes(label = NU_subregion), size = 3) + 
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "solid") +
  labs(
    title = "Relación Típica: Marcos Legales vs. Protección Real",
    subtitle = "Mediana de Reglas vs. Mediana de DDHH por Subregión",
    x = "Mediana de Áreas con Reglas (Discreta)",
    y = "Mediana de Puntaje DDHH (Continua)",
    caption = "Fuente: GIRAI 2024"
  ) +
  theme_minimal()