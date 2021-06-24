### The BEGINNING ~~~~~
##
# > Plots FPG--Phylogeny | By George PACHECO


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(ggtree, tidyverse, ggrepel, extrafont, treeio, ape, ggtreeExtra, phyloseq)

dat2 <- read.csv("data/HMP_tree/ringheatmap_attr.csv")


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Reads datasets ~
Data1 <- read.newick("FPGP--GoodSamples--Article--Ultra.nwk")
Data2 <- read.tree(file = "FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.FINAL.raxml.support")


# Reads annotations ~
Data2_annot <- read.table("FPG--GoodSamples_FPG--GoodSamples_NoSrisoriaNoCpalumbus.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
colnames(Data2_annot) <- c("Sample_ID", "Population")


# Roots the phylogeny ~
Data1_rooted <- root(Data1, which(Data1$tip.label == "Srisoria_01-GBS"))
Data2_rooted <- root(Data2, which(Data2$tip.label == "Crupestris_01-WGS"))


# Selects clades to highlight ~
outgroups1 <- list(outgroup1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"),
                  outgroup2 = c("Cpalumbus_01-GBS", "Cpalumbus_02-GBS", "Cpalumbus_03-GBS", "Cpalumbus_04-GBS", "Cpalumbus_05-GBS"),
                  outgroup3 = c("Srisoria_01-GBS"))
Data1_rooted <- groupOTU(Data1_rooted, outgroups1)

highlightData2 <- list(group1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"))
Data2_rooted <- groupOTU(Data2_rooted, highlightData2)


# Creates the plot ~
Phylo1 <-
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

Data2_rooted <- fortify(Data2_rooted)

Phylo2 <-
  ggtree(Data2_rooted, aes(colour = group, show.legend = TRUE), layout = "circular", size = .125) +
  geom_tiplab(align = TRUE, linesize = .02, size = .7, show.legend = FALSE) +
  geom_point2(aes(label = label, subset = !is.na(as.numeric(label)) & as.numeric(label) > 70), shape = 21, size = .6, fill = "#155211", colour = "#000000", alpha = .9, stroke = .07) +
  scale_colour_manual(name = "Species", labels = c("Columba livia", "Columba rupestris", "Columba palumbus", "Streptopelia risoria"),
                      values = c("#000000", "#fb8072", "#984ea3", "#33a02c")) +
  geom_treescale(x = 12, y = 12, label = "Scale", fontsize = 4, offset.label = 4, family = "Helvetica") +
  theme(panel.spacing = margin(t = 0, b = 0, r = 0, l = 0),
        plot.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 5, b = -20, r = 0, l = 0)) +
  guides(colour = guide_legend(title.theme = element_text(size = 10, face = "bold", family = "Helvetica"),
                               label.theme = element_text(size = 7.5, family = "Helvetica", face = "italic"),
                               override.aes = list(size = .35, alpha = .9)))

?geom_treescale


# Saves the plot ~
ggsave(Phylo1, file = "FPG--PhyloData_I.pdf", device = cairo_pdf, scale = 1.5, width = 4, height = 4, dpi = 600)
ggsave(Phylo2, file = "FPG--PhyloData_IInt.pdf", device = cairo_pdf, scale = 1.5, width = 4, height = 4, dpi = 600)


#
##
### The END ~~~~~


#geom_text(aes(label = node), size = .5, hjust=-.3) +