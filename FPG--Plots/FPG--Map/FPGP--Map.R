### The BEGINNING ~~~~
##
# > Creates FPGP--Map | By George PACHECO


# Sets working directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages:

pacman::p_load(rnaturalearth, rnaturalearthdata, rgeos, sf, ggspatial, tidyverse, ggrepel, extrafont, cowplot)

# Imports extra fonts:

loadfonts(device = "win", quiet = TRUE)

# Imports .shp files:

Global <- ne_countries(scale = 'medium', returnclass = 'sf')
FRO <- read_sf(dsn = ".", layer = "FRO_adm0")
SLK <- read_sf(dsn = ".", layer = "LKA_adm0")
NR <- read_sf(dsn = ".", layer = "Columba_livia")

# Creates sub-sets of the .shp files: 

NR_slk <- st_crop(NR, xmin = 79.5, xmax = 83, ymin = 5, ymax = 10, expand = FALSE)

# Loads coordinates:

Coords_Global <- read.csv2("Locations_GLOBE.txt", sep = "\t", header = TRUE, encoding = "UTF-8")
Coords_Global$Longitude <- as.numeric(Coords_Global$Longitude)
Coords_Global$Latitude <- as.numeric(Coords_Global$Latitude)

Coords_FRO <- read.csv2("Locations_FaroeIslands.txt", sep = "\t", header = TRUE, encoding = "UTF-8")
Coords_FRO$Longitude <- as.numeric(Coords_FRO$Longitude)
Coords_FRO$Latitude <- as.numeric(Coords_FRO$Latitude)

Coords_SLK <- read.csv2("Locations_SriLanka.txt", sep = "\t", header = TRUE, encoding = "UTF-8")
Coords_SLK$Longitude <- as.numeric(Coords_SLK$Longitude)
Coords_SLK$Latitude <- as.numeric(Coords_SLK$Latitude)

# Transforms coordinates:

Coords_Global_sf <- st_as_sf(Coords_Global, coords = c("Longitude", "Latitude"), crs = 4326)
Coords_FRO_sf <- st_as_sf(Coords_FRO, coords = c("Longitude", "Latitude"), crs = 4326)
Coords_SLK_sf <- st_as_sf(Coords_SLK, coords = c("Longitude", "Latitude"), crs = 4326)

# Reorganises the data:

Coords_Global_sf$Class_Article <- factor(Coords_Global_sf$Class_Article, levels=c(
                               "Remote Localities Within Natural Range",
                               "Urban Localities Within Natural Range",
                               "Localities Outside Natural Range",
                               "Captive Populations"))
# Creates the base maps:

# Map1 - Global:

Map1 <-
ggplot() +
  geom_sf(data = Global, fill = "#fff5f0", color = "black") +
  geom_sf(data = NR[NR$origin == "1",], fill = "#addd8e", alpha = 0.35, color = NA) +
  geom_sf(data = Coords_Global_sf, aes(fill = Class_Article), size = 3, show.legend = "point", shape = 21, colour = "black") +
  coord_sf(xlim = c(-130, 130), ylim = c(-42, 72), expand = FALSE) +
  geom_label_repel(data = Coords_Global, size = 3.75, seed = 10, min.segment.length = 0, force = 25, segment.curvature = 1,
                   nudge_x = 0, nudge_y = 0, max.overlaps = Inf, fontface = "bold", colour = "black",
                   aes(x = Longitude, y = Latitude, label = LocationOnly,
                   fill = Class_Article, family = "Georgia"), alpha = 0.9, show.legend = FALSE) +
  scale_fill_manual(values = c("#44AA99", "#F0E442", "#E69F00", "#56B4E9"), drop = FALSE) +
  scale_colour_manual(values = c("#44AA99", "#F0E442", "#E69F00", "#56B4E9"), drop = FALSE) +
  scale_x_continuous(breaks = seq(-120, 120, by = 25)) +
  scale_y_continuous(breaks = seq(-20, 70, by = 25)) +
  annotation_north_arrow(location = "br", which_north = "false", style = north_arrow_fancy_orienteering,
                         pad_x = unit(0.25, "in"), pad_y = unit(6.5, "in")) +
  annotation_scale(location = 'br', line_width = 2, text_cex = 1.35, style = "ticks") +
  annotate("rect", xmin = 76.9, xmax = 84, ymin = 3.25, ymax = 12, fill = "#f46d43",  alpha = 0.2, color = "#a50026", linetype = "dotdash") +
  annotate("rect", xmin = -9, xmax = -4.5, ymin = 59.5, ymax = 64.5, fill = "#f46d43",  alpha = 0.2, color = "#a50026", linetype = "dotdash") +
  theme(panel.background = element_rect(fill = "#f7fbff"),
        panel.border = element_rect(colour = "black", size = 0.5, fill = NA),
        panel.grid.major = element_line(color = "#d9d9d9", linetype = "dashed", size = 0.00005),
        plot.margin = margin(t = 0.005, b = 0.005, r = 0.2, l = 0.2, unit = "cm"),
        legend.background = element_rect(fill = "#c6dbef", size = 0.15, color = "#5e5e5e", linetype = "dotted"),
        legend.key = element_rect(fill = "#c6dbef"),
        legend.position = c(0.10000, 0.18250)) +
  theme(axis.text.x = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.text.y = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.title = element_blank()) +
  theme(axis.ticks = element_line(color ="black", size = 0.5)) +
  guides(fill = guide_legend(title = "Biological Status", title.theme = element_text(size = 10.5, face = "bold", family = "Helvetica"),
                             label.theme = element_text(size = 8, face = "italic", family = "Helvetica"),
                             override.aes = list(size = 3, alpha = 0.9)), colour = "none")

#ggsave(Map1, file = "Global.pdf", device = cairo_pdf, width = 26, height = 13, scale = 0.8, limitsize = FALSE, dpi = 1000)

# Map2 - Faroe Islands:

Map2 <-
ggplot() + 
  geom_sf(data = FRO, fill = "#fff5f0", color = "black") +
  geom_sf(data = NR[NR$origin == "1",], fill = "#addd8e", alpha = 0.35, color = NA) +
  geom_sf(data = Coords_FRO_sf, aes(fill = Class_Article), size = 5, alpha = 0.9, show.legend = "point", shape = 21, colour = "black") +
  geom_label_repel(data = Coords_FRO, size = 4.5, seed = 10, min.segment.length = 0, force = 30, segment.curvature = 1, nudge_x = 0, nudge_y = 0, max.overlaps = Inf,
                   fontface = "bold", colour = "black", aes(x = Longitude, y = Latitude, label = LocationOnly,
                   fill = Class_Article, family = "Georgia"), alpha = 0.9, show.legend = FALSE) +
  scale_fill_manual(values=c("#44AA99"), drop=FALSE) +
  scale_colour_manual(values=c("#44AA99"), drop=FALSE) +
  scale_x_continuous(breaks = seq(-7.5, -4, by = 0.5)) +
  scale_y_continuous(breaks = seq(59, 63.0, by = 0.5)) +
  coord_sf(xlim = c(-8, -5.75), ylim = c(61.35, 62.42), expand = FALSE) +
  annotation_north_arrow(location = "br", which_north = "false", style = north_arrow_fancy_orienteering,
                         pad_x = unit(0.25, "in"), pad_y = unit(6.85, "in")) +
  annotation_scale(location = 'br', line_width = 2, text_cex = 1.35, style = "ticks") +
  theme(panel.background = element_rect(fill = "#f7fbff"),
        panel.border = element_rect(colour = "#a50026", size = 0.5, linetype = "dotdash", fill = NA),
        panel.grid.major = element_line(color = "#d9d9d9", linetype = "dashed", size = 0.00005),
        plot.margin =  margin(t = 0.005, b = 0.005, r = 0.2, l = 0.2, unit = "cm")) +
  theme(axis.text.x = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.text.y = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.title = element_blank()) +
  theme(axis.ticks = element_line(color ="black", size = 0.5)) +
  guides(color = "none", fill = "none")

#ggsave(Map2, file = "FO.pdf", device = cairo_pdf, width = 13, height = 13, scale = 0.65, limitsize = FALSE, dpi = 1000)

# Map3 - Sri Lanka:

Map3 <-
ggplot() + 
  geom_sf(data = SLK, fill = "#fff5f0", color = "black") +
  geom_sf(data = NR_slk[NR_slk$origin == "1",], fill = "#addd8e", alpha = 0.35, color = NA) +
  geom_sf(data = Coords_SLK_sf, aes(fill = Class_Article), size = 5, alpha = 0.9, show.legend = "point", shape = 21, colour = "black") +
  geom_label_repel(data = Coords_SLK, size = 4.5, seed = 10, min.segment.length = 0, force = 50, segment.curvature = 1,
                   nudge_x = c(0, 0, -0.35, 0, 0), nudge_y = c(-0.15, 0.15, 0, 0.15, -0.15), max.overlaps = Inf,
                   fontface = "bold", colour = "black", aes(x = Longitude, y = Latitude, label = LocationOnly,
                   fill = Class_Article, family = "Georgia"), alpha = 0.9, show.legend = FALSE) +
  scale_fill_manual(values=c("#56B4E9", "#44AA99", "#F0E442"), drop=FALSE) +
  scale_colour_manual(values=c("#56B4E9", "#44AA99", "#F0E442"), drop=FALSE) +
  scale_x_continuous(breaks = seq(79, 82, by = 0.5)) +
  scale_y_continuous(breaks = seq(6, 11, by = 0.5)) +
  coord_sf(xlim = c(78.55, 82.65), ylim = c(5.825, 9.90), expand = FALSE, label_graticule = "SE") +
  annotation_north_arrow(location = "br", which_north = "false", style = north_arrow_fancy_orienteering,
                         pad_x = unit(0.25, "in"), pad_y = unit(6.85, "in")) +
  annotation_scale(location = 'br', line_width = 2, text_cex = 1.35, style = "ticks") +
  theme(panel.background = element_rect(fill = "#f7fbff"),
        panel.border = element_rect(colour = "#a50026", size = 0.5, linetype = "dotdash", fill = NA),
        panel.grid.major = element_line(color = "#d9d9d9", linetype = "dashed", size = 0.00005),
        plot.margin = margin(t = 0.005, b = 0.005, r = 0.2, l = 0.2, "cm")) +
  theme(axis.text.x = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.text.y.right = element_text(color = "black", size = 13, family = "family"),
        axis.title = element_blank()) +
  theme(axis.ticks = element_line(color ="black", size = 0.5)) +
  guides(color = "none", fill = "none")

#ggsave(Map3, file = "SLK.pdf", device = cairo_pdf, width = 13, height = 13, scale = 0.65, limitsize = FALSE, dpi = 1000)

# Adds final touches:

BottomRow <- plot_grid(Map2, Map3)
BottomRowUp <-
BottomRow + geom_label(aes(label = "Faroe Islands"), x = 0.1219, y = 0.93, size = 7.5, fontface = "bold", fill = "#c6dbef", color = "black", family = "Georgia") +
geom_label(aes(label = "Sri Lanka"), x = 0.57, y = 0.93, size = 7.5, fontface = "bold", fill = "#c6dbef", color = "black", family = "Georgia")

# Creates & Saves the final Map Panel:

MapPanel <- plot_grid(Map1, BottomRowUp, ncol = 1)
ggsave(MapPanel, file = "FPGP--Map.pdf", device = cairo_pdf, width = 50, height = 50, scale = 0.335, limitsize = FALSE, dpi = 1000)

#
##
### The END ~~~~