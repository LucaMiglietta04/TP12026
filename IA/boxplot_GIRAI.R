
# Instalo los paquetes necesarios (si aún no los tengo instalados)
# install.packages("tidyverse")
# install.packages("ggplot2")

# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)

# Fijo el dataset
attach(datos_limpios)



datos_limpios %>% 
  select(GIRAI) %>%

  ggplot() +
  aes(x = GIRAI, y = "") +
  geom_boxplot(width = 0.50, fill = "lightblue", outlier.size = 1) +
  theme(axis.ticks.y = element_blank()) +
  labs(y = "", x = "Valor GIRAI") +
  scale_x_continuous(breaks = seq(0, 250, 50)) + # Marcas del eje
  theme_classic() +
  ggtitle("Distribución de valores GIRAI según los países")

# Instalo los paquetes necesarios (si aún no los tengo instalados)
# install.packages("tidyverse")
# install.packages("ggplot2")

# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)

# Fijo el dataset
attach(datos_limpios)



datos_limpios %>% 
  select(GIRAI) %>%

  ggplot() +
  aes(x = GIRAI, y = "") +
  geom_boxplot(width = 0.50, fill = "lightblue", outlier.size = 1) +
  theme(axis.ticks.y = element_blank()) +
  labs(y = "", x = "Valor GIRAI") +
  scale_x_continuous(breaks = seq(0, 250, 50)) + # Marcas del eje
  theme_classic()
  
summary(datos_limpios$GIRAI)

