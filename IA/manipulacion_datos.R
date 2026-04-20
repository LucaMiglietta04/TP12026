# Instalo los paquetes necesarios (si aún no los tengo instalados)
#install.packages("tidyverse")

# Cargo los paquetes que voy a usar
library(tidyverse)

# Fijo el dataset
attach(datos)

## Elimino del df las columnas de no interes

datos_limpios <- datos %>%
  select(-ISO3,-Country,-tipo_academia_en,-tipo_privado_en,-NU_region,-GIRAI_region 
         ,-tipo_privado_es , -tipo_academia_es, -privado , -academia)


## Renombro las columnas del df para un  reconocimiento y analisis claro
colnames(datos_limpios) <- c(  
  "Ranking", "Pais", "NU_subregion", "GIRAI",
  "Marcos_normativos_gob", "Acciones_gob", "Actores_no_estatales",
  "Derechos_humanos", "Gobernanza_IA", "Capacidades_IA",
  "Marcos_fuentes_sec", "Acciones_fuentes_sec",
  "Actores_no_estatales_sec", "Dimension_mejor_puntuada",
  "Sesgo_y_discriminacion", "Derechos_infancia",
  "Diversidad_cultural", "Proteccion_datos",
  "Igualdad_de_genero", "Supervision_humana",
  "Proteccion_laboral", "Seguridad_precision_y_fiabilidad",
  "Transparencia_y_explicabilidad", "Cant_areas_reglas_IA",
  "Cant_areas_acciones_gob_IA", "Cant_areas_discusiones_IA",
  "Cant_areas_concientizacion_IA", "Cant_areas_trabajo_nsa_IA"
  )
  
# 1. Primero, transformamos los 1 y 0 en el nombre de la categoría o NA
datos_limpios <- datos_limpios %>%
  mutate(
    cat_sesgo =  if_else(Sesgo_y_discriminacion == 1, "Sesgo", NA_character_),
    cat_datos =  if_else(Proteccion_datos == 1, "Datos", NA_character_),
    cat_genero = if_else(Igualdad_de_genero == 1, "Género", NA_character_),
    cat_infancia = if_else(Derechos_infancia == 1, "Der_infancia", NA_character_),
    cat_cultural = if_else(Diversidad_cultural == 1, "Div_cultural", NA_character_),
    cat_supervision = if_else(Supervision_humana == 1, "Sup_humana", NA_character_),
    cat_laboral = if_else(Proteccion_laboral == 1, "Laboral", NA_character_),
    cat_seguridad = if_else(Seguridad_precision_y_fiabilidad == 1, "Seguridad", NA_character_),
    cat_transparencia = if_else(Transparencia_y_explicabilidad == 1, "Transparencia", NA_character_),
    ) %>%
  # 2. Unimos todas esas nuevas columnas en una sola, ignorando los NA
  unite(
    col = "Areas_p70_multiple", 
    starts_with("cat_"), 
    sep = ", ", 
    na.rm = TRUE, 
    remove = TRUE
  ) %>%
  # 3. Si un país no tenía nada, la columna quedará vacía; le ponemos "Ninguna"
  mutate(Areas_p70_multiple = if_else(Areas_p70_multiple == "", "Ninguna", Areas_p70_multiple))


