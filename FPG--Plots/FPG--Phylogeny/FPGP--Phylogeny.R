### The BEGINNING ~~~~~
##
# > Plots FPG--Phylogeny | By George PACHECO


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(ggtree, tidyverse, ggrepel, extrafont, treeio, ape)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Reads data ~
Data1 <- read.newick("FPGP--GoodSamples--Article--Ultra.nwk")


# Roots the phylogeny ~
Data1_rooted <- root(Data1, which(Data1$tip.label == "Srisoria_01-GBS"))


# Selects clades to highlight ~
outgroups <- list(outgroup1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"),
                  outgroup2 = c("Cpalumbus_01-GBS", "Cpalumbus_02-GBS", "Cpalumbus_03-GBS", "Cpalumbus_04-GBS", "Cpalumbus_05-GBS"),
                  outgroup3 = c("Srisoria_01-GBS"))
Data1_rooted <- groupOTU(Data1_rooted, outgroups)


# Creates the plot ~
PhyloData1 <-
 ggtree(Data1_rooted, aes(colour = group, show.legend = TRUE), layout = "circular", size = .125, branch.length = "none") +
  geom_tiplab(align = TRUE, linesize = .02, offset = .5, size = .7, show.legend = FALSE) +
  scale_colour_manual(name = "Species", labels = c("Columba livia", "Columba rupestris", "Columba palumbus", "Streptopelia risoria"),
                                        values = c("#000000", "#fb8072", "#984ea3", "#33a02c")) +
  theme(panel.spacing = margin(t = 0, b = 0, r = 0, l = 0),
        plot.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 5, b = -20, r = 0, l = 0)) +
  guides(colour = guide_legend(title.theme = element_text(size = 10, face = "bold", family = "Helvetica"),
                               label.theme = element_text(size = 7.5, family = "Helvetica", face = "italic"),
                               override.aes = list(size = .35, alpha = .9)))


# Saves the plot ~
ggsave(PhyloData1, file = "FPG--PhyloData_I.pdf", device = cairo_pdf, scale = 1.5, width = 4, height = 4, dpi = 600)


#
##
### The END ~~~~~


#geom_text(aes(label = node), size = .5, hjust=-.3) +