########################
# Boxplot comparativos #
########################

# Mantenemos el attach que tenías al inicio de tu bloque
attach(datos_limpios)

ggplot(datos_limpios) +
  aes(x = NU_Region, y = Derechos_Humanos) +
  geom_boxplot(show.legend = F, fill = "lightpink") +
  labs(
    x = "Región de la ONU", 
    y = "Índice de Derechos Humanos (0-100)",
    caption = "Fuente: índice GIRAI 2024" # <-- Esto agrega la línea al final del gráfico
  ) + 
  coord_flip() +
  ggtitle("Distribución del Índice de Derechos Humanos según Región") +
  theme_light() +
  theme(plot.caption = element_text(face = "italic", color = "gray30", size = 9)) # Le da un toque estético sutil

# Caso particular: segmentación por regiones globales individuales en una grilla común.
# Nota: Revisá si los nombres de las regiones en tu dataset están en inglés 
# ("Americas", "Europe", etc.) o en español para que el filtro funcione perfecto.

library(gridExtra)
library(dplyr)

# Verificamos los límites reales del índice (0 a 100)
# min(datos_limpios$Derechos_Humanos, na.rm = TRUE)
# max(datos_limpios$Derechos_Humanos, na.rm = TRUE)

# Creamos los gráficos de a uno por cada macro-región y los guardamos en objetos
g1 <- datos_limpios %>% filter(NU_Region == "Americas") %>%
  ggplot() +
  aes(x = NU_region, y = Derechos_humanos) +
  geom_boxplot(show.legend = F, fill = "orange") +
  scale_y_continuous(limits = c(0, 100)) + # Mantengo la escala fija del índice
  theme_minimal() +
  labs(x = "", y = "Índice de DDHH") # El primer gráfico conserva las etiquetas del eje Y

g2 <- datos_limpios %>% filter(NU_region == "Europe") %>%
  ggplot() +
  aes(x = NU_region, y = Derechos_humanos) +
  geom_boxplot(show.legend = F, fill = "orange") +
  scale_y_continuous(limits = c(0, 100)) + 
  theme_minimal() +
  theme(axis.text.y = element_text(size = 0)) + # Quito etiquetas para evitar redundancia
  labs(x = "", y = "")

g3 <- datos_limpios %>% filter(NU_region == "Africa") %>%
  ggplot() +
  aes(x = NU_region, y = Derechos_humanos) +
  geom_boxplot(show.legend = F, fill = "orange") +
  scale_y_continuous(limits = c(0, 100)) + 
  theme_minimal() +
  theme(axis.text.y = element_text(size = 0)) +
  labs(x = "", y = "")

g4 <- datos_limpios %>% filter(NU_region == "Asia") %>%
  ggplot() +
  aes(x = NU_region, y = Derechos_humanos) +
  geom_boxplot(show.legend = F, fill = "orange") +
  scale_y_continuous(limits = c(0, 100)) + 
  theme_minimal() +
  theme(axis.text.y = element_text(size = 0)) +
  labs(x = "", y = "")

g5 <- datos_limpios %>% filter(NU_region == "Oceania") %>%
  ggplot() +
  aes(x = NU_region, y = Derechos_humanos) +
  geom_boxplot(show.legend = F, fill = "orange") +
  scale_y_continuous(limits = c(0, 100)) + 
  theme_minimal() +
  theme(axis.text.y = element_text(size = 0)) +
  labs(x = "", y = "")

# Armamos la grilla final con las 5 columnas continentales
grid.arrange(g1, g2, g3, g4, g5, 
             ncol = 5, nrow = 1)