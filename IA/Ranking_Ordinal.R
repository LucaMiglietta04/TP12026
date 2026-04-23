library(dplyr)
library(tidyverse)
attach(datos)


# Categorizamos a los países según su índice del GIRAI
datos <- datos %>%
  mutate(Categoria = case_when(
    GIRAI < 20 ~ "Muy bajo",
    GIRAI >= 20 & GIRAI < 40 ~ "Bajo",
    GIRAI >= 40 & GIRAI < 60 ~ "Medio",
    GIRAI >= 60 & GIRAI < 80 ~ "Alto",
    GIRAI >= 80 ~ "Muy alto"
  ))

# Ordenamos las categorías por orden
datos <- datos %>%
  mutate(Categoria = factor(Categoria, 
                            levels = c("Muy bajo", "Bajo", "Medio", "Alto", "Muy alto")))

# COMPARACIÓN DE REGIONES

ggplot(datos, aes(x = Categoria, fill = NU_region)) +
  geom_bar(position = "stack") +
  labs(title = "Composición Regional por Categoría GIRAI",
       x = "Desempeño",
       y = "Cantidad de Países",
       fill = "Región") +
  scale_fill_manual(values = c("África" ="burlywood2", 
                               "Europa" = "deepskyblue3", 
                               "América" = "palegreen",
                               "Asia" = "gold",
                               "Oceanía"= "pink")) + 
  theme_minimal()


# COMPARACION DE SUBREGIONES 

ggplot(datos, aes(x = Categoria, fill = UN_subregion)) +
  geom_bar(position = "stack") +
  labs(title = "Composición Subregional por Categoría GIRAI",
       x = "Desempeño",
       y = "Cantidad de Países",
       fill = "Región") +
  theme_minimal()