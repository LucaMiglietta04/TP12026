# Instalo los paquetes necesarios (si aún no los tengo instalados)
# install.packages("tidyverse")
# install.packages("ggplot2")

# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)
library(dplyr)

##########################
# Diagrama de dispersión #
##########################

datos_limpios %>%
  group_by(NU_subregion) %>% 
  summarise(
    ddhh_mediana = median(Derechos_humanos, na.rm = TRUE),
    gob_mediana = median(Gobernanza_IA, na.rm = TRUE)
  ) %>%
  ggplot() +
  aes(x = gob_mediana, y = ddhh_mediana) + 
  geom_point(size = 4, color = "#1874CD") + 
  geom_text(aes(label = NU_subregion), vjust = -1.2, size = 3, check_overlap = TRUE) + 
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "darkgray") +
  labs(
    title = "Relación entre la mediana del índice de Derechos Humanos y del índice de Gobernanza por subregión de la ONU",
    x = "Gobernanza (Mediana Regional)",
    y = "Derechos Humanos (Mediana Regional)",
    caption = "Fuente: índice GIRAI 2024"
  ) +
  xlim(0, 100) + ylim(0, 100) +

  theme_minimal() +
  
 
  theme(
    plot.caption = element_text(face = "italic", color = "gray30", size = 9)
  )

