### The BEGINNING ~~~~~
##
# ~ Plots FPG--Phylogeny | By George PACHECO


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(ggtree, tidyverse, ggrepel, extrafont, treeio, ape, ggtreeExtra, ggnewscale, ggstar, reshape2)


# Load helper function ~
source("utilities.R")


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Reads datasets ~
Data2 <- read.tree(file = "FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.FINAL.raxml.support")


# Reads annotations ~
Data2_annot <- read.table("FPG--GoodSamples_FPG--GoodSamples_NoSrisoriaNoCpalumbus.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
colnames(Data2_annot) <- c("label", "Population")


# Expands the data by adding BioStatus ~
Data2_annot$BioStatus <- ifelse(Data2_annot$Population %in% c("Torshavn","Ejde","Sumba","LjosAir","Kunoy","Nolsoy", "Crete", "Sardinia","Vernelle","WadiHidan","PigeonIsland","Trincomalee"), "Remote_Localities_Within_Natural_Range",
                         ifelse(Data2_annot$Population %in% c("Guimaraes","Lisbon","Barcelona","Berlin","Cambridge",
                                                              "Colombo","Copenhagen","London","Prague","Jihlava","Abadeh",
                                                              "Isfahan","Lahijan","Nowshahr","Tehran","TelAviv"), "Urban_Localities_Within_Natural_Range",
                         ifelse(Data2_annot$Population %in% c("SaltLakeCity","Denver", "FeralVA", "FeralUT", "TlaxcalaDeXicohtencatl",
                                                              "MexicoCity","Monterrey","SanCristobalDeLasCasas","Santiago",
                                                              "Salvador","Tatui","Johannesburg","Nairobi","Perth"), "Localities_Outside_Natural_Range",
                         ifelse(Data2_annot$Population %in% c("TelAvivColony","Wattala", "Wellawatte"), "Captives", NA))))


# Expands the data by adding Groups ~
Data2_annot$Groups <- # Remote Localities Within Natural Range
                        ifelse(Data2_annot$Population %in% c("PigeonIsland", "Trincomalee"), "Group_A",
                        ifelse(Data2_annot$Population %in% c("Abadeh", "Tehran", "Crete", "Sardinia", "Vernelle", "Torshavn", "Ejde", "Sumba", "LjosAir", "Kunoy", "Nolsoy"), "Group_B",
                        ifelse(Data2_annot$Population %in% c("TelAviv", "TelAvivColony", "WadiHidan"), "Group_C",
                        ifelse(Data2_annot$Population %in% c("Nairobi", "Colombo", "Lahijan", "Nowshahr", "Wellawatte", "Isfahan"), "Group_D",
                        ifelse(Data2_annot$Population %in% c("Guimaraes", "Barcelona", "Lisbon", "Salvador", "Tatui","Denver" , "Santiago", "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas"), "Group_E",
                        ifelse(Data2_annot$Population %in% c("Jihlava", "Prague", "Berlin", "SaltLakeCity", "Johannesburg", "London", "Cambridge", "Perth", "Copenhagen"), "Group_F",
                        ifelse(Data2_annot$Population %in% c("Wattala"), "Not_Grouped", NA)))))))



Data2_annot <- melt(Data2_annot)
head(Data2_annot)


# Defines the shapes to be used for each Group ~
Shapes <- as.vector(c(# Group A
                      29, 
                      # Group B
                      11,
                      # Group C
                      13,
                      # Group D
                      7,
                      # Group E
                      14,
                      # Group F
                      28,
                      # Not Grouped
                      9))


# Roots the phylogeny ~
Data2_rooted <- root(Data2, which(Data2$tip.label == "Crupestris_01-WGS"))


# Selects clades to highlight ~
highlightData2 <- list(group1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"))
Data2_rooted <- groupOTU(Data2_rooted, highlightData2)


# Reorders BioStatus ~
Data2_annot$BioStatus <- factor(Data2_annot$BioStatus, ordered = T,
                           levels = c("Remote_Localities_Within_Natural_Range",
                                      "Urban_Localities_Within_Natural_Range",
                                      "Localities_Outside_Natural_Range",
                                      "Captives"))


# Reorders Groups ~
Data2_annot$Groups <- factor(Data2_annot$Groups, ordered = T,
                           levels = c("Group_A",
                                      "Group_B",
                                      "Group_C",
                                      "Group_D",
                                      "Group_E",
                                      "Group_F",
                                      "Not_Grouped"))

# Corrects groups ~
#levels(Data2_annot$Groups <- sub("Torshavn", "Tórshavn", fulldf$Population))
#levels(Data2_annot$Groups <- sub("WadiHidan", "Wadi Hidan", fulldf$Population))
#levels(Data2_annot$Groups <- sub("Tatui", "Tatuí", fulldf$Population))
#levels(Data2_annot$Groups <- sub("PigeonIsland", "Pigeon Island", fulldf$Population))
#levels(Data2_annot$Groups <- sub("Guimaraes", "Guimarães", fulldf$Population))


# Creates base phylogeny ~
basePhylo2 <-
  ggtree(Data2_rooted, layout = "circular", aes(colour = group), size = .125) +
  scale_colour_manual(labels = c("Columba livia", "Columba rupestris"), values = c("#000000", "#fb8072"))


# Merges annotation to base phylogeny ~
basePhylo2_annot <- basePhylo2 %<+% Data2_annot


# Creates final phylogeny ~
middlePhylo2 <-
  basePhylo2_annot +
  geom_tiplab(align = TRUE, linesize = .02, size = 1.5, show.legend = FALSE) +
  #geom_text(aes(label = node), size = .5, hjust = -.3) +
  geom_point2(aes(label = label, subset = !is.na(as.numeric(label)) & as.numeric(label) > 70), shape = 21, size = 1.25, fill = "#155211", colour = "#155211", alpha = .9, stroke = .07) +
  geom_star(mapping = aes(fill = BioStatus, starshape = Groups), size = 1.25, starstroke = .07) +
  scale_fill_manual(values = c("#44AA99", "#F0E442", "#E69F00", "#56B4E9"), labels = gsub("_", " ", levels(Data2_annot$BioStatus)), na.translate = FALSE) +
  scale_starshape_manual(values = Shapes, labels = gsub("_", " ", levels(Data2_annot$Groups)), na.translate = FALSE) +
  #geom_treescale(x = 12, y = 12, label = "Scale", fontsize = 4, offset.label = 4, family = "Helvetica") +
  theme(panel.spacing = margin(t = 0, b = 0, r = 0, l = 0),
        plot.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.position = c(.11, .875),
        legend.spacing.y = unit(.25, "cm"),
        legend.key.height = unit(.35, "cm"),
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 5, b = -20, r = 0, l = 0)) +
  guides(colour = guide_legend(title = "Species", title.theme = element_text(size = 11, face = "bold", family = "Helvetica"),
                               label.theme = element_text(size = 8, family = "Helvetica", face = "italic"), override.aes = list(size = .8, starshape = NA), order = 1),
         fill = guide_legend(title = "Biological Status", title.theme = element_text(size = 11, face = "bold", family = "Helvetica"),
                             label.theme = element_text(size = 8, family = "Helvetica"),
                             override.aes = list(starshape = 21, size = 2.85, alpha = .9, starstroke = .0015), order = 2),
         starshape = guide_legend(title = "Groups", title.theme = element_text(size = 11, face = "bold", family = "Helvetica"),
                                  label.theme = element_text(size = 8, family = "Helvetica"),
                                  override.aes = list(starshape = Shapes, size = 2.85, starstroke = .15), order = 3))

finalPhylo2 <-
middlePhylo2 %>% collapse(node = 480, 'max', fill = "#44AA99", alpha = .65)

final2Phylo2 <-
  finalPhylo2 %>% collapse(node = 469, 'max', fill = "#44AA99", alpha = .65)

final2Phylo2


finalPhylo2 <- 
 finalPhylo2 +
 #geom_text2(aes(subset = (node == 480)), cex = 2, label = intToUtf8(9668), hjust = .2, vjust = .45) +
 geom_text2(aes(subset = (node == 480)), label = "Pigeon Island", fontface = "bold", family = "Helvetica", cex = 3, vjust = -6, hjust = -2.5, show.legend = FALSE)


ggsave(finalPhylo2, file = "FPG--PhyloData_II.pdf", device = cairo_pdf, width = 12, height = 12, dpi = 600)

?geom_text2


#
##
### The END ~~~~~