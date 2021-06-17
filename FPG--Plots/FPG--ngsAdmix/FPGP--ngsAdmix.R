### The BEGINNING ~~~~~
##
# > Plots FPGP--ngsAdmix | By George PACHECO


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(tidyverse, optparse, plyr, RColorBrewer, extrafont, gtable, grid)

nb.cols <- 15
MyColours <- colorRampPalette(brewer.pal(8, "Paired"))(nb.cols)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads the data ~
samples <- read.table("FPG.popfile", stringsAsFactors = FALSE, sep = "\t")


# Reads the annotation file ~
ids <- read.table("FPG.annot", stringsAsFactors = FALSE, sep = "\t", header = FALSE)


# Adds column ids names ~
colnames(ids) <- c("Sample_ID", "Population")


# Creates alternative Population column ~
ids$Population_Alt <- ids$Population


# Combines all populations from the Faroe Islands, moves FeralUT into the SaltLakeCity population ~
levels(ids$Population_Alt <- sub("Torshavn", "FaroeIslands", ids$Population_Alt))
levels(ids$Population_Alt <- sub("Ejde", "FaroeIslands", ids$Population_Alt))
levels(ids$Population_Alt <- sub("Sumba", "FaroeIslands", ids$Population_Alt))
levels(ids$Population_Alt <- sub("LjosAir", "FaroeIslands", ids$Population_Alt))
levels(ids$Population_Alt <- sub("Kunoy", "FaroeIslands", ids$Population_Alt))
levels(ids$Population_Alt <- sub("Nolsoy", "FaroeIslands", ids$Population_Alt))
levels(ids$Population_Alt <- sub("Nolsoy", "FaroeIslands", ids$Population_Alt))
levels(ids$Population_Alt <- sub("FeralUT", "SaltLakeCity", ids$Population_Alt))


# Ask Sama ~
fulldf <- data.frame()


# Ask Sama 2 ~
x <- list(c(8, 10, 4, 2, 7, 9, 11, 14, 1, 3, 13, 5, 12, 6, 15),
          c(9, 10, 13, 5, 12, 1, 4, 3, 6, 11, 7, 8, 14, 2),
          c(3, 4, 11, 12, 10, 7, 6, 13, 2, 1, 9, 5, 8),
          c(6, 10, 4, 8, 7, 2, 3, 1, 11, 5, 12, 9),
          c(3, 11, 7, 5, 4, 6, 1, 8, 2, 9, 10),
          c(3, 1, 10, 9, 2, 6, 4, 5, 7, 8),
          c(3, 2, 6, 4, 1, 8, 7, 5, 9),
          c(4, 8, 6, 2, 7, 3, 5, 1),
          c(7, 6, 4, 3, 5, 1, 2),
          c(2, 1, 6, 5, 4, 3),
          c(5, 2, 3, 4, 1),
          c(3, 2, 4, 1),
          c(2, 3, 1),
          c(1, 2))


# Defines samples' IDs ~
sampleid = "Sample_ID"


# Ask Sama 3 ~
for (j in 1:length(samples[,1])){
  data <- read.table(samples[j,1])[,x[[j]]]
  for (i in 1:dim(data)[2]) { 
    temp <- data.frame(Value = data[,i])
    temp$K <- as.factor(rep(i, times = length(temp$Value)))
    temp[sampleid] <- as.factor(ids[sampleid][,1])
    temp$K_Value <- as.factor(rep(paste("K = ", dim(data)[2], sep = ""), times = length(temp$Value)))
    temp <- merge(ids, temp)
    fulldf <- rbind(fulldf, temp)}}


## Corrects population names ~
levels(fulldf$Population_Alt <- sub("FaroeIslands", "Faroe Islands", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("WadiHidan", "Wadi Hidan", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("Tatui", "Tatuí", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("PigeonIsland", "Pigeon Island", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("Guimaraes", "Guimarães", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("SaltLakeCity", "Salt Lake City", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("MexicoCity", "Mexico City", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("TlaxcalaDeXicohtencatl", "Tlaxcala de Xicohténcatl", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("SanCristobalDeLasCasas", "San Cristóbal de las Casas", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("TelAvivColony", "Tel Aviv Colony", fulldf$Population_Alt))
levels(fulldf$Population_Alt <- sub("TelAviv", "Tel Aviv", fulldf$Population_Alt))


# Reorganises the data ~
fulldf$Population_Alt <- factor(fulldf$Population_Alt, ordered = T, levels = c("Faroe Islands", "Crete", "Sardinia", "Vernelle", "Wadi Hidan", "Pigeon Island", "Trincomalee",
                                                                         "Guimarães", "Lisbon", "Barcelona", "London", "Cambridge", "Copenhagen", "Berlin", "Prague", "Jihlava", "Abadeh", "Isfahan", "Lahijan", "Nowshahr", "Tehran", "Tel Aviv", "Colombo",
                                                                         "Salt Lake City", "Denver", "FeralVA", "Mexico City", "Monterrey", "Tlaxcala de Xicohténcatl", "San Cristóbal de las Casas", "Santiago", "Salvador", "Tatuí", "Nairobi", "Johannesburg", "Perth",
                                                                         "Tel Aviv Colony","Wattala", "Wellawatte"))


# Defines the target to be plotted ~
target = "Population_Alt"


# Creates the plots ~
ngsAdmix <-
 ggplot(fulldf, aes(x = Sample_ID, y = Value, fill = K)) +
  geom_bar(stat = "identity", width = 2.15) +
   facet_grid(K_Value ~ get(target), space = "free_x", scales = "free_x") +
   scale_x_discrete(expand = c(0, 0)) + 
   scale_y_continuous(expand = c(0, 0), breaks = NULL) +
   #scale_fill_manual(values = MyColours) +
     theme(panel.background = element_rect(fill = "#ffffff"),
      panel.grid.minor.x = element_blank(),
      panel.grid.major = element_blank(),
      panel.spacing = unit(.2, "lines"),
      plot.title = element_blank(),
      axis.title = element_blank(),
      axis.text.x = element_blank(),
      #axis.text.x.bottom = element_text(colour = "#000000", size = 6, angle = 90, vjust = 0, hjust = 1),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      strip.background = element_rect(colour = "#000000", fill = '#FAFAFA', size = 0.05),
      strip.text.x = element_text(colour = "#000000", face = "bold", size = 10, angle = 90, margin = margin(.1, 0, .1, 0, "cm")),
      strip.text.y = element_text(colour = "#000000", face = "bold", size = 10, angle = 90, margin = margin(0, .1, 0, .1, "cm")),
      legend.position = "none")


# Adds grob ~
ngsAdmix_G <- ggplotGrob(ngsAdmix)
ngsAdmix_G <- gtable_add_rows(ngsAdmix_G, unit(1.25, "cm"), pos = 5)


# Adds top strips ~
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#44AA99", alpha = .9, size = .75, lwd = 0.25)),
               textGrob("Remote Localities Within Natural Range", gp = gpar(cex = 1.4, fontface = 'bold', col = "black"))),
               t = 6, l = 4, b = 6, r = 17, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#F0E442", alpha = .9, size = .75, lwd = 0.25)),
               textGrob("Urban Localities Within Natural Range", gp = gpar(cex = 1.4, fontface = 'bold', col = "black"))),
               t = 6, l = 19, b = 6, r = 49, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#E69F00", alpha = .9, size = .5, lwd = 0.25)),
               textGrob("Localities Outside Natural Range", gp = gpar(cex = 1.4, fontface = 'bold', col = "black"))),
               t = 6, l = 51, b = 6, r = 75, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#56B4E9", alpha = .9, size = .5, lwd = 0.25)),
               textGrob("Captives", gp = gpar(cex = 1.4, fontface = 'bold', col = "black"))),
               t = 6, l = 77, b = 6, r = 81, name = c("a", "b"))


# Controls separation ~
ngsAdmix_G <- gtable_add_rows(ngsAdmix_G, unit(2/10, "line"), 6)


# Creates the final plot ~
grid.newpage()
grid.draw(ngsAdmix_G)


# Saves the final plot ~
ggsave(ngsAdmix_G, file = "FPG--ngsAdmix_RColours.pdf", device = cairo_pdf, width = 40, height = 15, dpi = 600)


#
##
### The END ~~~~~




#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13),
#c(1,2,3,4,5,6,7,8,9,10,11,12),
#c(1,2,3,4,5,6,7,8,9,10,11),
#c(1,2,3,4,5,6,7,8,9,10),
#c(1,2,3,4,5,6,7,8,9),
#c(1,2,3,4,5,6,7,8),
#c(1,2,3,4,5,6,7),
#c(1,2,3,4,5,6),
#c(1,2,3,4,5),
#c(1,2,3,4),
#c(1,2,3),
#c(1,2))