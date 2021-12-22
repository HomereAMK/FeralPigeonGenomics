### The BEGINNING ~~~~~
##
# ~ Plots FPG--PCA | First written by Homère J. Alves Monteiro with later modifications by George Pacheco.


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(optparse, tidyverse, plyr, RColorBrewer, extrafont, ggforce, ggstar, RcppCNPy)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads data ~
data <- as.matrix(read.table("FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.cov"))
annot <- read.table("FPG--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicates.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)


# Runs PCA ~
PCA <- eigen(data)


# Merges the first 3 PCs with annot ~
PCA_Annot <- as.data.frame(cbind(annot, PCA$vectors[, c(1:3)]))
colnames(PCA_Annot) <- c("Sample_ID", "Population", "PCA_1", "PCA_2", "PCA_3")


# Expands the data by adding BioStatus ~
PCA_Annot$BioStatus <- ifelse(PCA_Annot$Population %in% c("Torshavn","Ejde","Sumba","LjosAir","Kunoy","Nolsoy", "Crete", "Sardinia","Vernelle","WadiHidan","PigeonIsland","Trincomalee"), "Remote_Localities_Within_Natural_Range",
                       ifelse(PCA_Annot$Population %in% c("Guimaraes","Lisbon","Barcelona","Berlin","Cambridge",
                                                          "Colombo","Copenhagen","London","Prague","Jihlava","Abadeh",
                                                          "Isfahan","Lahijan","Nowshahr","Tehran","TelAviv"), "Urban_Localities_Within_Natural_Range",
                       ifelse(PCA_Annot$Population %in% c("SaltLakeCity","Denver", "FeralVA", "FeralUT", "TlaxcalaDeXicohtencatl",
                                                          "MexicoCity","Monterrey","SanCristobalDeLasCasas","Santiago",
                                                          "Salvador","Tatui","Johannesburg","Nairobi","Perth"), "Localities_Outside_Natural_Range",
                       ifelse(PCA_Annot$Population %in% c("TelAvivColony","Wattala", "Wellawatte"), "Captives", NA))))


# Expands the data by adding Groups ~
PCA_Annot$Groups <- ifelse(PCA_Annot$Population %in% c("PigeonIsland", "Trincomalee"), "Group A",
                    ifelse(PCA_Annot$Population %in% c("Abadeh", "Tehran", "Crete", "Sardinia", "Vernelle", "Torshavn", "Ejde", "Sumba", "LjosAir", "Kunoy", "Nolsoy"), "Group B",
                    ifelse(PCA_Annot$Population %in% c("TelAviv", "TelAvivColony", "WadiHidan"), "Group C",
                    ifelse(PCA_Annot$Population %in% c("Nairobi", "Colombo", "Lahijan", "Nowshahr", "Wellawatte", "Isfahan"), "Group D",
                    ifelse(PCA_Annot$Population %in% c("Guimaraes", "Barcelona", "Lisbon", "Salvador", "Tatui","Denver" , "Santiago", "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas"), "Group E",
                    ifelse(PCA_Annot$Population %in% c("Jihlava", "Prague", "Berlin", "SaltLakeCity", "Johannesburg", "London", "Cambridge", "Perth", "Copenhagen"), "Group F", "Not Grouped"))))))


# Creates alternative Population column ~
PCA_Annot$Population_cbind <- PCA_Annot$Population


# Combines all populations from the Faroe Islands ~
levels(PCA_Annot$Population_cbind <- sub("Torshavn", "FaroeIslands", PCA_Annot$Population_cbind))
levels(PCA_Annot$Population_cbind <- sub("Ejde", "FaroeIslands", PCA_Annot$Population_cbind))
levels(PCA_Annot$Population_cbind <- sub("Sumba", "FaroeIslands", PCA_Annot$Population_cbind))
levels(PCA_Annot$Population_cbind <- sub("LjosAir", "FaroeIslands", PCA_Annot$Population_cbind))
levels(PCA_Annot$Population_cbind <- sub("Kunoy", "FaroeIslands", PCA_Annot$Population_cbind))
levels(PCA_Annot$Population_cbind <- sub("Nolsoy", "FaroeIslands", PCA_Annot$Population_cbind))


## Reorders BioStatus ~
PCA_Annot$BioStatus <- factor(PCA_Annot$BioStatus, ordered = T,
                         levels = c("Remote_Localities_Within_Natural_Range",
                                    "Urban_Localities_Within_Natural_Range",
                                    "Localities_Outside_Natural_Range",
                                    "Captives"))

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



# Gets Eigenvalues of each Eigenvectors ~
PCA_Eigenval_Sum <- sum(PCA$values)
(PCA$values[1]/PCA_Eigenval_Sum)*100
(PCA$values[2]/PCA_Eigenval_Sum)*100
(PCA$values[3]/PCA_Eigenval_Sum)*100


# Creates plot ~
PCA_Plot <-
ggplot(PCA_Annot, aes_string(x = "PCA_2", y = "PCA_3")) +
  geom_star(aes(starshape = Groups, fill = BioStatus), size = 2.8, alpha = .9, starstroke = .15) +
  scale_fill_manual(values = c("#44AA99", "#F0E442", "#E69F00", "#56B4E9"), labels = gsub("_", " ", levels(PCA_Annot$BioStatus))) +
  scale_starshape_manual(values = Shapes) +
  geom_mark_ellipse(aes(color = BioStatus, group = Population_cbind, filter = Population_cbind == "FaroeIslands", label = "Faroe Islands"),
                    label.buffer = unit(8, 'mm'), con.colour = "black", con.type = "elbow", label.fill = NA, show.legend = FALSE) +
  geom_mark_ellipse(aes(color = BioStatus, group = Population, filter = Population == "PigeonIsland", label = "Pigeon Island"),
                    label.buffer = unit(40, 'mm'), con.colour = "black", con.type = "elbow", label.fill = NA, show.legend = FALSE) +
  geom_mark_ellipse(aes(color = BioStatus, group = Population, filter = Population == "Trincomalee", label = "Trincomalee"),
                    label.buffer = unit(16, 'mm'), con.colour = "black", con.type = "elbow", label.fill = NA, show.legend = FALSE) +
  scale_x_continuous("PC 2 (1.7%)",
                     #breaks = c(0.99, 1, 1.01),
                     #labels = c("0.99", "1", "1.01"),
                     #limits = c(-0.16, 0.07),
                     expand = c(0, 0)) +
  scale_y_continuous("PC 3 (1.3%)",
                     #breaks = c(-0.05, -0.025, 0, 0.025, 0.05), 
                     #labels = c("-0.05", "-0.025", "0", "0.025", "0.05"), 
                     #limits = c(-0.0525, 0.0525),
                     expand = c(.015, .015)) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        legend.background = element_blank(),
        legend.key = element_blank(),
        legend.position = "right",
        legend.title = element_text(color = "#000000", size = 13),
        legend.text = element_text(size = 11),
        axis.title.x = element_text(size = 18, face = "bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 18, face = "bold", margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text = element_text(color = "#000000", size = 13),
        axis.ticks = element_line(color = "#000000", size = 0.3),
        axis.line = element_line(colour = "#000000", size = 0.3)) +
  guides(fill = guide_legend(title = "Biological Status", title.theme = element_text(size = 16, face = "bold"),
                             label.theme = element_text(size = 14),
                             override.aes = list(starshape = 21, size = 5, alpha = .9, starstroke = .15), order = 1),
         starshape = guide_legend(title = "Groups", title.theme = element_text(size = 16, face = "bold"),
                             label.theme = element_text(size = 14),
                             override.aes = list(starshape = Shapes, size = 5, alpha = .9, starstroke = .15), order = 2),
         colour = "none")


# Saves plot ~
ggsave(PCA_Plot, file = "FPG--PCA_23.pdf", device = cairo_pdf, scale = 1, width = 16, height = 10, dpi = 600)


#
##
### The END ~~~~~