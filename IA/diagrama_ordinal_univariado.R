library(tidyverse)
library(ggplot2)
attach(datos_limpios)

niveles_ordenados <- c("Muy Bajo", "Bajo", "Medio", "Alto", "Muy Alto")
umbral <- quantile(datos_limpios$GIRAI,0.25, na.rm = TRUE)

paises_criticos <- datos_limpios %>%
  filter(GIRAI <= umbral) %>%
  filter(!is.na(Marcos_fuentes_sec), 
         !is.na(Acciones_fuentes_sec), 
         !is.na(Actores_no_estatales_sec)) %>%
  mutate(Validacion_Global = factor(Marcos_fuentes_sec, 
                                    levels = niveles_ordenados, 
                                    ordered = TRUE))

paises_criticos_long <- paises_criticos %>%
        select(Marcos_fuentes_sec, Acciones_fuentes_sec, Actores_no_estatales_sec) %>%
  pivot_longer(cols = everything(), names_to = "Dimension", values_to = "Nivel") %>%
  mutate(Nivel = factor(Nivel, levels = niveles_ordenados, ordered = TRUE))

ggplot(paises_criticos_long, aes(x = Nivel, fill = Dimension)) +
  geom_bar(position = "dodge") +
  scale_y_continuous(breaks = function(x) seq(0, max(x), by = 1)) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Validación Externa en Países Críticos",
    subtitle = "Comparativa de 3 dimensiones de fuentes secundarias (Escala Ordinal)",
    x = "Nivel de Desarrollo Detectado",
    y = "Cantidad de Países"
  ) +
  theme_minimal()

