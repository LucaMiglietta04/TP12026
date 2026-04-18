# Instalo los paquetes necesarios (si aún no los tengo instalados)
# install.packages("tidyverse")

# Cargo los paquetes que voy a usar
library(tidyverse)

# Fijo el dataset
attach(datos)

## Elimino del df las columnas de no interes

datos_limpios <- datos %>%
  select(-ISO3, -Country, -tipo_academia_en, -tipo_privado_en)

## Renombro las columnas del df para un  reconocimiento y analisis claro

colnames(datos_limpios) <- c(  
  "Ranking", "Pais", "GIRAI_region", "NU_region", "NU_subregion", "GIRAI",
  "Marcos_normativos_gob", "Acciones_gob", "Actores_no_estatales",
  "Derechos_humanos", "Gobernanza_IA", "Capacidades_IA",
  "Marcos_fuentes_sec", "Acciones_fuentes_sec",
  "Actores_no_estatales_sec", "Dimension_mejor_puntuada",
  "Sesgo_y_discriminacion", "Derechos_infancia",
  "Diversidad_cultural", "Proteccion_datos_y_privacidad",
  "Igualdad_de_genero", "Supervision_humana",
  "Proteccion_laboral_y_trabajo", "Seguridad_precision_y_fiabilidad",
  "Transparencia_y_explicabilidad", "Cant_areas_reglas_IA",
  "Cant_areas_acciones_gob_IA", "Cant_areas_discusiones_IA",
  "Cant_areas_concientizacion_IA", "Cant_areas_trabajo_nsa_IA",
  "Hay_academias_trabajando", "Tipo_iniciativa_academia",
  "Hay_sector_privado_trabajando", "Tipo_iniciativa_sector_privado"
)
  