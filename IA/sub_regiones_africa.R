library(tidyverse)
library(ggplot2)
library(patchwork)

# Datos base
datos_todos <- datos_limpios %>%
  filter(grepl("Africa|África|Asia|América|America", NU_subregion, ignore.case = TRUE)) %>%
  count(NU_subregion, Acciones_fuentes_sec) %>%
  mutate(
    Acciones_fuentes_sec = factor(
      Acciones_fuentes_sec,
      levels = c("Muy bajo", "Bajo", "Medio", "Alto", "Muy alto")
    )
  )

# Colores
colores <- c(
  "África Subsahariana"        = "#C85200",
  "África del Norte"           = "#F5C99A",
  "Asia Central"               = "#08519C",
  "Asia Meridional"            = "#3182BD",
  "Asia Occidental"            = "#6BAED6",
  "Asia Oriental"              = "#BDD7E7",
  "América Latina y el Caribe" = "#006D2C",
  "América del Norte"          = "#74C476"
)

tema_base <- theme_minimal(base_size = 12) +
  theme(
    legend.position    = "right",
    legend.title       = element_text(size = 10),
    legend.key.size    = unit(0.4, "cm"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    axis.text.x        = element_text(size = 10),
    axis.text.y        = element_text(size = 10),
    plot.title         = element_text(size = 12, face = "bold")
  )
# Tema con etiquetas rotadas (Asia y América)
tema_rotado <- tema_base +
  theme(
    axis.text.x = element_text(size = 10, angle = 45, hjust = 1)
  )

# ── ÁFRICA ────────────────────────────────────────────────────────────────────
p_africa <- datos_todos %>%
  filter(grepl("Africa|África", NU_subregion, ignore.case = TRUE)) %>%
  ggplot(aes(x = Acciones_fuentes_sec, y = n, fill = NU_subregion)) +
  geom_bar(stat = "identity", position = "stack", width = 0.6, color = "white", linewidth = 0.3) +
  scale_fill_manual(values = colores, name = "Subregión") +
  scale_y_continuous(breaks = seq(0, 20, by = 5)) +
  labs(title = "África", x = NULL, y = "Cantidad de países") +
  tema_rotado

# ── ASIA ──────────────────────────────────────────────────────────────────────
p_asia <- datos_todos %>%
  filter(grepl("Asia", NU_subregion, ignore.case = TRUE)) %>%
  ggplot(aes(x = Acciones_fuentes_sec, y = n, fill = NU_subregion)) +
  geom_bar(stat = "identity", position = "stack", width = 0.6, color = "white", linewidth = 0.3) +
  scale_fill_manual(values = colores, name = "Subregión") +
  scale_y_continuous(breaks = seq(0, 20, by = 5)) +
  labs(title = "Asia", x = NULL, y = NULL) +
  tema_rotado

# ── AMÉRICA ───────────────────────────────────────────────────────────────────
p_america <- datos_todos %>%
  filter(grepl("América|America", NU_subregion, ignore.case = TRUE)) %>%
  ggplot(aes(x = Acciones_fuentes_sec, y = n, fill = NU_subregion)) +
  geom_bar(stat = "identity", position = "stack", width = 0.6, color = "white", linewidth = 0.3) +
  scale_fill_manual(values = colores, name = "Subregión") +
  scale_y_continuous(breaks = seq(0, 20, by = 5)) +
  labs(title = "América", x = NULL, y = NULL) +
  tema_rotado

# ── COMBINAR ──────────────────────────────────────────────────────────────────
p_africa + p_asia + p_america +
  plot_layout(ncol = 3) +
  plot_annotation(
    title   = "Nivel de Acciones (fuentes secundarias) por subregión",
    caption = "Fuente: índice GIRAI 2024",
    theme = theme(
      plot.title   = element_text(size = 14, face = "bold"),
      plot.caption = element_text(face = "italic", color = "gray30", size = 9)
    )
  )