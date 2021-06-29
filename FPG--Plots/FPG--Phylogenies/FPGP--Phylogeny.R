### The BEGINNING ~~~~~
##
# > Plots FPG--Phylogeny | By George PACHECO


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(ggtree, tidyverse, ggrepel, extrafont, treeio, ape, ggtreeExtra, ggnewscale, ggstar)


# Load helper function ~
source("utilities.R")


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Reads datasets ~
#Data1 <- read.newick("FPGP--GoodSamples--Article--Ultra.nwk")
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
                         ifelse(Data2_annot$Population %in% c("TelAvivColony","Wattala", "Wellawatte"), "Captives", "Outgroup"))))


# Expands the data by adding Groups ~
Data2_annot$Groups <- # Remote Localities Within Natural Range
                        ifelse(Data2_annot$Population %in% c("PigeonIsland", "Trincomalee"), "Group_A",
                        ifelse(Data2_annot$Population %in% c("Abadeh", "Tehran", "Crete", "Sardinia", "Vernelle", "Torshavn", "Ejde", "Sumba", "LjosAir", "Kunoy", "Nolsoy"), "Group_B",
                        ifelse(Data2_annot$Population %in% c("TelAviv", "TelAvivColony", "WadiHidan"), "Group_C",
                        ifelse(Data2_annot$Population %in% c("Nairobi", "Colombo", "Lahijan", "Nowshahr", "Wellawatte", "Isfahan"), "Group_D",
                        ifelse(Data2_annot$Population %in% c("Guimaraes", "Barcelona", "Lisbon", "Salvador", "Tatui","Denver" , "Santiago", "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas"), "Group_E",
                        ifelse(Data2_annot$Population %in% c("Jihlava", "Prague", "Berlin", "SaltLakeCity", "Johannesburg", "London", "Cambridge", "Perth", "Copenhagen"), "Group_F", "Not_Grouped"))))))


# Roots the phylogeny ~
#Data1_rooted <- root(Data1, which(Data1$tip.label == "Srisoria_01-GBS"))
Data2_rooted <- root(Data2, which(Data2$tip.label == "Crupestris_01-WGS"))


# Selects clades to highlight ~
#outgroups1 <- list(outgroup1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"),
                  #outgroup2 = c("Cpalumbus_01-GBS", "Cpalumbus_02-GBS", "Cpalumbus_03-GBS", "Cpalumbus_04-GBS", "Cpalumbus_05-GBS"),
                  #outgroup3 = c("Srisoria_01-GBS"))
#Data1_rooted <- groupOTU(Data1_rooted, outgroups1)

highlightData2 <- list(group1 = c("Crupestris_01-WGS", "Crupestris_01-GBS"))
Data2_rooted <- groupOTU(Data2_rooted, highlightData2)


# Fortifies DF so it can be merged ~
# Data2_rooted <- fortify(Data2_rooted)


# Bind the 2 DFs based on common columns ~
# fullData2_rooted <- mybind(Data2_rooted, Data2_annot)


# Reorders BioStatus ~
Data2_annot$BioStatus <- factor(Data2_annot$BioStatus, ordered = T,
                           levels = c("Remote_Localities_Within_Natural_Range",
                                      "Urban_Localities_Within_Natural_Range",
                                      "Localities_Outside_Natural_Range",
                                      "Captives",
                                      "Outgroup"))


basePhylo2 <-
  ggtree(Data2_rooted, aes(colour = group, show.legend = TRUE), layout = "fan", size = .125) +
  geom_tiplab(align = TRUE, linesize = .02, size = .7, show.legend = FALSE) +
  geom_point2(aes(label = label, subset = !is.na(as.numeric(label)) & as.numeric(label) > 70), shape = 21, size = .6, fill = "#155211", colour = "#ffffff", alpha = .9, stroke = .07) +
  scale_colour_manual(name = "Species", labels = c("Columba livia", "Columba rupestris", "Columba palumbus", "Streptopelia risoria"),
                      values = c("#000000", "#fb8072")) +
  #geom_treescale(x = 12, y = 12, label = "Scale", fontsize = 4, offset.label = 4, family = "Helvetica") +
  theme(panel.spacing = margin(t = 0, b = 0, r = 0, l = 0),
        plot.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.position = "right",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 5, b = -20, r = 0, l = 0)) +
  guides(colour = guide_legend(title.theme = element_text(size = 10, face = "bold", family = "Helvetica"),
                               label.theme = element_text(size = 7.5, family = "Helvetica", face = "italic"),
                               override.aes = list(size = .35, alpha = .9)))


middlePhylo2 <-
 basePhylo2 +
  geom_star(data = Data2_annot, mapping = aes(fill = BioStatus, size = 2, starshape = Groups), starstroke = .2) +
  scale_size_continuous(range = c(1, 3),
  guide = guide_legend(keywidth = .5, keyheight = .5, override.aes = list(starshape = 15), order = 2)) +
  scale_fill_manual(values=c("#F8766D", "#C49A00", "#53B400", "#00C094", "#00B6EB", "#A58AFF", "#FB61D7"), guide = "none") +
  scale_starshape_manual(values = c(1, 15), guide = guide_legend(keywidth = .5, keyheight = .5, order = 1), na.translate = FALSE)


fullPhylo2 <- 
 basePhylo2 +
 new_scale_fill() +
 geom_fruit(data = Data2_annot, geom = geom_tile,
            mapping = aes(y = label, x = BioStatus, fill = BioStatus),
            width = .005, color = "#000000", offset = .08, pwidth = .25) +
  scale_fill_manual(name = "Biological Status", values = c("#44AA99", "#F0E442", "#E69F00", "#56B4E9", "#fb8072"),
                    guide = guide_legend(keywidth = .5, keyheight = .5, order = 2))


ggsave(fullPhylo2, file = "FPG--PhyloData_II.pdf", device = cairo_pdf, width = 12, height = 12, dpi = 600)




, axis.params=list(axis = "x", text.angle = -45, hjust = 0)
+
  
  geom_tiplab(align = TRUE, linesize = 0, offset = 6, size = 2) +
  xlim_tree(xlim = c(0, 36)) +
  scale_y_continuous(limits = c(-1, NA))

??geom_axis_text
??ggtreeExtra



   guide = guide_legend(keywidth = .5, keyheight = .5)) +
  new_scale_fill()




?geom_fruit
  
  
  
  scale_alpha_continuous(range = c(0, 1),
                         guide = guide_legend(keywidth = 0.3, keyheight = 0.3, order=5))





  scale_fill_manual(values=c("#0000FF", "#FFA500", "#FF0000", "#800000",
                             "#006400", "#800080", "#696969"),
                    guide = guide_legend(keywidth = 0.3, keyheight = .3, order = 4))+
  geom_treescale(fontsize = 2, linesize = .3, x = 4.9, y = .1) +
  theme(legend.position = c(0.93, 0.5),
        legend.background = element_rect(fill = NA),
        legend.title = element_text(size = 6.5),
        legend.text = element_text(size = 4.5),
        legend.spacing.y = unit(.02, "cm"))
  
  

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







mapping = aes(shape = Groups), 


# Saves the plot ~
ggsave(Phylo1, file = "FPG--PhyloData_I.pdf", device = cairo_pdf, scale = 1.5, width = 4, height = 4, dpi = 600)



#
##
### The END ~~~~~


#geom_text(aes(label = node), size = .5, hjust=-.3) +