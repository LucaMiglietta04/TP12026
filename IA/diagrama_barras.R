

attach(datos_limpios)

## areas p_70 de respuesta multiple en relacion a la dimension de Derechos humanos 

# Sesgo y discirminacion 
# Derechos infancias 
# Diversidad cultural 
# Igualdad de genero 
# Proteccion de datos 
# Proteccion laboral


datos_limpios %>% count(NU_subregion , sort = TRUE)

# 1. Preparamos los datos para el gráfico
grafico_ddhh <- datos_limpios %>%
  # Seleccionamos las columnas de derechos que usamos antes
  select(Sesgo_y_discriminacion, Derechos_infancia, Diversidad_cultural, 
         Proteccion_datos, Igualdad_de_genero, Proteccion_laboral) %>%
  # Pasamos de formato ancho a largo para poder contar
  pivot_longer(cols = everything(), names_to = "Derecho", values_to = "Protegido") %>%
  # Filtramos solo donde sí hay protección (valor 1)
  filter(Protegido == 1) %>%
  # Contamos y calculamos el porcentaje sobre el total de países
  count(Derecho) %>%
  mutate(Porcentaje = ( n / 138) * 100)

# 2. Creamos el gráfico de barras
ggplot(grafico_ddhh, aes(x = reorder(Derecho, Porcentaje), y = Porcentaje, fill = Porcentaje)) +
  geom_col() +
  coord_flip() + # Barras horizontales para que se lean bien los nombres
  scale_fill_gradient(low = "skyblue", high = "dodgerblue4") +
  labs(
    title = "Protección de Derechos Humanos en la IA",
    subtitle = "Porcentaje de países con mecanismos activos por área temática",
    x = "Área de Derecho Humano",
    y = "Porcentaje de Países (%)",
    caption = "Fuente: Elaboración propia basada en datos del GIRAI 2024"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

## podemos hacer este mismo grafico segun cada region 

# 1. Preparamos los datos agrupados
grafico_subregional <- datos_limpios %>%
  # Agrupamos por subregión
  group_by(NU_subregion) %>%
  # Seleccionamos las columnas. ¡Ojo! Aquí incluimos la variable de grupo
  select(NU_subregion, Sesgo_y_discriminacion, Derechos_infancia, Diversidad_cultural, 
         Proteccion_datos, Igualdad_de_genero, Proteccion_laboral) %>%
  # Pasamos a formato largo, pero mantenemos NU_subregion fuera del pivot
  pivot_longer(cols = -NU_subregion, names_to = "Derecho", values_to = "Protegido") %>%
  # Filtramos los casos positivos
  filter(Protegido == 1) %>%
  # Contamos cuántos países hay por Derecho dentro de cada Subregión
  group_by(NU_subregion, Derecho) %>%
  summarise(n = n(), .groups = "drop_last") %>%
  # Calculamos el porcentaje basado en el total de países de CADA subregión
  # (Esto es más preciso que usar un número fijo como 14)
  mutate(Porcentaje = (n / sum(n)) * 100) 

# 2. Creamos el gráfico con "facets" (un gráfico por subregión)
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

analisis_subregional <- datos_limpios %>%
  group_by(NU_subregion) %>%
  summarise(
    cantidad_paises = n(),
    promedio_ddhh = mean(Derechos_humanos, na.rm = TRUE) # Reemplaza pilar_ddhh por el nombre real de tu columna
  ) %>%
  arrange(desc(cantidad_paises))

print(analisis_subregional)




