########################
# Boxplot comparativos #
########################
library(gridExtra)
library(dplyr)

attach(datos_limpios)

ggplot(datos_limpios) +
  aes(x = NU_region, y = Derechos_humanos) +
  geom_boxplot(show.legend = F, fill = "#00BFFF") +
  labs(
    x = "Región de la ONU", 
    y = "Índice de Derechos Humanos (0-100)",
    caption = "Fuente: índice GIRAI 2024" 
  ) + 
  coord_flip() +
  ggtitle("Distribución del Índice de Derechos Humanos según Región") +
  theme_light() +
  theme(plot.caption = element_text(face = "italic", color = "gray30", size = 9)) 


# Creamos los gráficos de a uno por cada macro-región y los guardamos en objetos
g1 <- datos_limpios %>% filter(NU_Region == "Americas") %>%
  ggplot() +
  aes(x = NU_region, y = Derechos_humanos) +
  geom_boxplot(show.legend = F, fill = "orange") +
  scale_y_continuous(limits = c(0, 100)) + 
  theme_minimal() +
  labs(x = "", y = "Índice de DDHH")

g2 <- datos_limpios %>% filter(NU_region == "Europe") %>%
  ggplot() +
  aes(x = NU_region, y = Derechos_humanos) +
  geom_boxplot(show.legend = F, fill = "orange") +
  scale_y_continuous(limits = c(0, 100)) + 
  theme_minimal() +
  theme(axis.text.y = element_text(size = 0)) + 
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


grid.arrange(g1, g2, g3, g4, g5, 
             ncol = 5, nrow = 1)