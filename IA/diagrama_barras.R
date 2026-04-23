library(gt)
library(tidyverse)
attach(datos_limpios)
## areas p_70 de respuesta multiple en relacion a la dimension de Derechos humanos 
# Sesgo y discirminacion 
# Derechos infancias 
# Diversidad cultural 
# Igualdad de genero 
# Proteccion de datos 
# Proteccion laboral

total_paises <- n_distinct(datos_limpios$Pais) 
datos_resumen <- datos_limpios %>%
  separate_rows(Areas_p70_multiple, sep = ", ") %>%
  count(Areas_p70_multiple) %>%
  mutate(porcentaje = (n / total_paises) * 100,
         label_text = paste0(round(porcentaje, 1), "%"))

ggplot(datos_resumen, aes(x = reorder(Areas_p70_multiple, n), y = n)) +
  geom_col(fill = "steelblue") + 
  geom_text(aes(label = label_text), 
            hjust = -0.2, 
            size = 3.5, 
            fontface = "bold") +

  scale_y_continuous(breaks = pretty_breaks(), 
                     expand = expansion(mult = c(0, 0.2))) + 
  coord_flip() + 
  labs(
    title = "Ranking de Áreas de Protección en IA",
    subtitle = "Frecuencia y porcentaje incluyendo países sin áreas detectadas ('Ninguna')",
    x = "Área Temática",
    y = "Cantidad de Países",
    caption = "Fuente: Elaboración propia sobre datos GIRAI 2024"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none", 
    panel.grid = element_blank(),
    axis.text.y = element_text(size = 10)
  )

## podemos hacer este mismo grafico segun cada region 
grafico_subregional <- datos_limpios %>%
  group_by(NU_subregion) %>%
  select(NU_subregion, Sesgo_y_discriminacion, Derechos_infancia, Diversidad_cultural, 
         Proteccion_datos, Igualdad_de_genero, Proteccion_laboral) %>%
  pivot_longer(cols = -NU_subregion, names_to = "Derecho", values_to = "Protegido") %>%
  filter(Protegido == 1) %>%
  group_by(NU_subregion, Derecho) %>%
  summarise(n = n(), .groups = "drop_last") %>%
  mutate(Porcentaje = (n / sum(n)) * 100) 

## grafico subregional
ggplot(grafico_subregional, aes(x = reorder(Derecho, Porcentaje), y = Porcentaje, fill = NU_subregion)) +
  geom_col() +
  facet_wrap(~NU_subregion) + # Crea un panel por cada subregión
  coord_flip() +
  labs(
    title = "Comparativa Regional: Protección de DDHH en IA",
    subtitle = "Porcentaje de adopción de mecanismos según subregión",
    x = "Mecanismo de Derecho Humano",
    y = "Porcentaje (%)",
    caption = "Fuente: Elaboración propia - GIRAI 2024"
  ) +
  theme_minimal() +
  theme(legend.position = "none", strip.text = element_text(face = "bold"))

## otro analisis que puede ser interesante 
analisis_subregional <- datos_limpios %>%
  group_by(NU_subregion) %>%
  summarise(
    cantidad_paises = n(),
    promedio_ddhh = mean(Derechos_humanos, na.rm = TRUE) 
  ) %>%
  arrange(desc(cantidad_paises))

analisis_subregional %>%
  gt() %>%
  tab_header(
    title = "Resumen Estadístico por Subregión",
    subtitle = "Basado en el índice de Derechos Humanos 2024"
  ) %>%
  cols_label(
    NU_subregion = "Subregión",
    cantidad_paises = "Países",
    promedio_ddhh = "Promedio DDHH"
  ) %>%
  fmt_number(columns = promedio_ddhh, decimals = 2) %>%
  tab_options(table.width = pct(80))