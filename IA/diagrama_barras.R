
library(tidyverse)
attach(datos_limpios)
## areas p_70 de respuesta multiple en relacion a la dimension de Derechos humanos 
# Sesgo y discirminacion 
# Derechos infancias 
# Diversidad cultural 
# Igualdad de genero 
# Proteccion de datos 
# Proteccion laboral


total_paises <- n_distinct(datos_grafico_multiple$Pais) # O la columna que identifique al país

datos_resumen <- datos_grafico_multiple %>%
  count(Areas_p70_multiple) %>%
  mutate(porcentaje = (n / total_paises) * 100,
         label_text = paste0(round(porcentaje, 1), "%"))

ggplot(datos_resumen, aes(x = reorder(Areas_p70_multiple, n), y = n, fill = Areas_p70_multiple)) +
  geom_col(fill = "steelblue") + 
  geom_text(aes(label = label_text), hjust = -0.1,size = 3.5,       fontface = "bold") +    
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) + 
  coord_flip() + 
  scale_fill_viridis_d(option = "mako", begin = 0.2, end = 0.8) + 
  labs(
    title = "Ranking de Áreas de Protección en IA",
    subtitle = "Frecuencia y porcentaje de cobertura en marcos legales",
    x = "Área Temática",
    y = "Cantidad de Países",
    caption = "Fuente: GIRAI 2024"
  ) +
  theme_minimal() +
  theme(legend.position = "none", panel.grid = element_blank())


##grafico_ddhh <- datos_limpios %>%
##  select(Sesgo_y_discriminacion, Derechos_infancia, Diversidad_cultural, 
##         Proteccion_datos, Igualdad_de_genero, Proteccion_laboral) %>%
##  pivot_longer(cols = everything(), names_to = "Derecho", values_to = "Protegido") %>%
##  filter(Protegido == 1) %>%
##  count(Derecho) %>%
##  mutate(Porcentaje = ( n / 138) * 100)


# ggplot(grafico_ddhh, aes(x = reorder(Derecho, Porcentaje), y = Porcentaje, fill = Porcentaje)) +
#  geom_col() +
#  coord_flip() +
#  scale_fill_gradient(low = "skyblue", high = "dodgerblue4") +
#  labs(
#    title = "Protección de Derechos Humanos en la IA",
#    subtitle = "Porcentaje de países con mecanismos activos por área temática",
#    x = "Área de Derecho Humano",
#    y = "Porcentaje de Países (%)",
#    caption = "Fuente: Elaboración propia basada en datos del GIRAI 2024"
#  ) +
#  theme_minimal() +
#  theme(legend.position = "none")


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
    promedio_ddhh = mean(Derechos_humanos, na.rm = TRUE) # Reemplaza pilar_ddhh por el nombre real de tu columna
  ) %>%
  arrange(desc(cantidad_paises))

print(analisis_subregional)




