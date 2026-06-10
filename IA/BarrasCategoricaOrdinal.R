# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)
library(dplyr)

# Fijo el dataset
attach(datos_limpios)

niveles_ordenados <- c("Muy bajo", "Bajo", "Medio", "Alto", "Muy alto")
umbral <- quantile(datos_limpios$GIRAI, 0.50, na.rm = TRUE)

paises_criticos <- datos_limpios %>%
  filter(GIRAI <= umbral) %>%
  filter(!is.na(Marcos_fuentes_sec), 
         !is.na(Acciones_fuentes_sec), 
         !is.na(Actores_no_estatales_sec)) %>%
  mutate(Validacion_Global = factor(Marcos_fuentes_sec, 
                                    levels = niveles_ordenados, 
                                    ordered = TRUE))
length(paises_criticos)

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

nombres_pilares <- c(
  "Marcos_fuentes_sec" = "Marcos Normativos",
  "Acciones_fuentes_sec" = "Acciones Gubernamentales",
  "Actores_no_estatales_sec" = "Actores No Estatales"
)

ggplot(paises_criticos_long, aes(x = Nivel, fill = Dimension)) + 
  geom_bar() +
  
  geom_text(stat = "count", 
            aes(label = after_stat(count)), 
            vjust = -0.5,   
            size = 3.5,    
            fontface = "bold") +
  
  geom_bar(color = "black", linewidth = 0.5) +
  
  facet_wrap(~Dimension, ncol = 3, labeller = labeller(Dimension = nombres_pilares)) + 
  
  scale_y_continuous(breaks = function(x) seq(0, max(x), by = 2)) +

  labs(
    title = "Niveles de Desarrollo por Pilar en Países Críticos",
    subtitle = "Comparativa de fuentes secundarias (Gobernanza, Marcos y Actores)",
    x = "Nivel detectado por fuentes externas",
    y = "Cantidad de Países",
    fill = "Referencia de Nivel",
    caption = "Fuente: índice GIRAI 2024" # <-- Fuente agregada acá
  ) +
  
  theme_minimal() +
  theme(
    strip.text = element_text(face = "bold", size = 10),
    legend.position = "none",
    # Mantenemos tu estilo estandarizado de caption para todo el TP
    plot.caption = element_text(face = "italic", color = "gray30", size = 9) 
  )