### The BEGINNING ~~~~~
##
# ~ Plots FPG--Phylogenies | By George Pacheco.


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(ggtree, tidyverse, ggrepel, extrafont, treeio, ape, ggtreeExtra, ggnewscale, ggstar)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads datasets ~
Phylo_1 <- read.newick("FPG--GoodSamples.nwk")


# Roots the phylogenies ~
Phylo_1_rooted <- root(Phylo_1, node = 518)


# Selects clades to highlight ~
Phylo_1_outgroups <- list(Phylo_1_outgroup_1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"),
                          Phylo_1_outgroup_2 = c("Cpalumbus_01-GBS", "Cpalumbus_02-GBS", "Cpalumbus_03-GBS", "Cpalumbus_04-GBS", "Cpalumbus_05-GBS"),
                          Phylo_1_outgroup_3 = c("Srisoria_01-GBS"))
Phylo_1_rooted <- groupOTU(Phylo_1_rooted, Phylo_1_outgroups)


# Creates the Phylo_1 plot ~
Phylo_1_Plot <-
 ggtree(Phylo_1_rooted, aes(colour = group, show.legend = TRUE), layout = "fan", size = .125, branch.length = "none") +
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


# Saves the plots ~
ggsave(Phylo_1_Plot, file = "FPG--Phylogeny--Dataset_I.pdf", device = cairo_pdf, width = 4, height = 4, scale = 1.5, dpi = 600)


#
##
### The END ~~~~~