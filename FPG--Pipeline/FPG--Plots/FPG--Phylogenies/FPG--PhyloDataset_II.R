### The BEGINNING ~~~~~
##
# ~ Plots FPG--PhyloData_II | By George PACHECO


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(ggtree, tidyverse, naniar, ggrepel, extrafont, treeio, ape, ggtreeExtra, ggnewscale, ggstar, reshape2, phangorn, adegenet)


# Load helper function ~
source("utilities.R")


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Reads datasets ~
Data <- read.tree(file = "FPG--GoodSamples_NoSrisoriaNoCpalumbus_100BSs.raxml.support")


# Reads annotations ~
Data_annot <- read.table("FPG--GoodSamples_FPG--GoodSamples_NoSrisoriaNoCpalumbus.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
colnames(Data_annot) <- c("label", "Population")


# Expands the data by adding BioStatus ~
Data_annot$BioStatus <- ifelse(Data_annot$Population %in% c("Torshavn","Ejde","Sumba","LjosAir","Kunoy","Nolsoy", "Crete", "Sardinia","Vernelle","WadiHidan","PigeonIsland","Trincomalee"), "Remote_Localities_Within_Natural_Range",
                        ifelse(Data_annot$Population %in% c("Guimaraes","Lisbon","Barcelona","Berlin","Cambridge",
                                                            "Colombo","Copenhagen","London","Prague","Jihlava","Abadeh",
                                                            "Isfahan","Lahijan","Nowshahr","Tehran","TelAviv"), "Urban_Localities_Within_Natural_Range",
                        ifelse(Data_annot$Population %in% c("SaltLakeCity","Denver", "FeralVA", "FeralUT", "TlaxcalaDeXicohtencatl",
                                                            "MexicoCity","Monterrey","SanCristobalDeLasCasas","Santiago",
                                                            "Salvador","Tatui","Johannesburg","Nairobi","Perth"), "Localities_Outside_Natural_Range",
                        ifelse(Data_annot$Population %in% c("TelAvivColony","Wattala", "Wellawatte"), "Captives", NA))))


# Melts the annotation dataset ~
Data_annot <- melt(Data_annot)


# Roots the phylogeny ~
Data_rooted <- root(Data, node = 507)


# Selects clades to highlight ~
groups <- list(group1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"))
Data_rooted <- groupOTU(Data_rooted, groups)


# Reorders BioStatus ~
Data_annot$BioStatus <- factor(Data_annot$BioStatus, ordered = T,
                        levels = c("Remote_Localities_Within_Natural_Range",
                                   "Urban_Localities_Within_Natural_Range",
                                   "Localities_Outside_Natural_Range",
                                   "Captives"))


# Creates base phylogeny ~
basePhylo <-
  ggtree(Data_rooted, layout = "circular", size = .125, aes(colour = group), branch.length = "none") +
  scale_colour_manual(labels = c("Columba livia", "Columba rupestris"), values = c("#000000", "#fb8072"), na.value = NA)


# Merges annotation to base phylogeny ~
basePhylo_annot <- basePhylo %<+% Data_annot


# Creates final phylogeny ~
Plot <-
  basePhylo_annot +
  geom_point2(aes(label = label, subset = !is.na(as.numeric(label)) & as.numeric(label) > 75), shape = 21, size = 1.75, fill = "#155211", colour = "#000000", alpha = .85, stroke = .07, show.legend = FALSE) +
  geom_tippoint(aes(fill = BioStatus, subset = !is.na(BioStatus)), size = 1.75, alpha = 1, shape = 21, colour = "#000000", na.rm = TRUE) +
  geom_strip("PigeonIsland_05-GBS", "Trincomalee_01-GBS", barsize = 3.5, color = "#d9d9d9", label = "Group A", fontsize = 6, offset = 1.25, offset.text = 2) +
  geom_strip("Abadeh_04-GBS", "Torshavn_02-GBS", barsize = 3.5, color = "#bdbdbd", label = "Group B", fontsize = 6, offset = 1.25, offset.text = 2) +
  geom_strip("TelAviv_07-GBS", "Isfahan_03-GBS", barsize = 3.5, color = "#969696", label = "Group C", fontsize = 6, offset = 1.25, offset.text = 6) +
  geom_strip("Barcelona_15-GBS", "Monterrey_05-GBS", barsize = 3.5, color = "#636363", label = "Group D", fontsize = 6, offset = 1.25, offset.text = 7.5) +
  geom_strip("Berlin_04-GBS", "London_05-GBS", barsize = 3.5, color = "#252525", label = "Group E", fontsize = 6, offset = 1.25, offset.text = 2) +
  scale_fill_manual(values = c("#44AA99", "#F0E442", "#E69F00", "#56B4E9", "#ff0000"), labels = gsub("_", " ", levels(Data_annot$BioStatus)), na.translate = FALSE) +
  #scale_fill_discrete(na.value = NA, na.translate = FALSE) +
  theme(panel.spacing = margin(t = 0, b = 0, r = 0, l = 0),
        plot.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.position = c(.11, .875),
        legend.spacing.y = unit(.25, "cm"),
        legend.key.height = unit(.35, "cm"),
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 5, b = -20, r = 0, l = 0)) +
  guides(colour = guide_legend(title = "Species", title.theme = element_text(size = 11, face = "bold"),
                               label.theme = element_text(size = 8, face = "italic"), override.aes = list(size = .8, starshape = NA), order = 1),
         fill = guide_legend(title = "Biological Status", title.theme = element_text(size = 11, face = "bold"),
                             label.theme = element_text(size = 8),
                             override.aes = list(starshape = 21, size = 2.85, alpha = .9, starstroke = .0015), order = 2))


# Saves plot ~
ggsave(Plot, file = "FPG--GoodSamples_NoSrisoriaNoCpalumbus_100BSs.pdf", device = cairo_pdf, width = 16, height = 16, scale = .9, dpi = 600)
ggsave(Plot, file = "FPG--GoodSamples_NoSrisoriaNoCpalumbus_100BSs.jpg", width = 16, height = 16, scale = .9, dpi = 300)


#geom_text(aes(label = node), hjust= -.15) + # Shows node labels.
#geom_tiplab(align = TRUE, linesize = .02, size = 1.5, show.legend = FALSE) + # Shows tip labels.
#scale_starshape_manual(values = Shapes, labels = gsub("_", " ", levels(Data_annot$Groups)), na.translate = FALSE) +
#geom_fruit(geom = geom_tile, mapping = aes(fill = BioStatus), alpha = .9, colour = NA, offset = .04, width = .5, show.legend = FALSE) +
#geom_treescale(x = 12, y = 12, label = "Scale", fontsize = 4, offset.label = 4, family = "Helvetica") +
#geom_star(mapping = aes(fill = BioStatus, starshape = Groups), size = 1.75, starstroke = .07) +





#################################################################################################################
       
Matrix <- as.matrix(read.table(file = "FPG--GoodSamples_NoSrisoriaNoCpalumbus.dist", head = FALSE, row.names = 1))
NJphylo <- bionj(as.dist(Matrix))
       
#write.tree(NJphylo, file = "NJphylo.nwk")


# Expands the data by adding Groups ~
Data_annot$Groups <- # Remote Localities Within Natural Range
  ifelse(Data_annot$Population %in% c("PigeonIsland", "Trincomalee"), "Group_A",
  ifelse(Data_annot$Population %in% c("Abadeh", "Tehran", "Crete", "Sardinia", "Vernelle", "Torshavn", "Ejde", "Sumba", "LjosAir", "Kunoy", "Nolsoy"), "Group_B",
  ifelse(Data_annot$Population %in% c("TelAviv", "TelAvivColony", "WadiHidan"), "Group_C",
  ifelse(Data_annot$Population %in% c("Nairobi", "Colombo", "Lahijan", "Nowshahr", "Wellawatte", "Isfahan"), "Group_D",
  ifelse(Data_annot$Population %in% c("Guimaraes", "Barcelona", "Lisbon", "Salvador", "Tatui","Denver" , "Santiago", "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas"), "Group_E",
  ifelse(Data_annot$Population %in% c("Jihlava", "Prague", "Berlin", "SaltLakeCity", "Johannesburg", "London", "Cambridge", "Perth", "Copenhagen"), "Group_F",
  ifelse(Data_annot$Population %in% c("Wattala"), "Not_Grouped", NA))))))))

# Reorders Groups ~
Data_annot$Groups <- factor(Data_annot$Groups, ordered = T,
                            levels = c("Group_A",
                                       "Group_B",
                                       "Group_C",
                                       "Group_D",
                                       "Group_E",
                                       "Group_F",
                                       "Not_Grouped"))


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



# Pigeon Island & Trincomalee ~
collapsePhylo2_1 <-
  Plot %>% collapse(node = 523, "max", fill = "#44AA99", alpha = .9)

# Pigeon Island & Trincomalee ~
collapsePhylo2_1 <- collapse(Plot, node = 523) + 
  geom_point2(aes(subset = (node == 523)), shape = 21, size = 5, fill = "#44AA99")

# Faroe Islands ~
collapsePhylo2_2 <-
  collapsePhylo2_1 %>% collapse(node = 567, "max", fill = "#44AA99", alpha = .7)

# Sardinia ~
collapsePhylo2_3 <-
  collapsePhylo2_2 %>% collapse(node = 489, "max", fill = "#44AA99", alpha = .7)

# Vernelle ~
collapsePhylo2_4 <-
  collapsePhylo2_3 %>% collapse(node = 553, "max", fill = "#44AA99", alpha = .7)


# Tel Aviv Colony ~
collapsePhylo2_5 <-
  collapsePhylo2_4 %>% collapse(node = 596, "max", fill = "#44AA99", alpha = .7)






# Tel Aviv, Tel Aviv Colony, Wadi Hidan ~
collapsePhylo2_5 <-
  collapsePhylo2_4 %>% collapse(node = 586, "max", fill = "#44AA99", alpha = .7)
  



# Barcelona ~
collapsePhylo2_4 <-
 collapsePhylo2_3 %>% collapse(node = 900, 'max', fill = "#F0E442", alpha = .7)

# Salvador ~
collapsePhylo2_5 <-
 collapsePhylo2_4 %>% collapse(node = 886, 'max', fill = "#E69F00", alpha = .7)

# Tatuí ~
collapsePhylo2_6 <-
 collapsePhylo2_5 %>% collapse(node = 867, 'max', fill = "#E69F00", alpha = .7)

# Santiago ~
collapsePhylo2_7 <-
 collapsePhylo2_6 %>% collapse(node = 851, 'max', fill = "#E69F00", alpha = .7)

# Monterrey ~
collapsePhylo2_8 <-
  collapsePhylo2_7 %>% collapse(node = 837, 'max', fill = "#E69F00", alpha = .7)

# San Cristóbal de las Casas ~
collapsePhylo2_9 <-
  collapsePhylo2_8 %>% collapse(node = 824, 'max', fill = "#E69F00", alpha = .7)

# Nairobi ~
collapsePhylo2_10 <-
  collapsePhylo2_9 %>% collapse(node = 639, 'max', fill = "#E69F00", alpha = .7)

# Colombo ~
collapsePhylo2_11 <-
  collapsePhylo2_10 %>% collapse(node = 629, 'max', fill = "#F0E442", alpha = .7)

# Colombo ~
collapsePhylo2_12 <-
  collapsePhylo2_11 %>% collapse(node = 629, 'max', fill = "#F0E442", alpha = .7)


finalPhylo2 <- 
 collapsePhylo2_1 +
  
  geom_text2(aes(subset = (node == 523)), label = "Pigeon Island & Trincomalee", fontface = "bold", family = "Helvetica", cex = 3, vjust = 0, hjust = 0, show.legend = FALSE) +
  geom_text2(aes(subset = (node == 567)), label = "Faroe Islands", fontface = "bold", family = "Helvetica", cex = 3, vjust = 0, hjust = -3, show.legend = FALSE) +
  geom_text2(aes(subset = (node == 489)), label = "Sardinia", fontface = "bold", family = "Helvetica", cex = 3, vjust = 0, hjust = -6, show.legend = FALSE) +
  geom_text2(aes(subset = (node == 553)), label = "Vernelle", fontface = "bold", family = "Helvetica", cex = 3, vjust = 0, hjust = -6, show.legend = FALSE) +
  geom_text2(aes(subset = (node == 596)), label = "Tel Aviv Colony", fontface = "bold", family = "Helvetica", cex = 3, vjust = 0, hjust = -2, show.legend = FALSE)
  
  geom_text2(aes(subset = (node == 588)), label = "Tel Aviv Colony", fontface = "bold", family = "Helvetica", cex = 2.25, vjust = 0, hjust = -2, angle = 95, show.legend = FALSE) +
  geom_star(aes(subset = (node == 588)), starshape = 13, size = 1.25, fill = "#56B4E9", alpha = .9, starstroke = .07, show.legend = FALSE) +
  
  geom_text2(aes(subset = (node == 639)), label = "Nairobi", fontface = "bold", family = "Helvetica", cex = 2.25, vjust = 0, hjust = -6.5, angle = 120, show.legend = FALSE) +
  geom_star(aes(subset = (node == 639)), starshape = 7, size = 1.25, fill = "#E69F00", alpha = .9, starstroke = .07, show.legend = FALSE) +
  
  geom_text2(aes(subset = (node == 629)), label = "Colombo", fontface = "bold", family = "Helvetica", cex = 2.25, vjust = -.85, hjust = -5, angle = 130, show.legend = FALSE) +
  geom_star(aes(subset = (node == 629)), starshape = 7, size = 1.25, fill = "#F0E442", alpha = .9, starstroke = .07, show.legend = FALSE) +
  
  geom_text2(aes(subset = (node == 900)), label = "Barcelona", fontface = "bold", family = "Helvetica", cex = 2.25, vjust = -3, hjust = 5.75, angle = -2.5, show.legend = FALSE) +
  geom_star(aes(subset = (node == 900)), starshape = 14, size = 1.25, fill = "#F0E442", starstroke = .07, show.legend = FALSE) +
  
  geom_text2(aes(subset = (node == 886)), label = "Salvador", fontface = "bold", family = "Helvetica", cex = 2.25, vjust = 15, hjust = 6, angle = 12, show.legend = FALSE) +
  geom_star(aes(subset = (node == 886)), starshape = 13, size = 1.25, fill = "#56B4E9", starstroke = .07, show.legend = FALSE) +
  
  geom_text2(aes(subset = (node == 867)), label = "Tatuí", fontface = "bold", family = "Helvetica", cex = 2.25, vjust = 0, hjust = 0, angle = 0, show.legend = FALSE) +
  geom_star(aes(subset = (node == 867)), starshape = 13, size = 1.25, fill = "#56B4E9", starstroke = .07, show.legend = FALSE) +
  
  geom_text2(aes(subset = (node == 851)), label = "Santiago", fontface = "bold", family = "Helvetica", cex = 2.25, vjust = 0, hjust = 0, angle = 0, show.legend = FALSE) +
  geom_star(aes(subset = (node == 851)), starshape = 13, size = 1.25, fill = "#56B4E9", starstroke = .07, show.legend = FALSE) +
  
  geom_text2(aes(subset = (node == 824)), label = "San Cristóbal de las Casas", fontface = "bold", family = "Helvetica", cex = 2.25, vjust = 0, hjust = 0, angle = 0, show.legend = FALSE) +
  geom_star(aes(subset = (node == 824)), starshape = 13, size = 1.25, fill = "#56B4E9", starstroke = .07, show.legend = FALSE)

 
ggsave(finalPhylo2, file = "FPG--PhyloData_II_Collapsed.pdf", device = cairo_pdf, width = 12, height = 18, dpi = 600)


#
##
### The END ~~~~~

geom_text(aes(label = node), size = 1, hjust = -.3) +