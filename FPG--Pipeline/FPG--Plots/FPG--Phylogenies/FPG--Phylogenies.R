### The BEGINNING ~~~~~
##
# ~ Plots FPG--Phylogenies | By George Pacheco.


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(ggtree, tidyverse, ggrepel, extrafont, treeio, ape, ggtreeExtra, ggnewscale, ggstar, reshape2)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads phylogenies ~
Phylo_1 <- read.newick("FPG--GoodSamples.nwk")

Phylo_2 <- read.tree(file = "FPG--GoodSamples_NoSrisoriaNoCpalumbus_100BSs.raxml.support")


# Reads annotations ~
Phylo_2_Annot <- read.table("FPG--GoodSamples_FPG--GoodSamples_NoSrisoriaNoCpalumbus.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
colnames(Phylo_2_Annot) <- c("label", "Population")


# Expands Phylo_2_Annot by adding BioStatus ~
Phylo_2_Annot$BioStatus <- ifelse(Phylo_2_Annot$Population %in% c("Torshavn","Ejde","Sumba","LjosAir","Kunoy","Nolsoy", "Crete", "Sardinia",
                                                                  "Vernelle","WadiHidan","PigeonIsland","Trincomalee"), "Remote_Localities_Within_Natural_Range",
                           ifelse(Phylo_2_Annot$Population %in% c("Guimaraes","Lisbon","Barcelona","Berlin","Cambridge",
                                                                  "Colombo","Copenhagen","London","Prague","Jihlava","Abadeh",
                                                                  "Isfahan","Lahijan","Nowshahr","Tehran","TelAviv"), "Urban_Localities_Within_Natural_Range",
                           ifelse(Phylo_2_Annot$Population %in% c("SaltLakeCity","Denver", "FeralVA", "FeralUT", "TlaxcalaDeXicohtencatl",
                                                                  "MexicoCity","Monterrey","SanCristobalDeLasCasas","Santiago",
                                                                  "Salvador","Tatui","Johannesburg","Nairobi","Perth"), "Localities_Outside_Natural_Range",
                           ifelse(Phylo_2_Annot$Population %in% c("TelAvivColony","Wattala", "Wellawatte"), "Captives", NA))))


# Melts the annotation dataset ~
Phylo_2_Annot <- melt(Phylo_2_Annot)


# Roots the phylogenies ~
Phylo_1_Rooted <- root(Phylo_1, node = 518)

Phylo_2_Rooted <- root(Phylo_2, node = 507)


# Selects clades to highlight ~
Phylo_1_Outgroups <- list(Phylo_1_Outgroup_1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"),
                          Phylo_1_Outgroup_2 = c("Cpalumbus_01-GBS", "Cpalumbus_02-GBS", "Cpalumbus_03-GBS", "Cpalumbus_04-GBS", "Cpalumbus_05-GBS"),
                          Phylo_1_Outgroup_3 = c("Srisoria_01-GBS"))
Phylo_1_Rooted <- groupOTU(Phylo_1_Rooted, Phylo_1_Outgroups)

Phylo_2_Outgroups <- list(Phylo_2_Outgroup_1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"))
Phylo_2_Rooted <- groupOTU(Phylo_2_Rooted, Phylo_2_Outgroups)


# Reorders BioStatus ~
Phylo_2_Annot$BioStatus <- factor(Phylo_2_Annot$BioStatus, ordered = T,
                           levels = c("Remote_Localities_Within_Natural_Range",
                                      "Urban_Localities_Within_Natural_Range",
                                      "Localities_Outside_Natural_Range",
                                      "Captives"))


# Creates Phylo_1 plot ~
Phylo_1_Plot <-
 ggtree(Phylo_1_Rooted, aes(colour = group, show.legend = TRUE), layout = "fan", size = .125, branch.length = "none") +
  geom_tiplab(align = TRUE, linesize = .02, offset = .5, size = .7, show.legend = FALSE) +
  scale_colour_manual(name = "Species", labels = c("Columba livia", "Columba rupestris", "Columba palumbus", "Streptopelia risoria"),
                      values = c("#000000", "#fb8072", "#984ea3", "#33a02c")) +
  theme(panel.spacing = margin(t = 0, b = 0, r = 0, l = 0),
        plot.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 5, b = -20, r = 0, l = 0)) +
  guides(colour = guide_legend(title.theme = element_text(size = 10, face = "bold"),
                                 label.theme = element_text(size = 7.5, face = "italic"),
                                 override.aes = list(size = .35, alpha = .9)))


# Saves Phylo_1 plot ~
ggsave(Phylo_1_Plot, file = "FPG--Phylogeny--Dataset_I.pdf",
       device = cairo_pdf, width = 4, height = 4, scale = 1.5, dpi = 600)
ggsave(Phylo_1_Plot, file = "FPG--Phylogeny--Dataset_I.jpg",
       width = 4, height = 4, scale = 1.5, dpi = 600)


# Creates Phylo_2 plot ~
Phylo_2_BasePhylo <-
  ggtree(Phylo_2_Rooted, layout = "circular", size = .125, aes(colour = group), branch.length = "none") +
  scale_colour_manual(labels = c("Columba livia", "Columba rupestris"), values = c("#000000", "#fb8072"), na.value = NA)


# Merges annotation to base phylogeny ~
Phylo_2_BasePhylo_Annot <- Phylo_2_BasePhylo %<+% Phylo_2_Annot


# Creates Phylo_2 plot ~
Phylo_2_Plot <- 
  Phylo_2_BasePhylo_Annot +
  geom_point2(aes(label = label, subset = !is.na(as.numeric(label)) & as.numeric(label) > 85), shape = 21, size = 1.65, fill = "#155211", colour = "#155211", alpha = .85, stroke = .075, show.legend = FALSE) +
  geom_tippoint(aes(fill = BioStatus, subset = !is.na(BioStatus)), size = 1.65, stroke = .075, colour = "#000000", alpha = 1, shape = 21, na.rm = TRUE) +
  geom_strip("PigeonIsland_05-GBS", "Trincomalee_01-GBS", barsize = 3.5, color = "#d9d9d9", label = "Group A", fontsize = 6, offset = .75, offset.text = 1.5) +
  geom_strip("Abadeh_04-GBS", "Torshavn_02-GBS", barsize = 3.5, color = "#bdbdbd", label = "Group B", fontsize = 6, offset = .75, offset.text = 1.5) +
  geom_strip("TelAviv_07-GBS", "Isfahan_03-GBS", barsize = 3.5, color = "#969696", label = "Group C", fontsize = 6, offset = .75, offset.text = 7) +
  geom_strip("Barcelona_15-GBS", "Monterrey_05-GBS", barsize = 3.5, color = "#636363", label = "Group D", fontsize = 6, offset = .75, offset.text = 9) +
  geom_strip("Berlin_04-GBS", "London_05-GBS", barsize = 3.5, color = "#252525", label = "Group E", fontsize = 6, offset = .75, offset.text = 1.5) +
  scale_fill_manual(values = c("#44AA99", "#F0E442", "#E69F00", "#56B4E9", "#ff0000"), labels = gsub("_", " ", levels(Phylo_2_Annot$BioStatus)), na.translate = FALSE) +
  theme(panel.spacing = margin(t = 0, b = 0, r = 0, l = 0),
        panel.border = element_blank(),
        plot.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.position = c(.11, .875),
        legend.spacing.y = unit(.4, "cm"),
        legend.key.height = unit(.45, "cm"),
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 5, b = -20, r = 0, l = 30)) +
  guides(colour = guide_legend(title = "Species", title.theme = element_text(size = 14, face = "bold"),
                               label.theme = element_text(size = 10, face = "italic"), override.aes = list(size = .8, starshape = NA), order = 1),
         fill = guide_legend(title = "Biological Status", title.theme = element_text(size = 14, face = "bold"),
                             label.theme = element_text(size = 10),
                             override.aes = list(starshape = 21, size = 2.85, alpha = .9, starstroke = .0015), order = 2))

# Saves Phylo_1 plot ~
ggsave(Phylo_2_Plot, file = "FPG--Phylogeny--Dataset_II.pdf", device = cairo_pdf, width = 14, height = 12, scale = 1, dpi = 600)


#
##
### The END ~~~~~