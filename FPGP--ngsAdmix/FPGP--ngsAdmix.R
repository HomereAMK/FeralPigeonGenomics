### The BEGINNING ~~~~
##
# > Plots FPGP--ngsAdmix | By George PACHECO


# Sets working directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages:

pacman::p_load(optparse, ggplot2, plyr, RColorBrewer, extrafont, gtable, grid)

# Imports extra fonts:

loadfonts(device = "win", quiet = TRUE)

# Reads data

samples <- read.table("GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives.popfile", stringsAsFactors = FALSE, sep = "\t")

# Reads annotation file

ids <- read.table("GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives.annot", stringsAsFactors = FALSE, sep = "\t", header = TRUE)

# Reorganises the data:

ids$Location <- factor(ids$Location, ordered = T, levels=c("SaltLakeCity","Denver","Virginia","Monterrey","MexicoCity","TlaxcalaDeXicohtencatl","SanCristobalDeLasCasas","Santiago","Salvador",
                                                         "Tatui","FaroeIslands","Copenhagen","Cambridge","London","Berlin","Prague","Jihlava","Vernelle","Barcelona","Guimaraes","Lisbon","Sardinia","Crete",
                                                         "Nairobi","Johannesburg","Lahijan","Nowshahr","Tehran","Isfahan","Abadeh", "TelAviv","TelAvivColony","WadiHidan","Colombo",
                                                         "PigeonIsland","Trincomalee","Perth"))

# Defines parameters:

sampleid = "Sample_ID"
target = "Location"

# Ask Sama:

data_for_plot <- data.frame()

#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15),

# Ask Sama 2:

x <- list(c(16,14,7,3,2,12,6,11,19,15,8,9,17,5,4,18,13,20,10,1),
          c(9,5,14,4,19,16,15,11,3,10,6,8,12,17,2,13,18,7,1),
          c(7,2,11,15,10,16,13,3,5,4,6,14,18,12,8,1,9,17),
          c(12,9,17,7,5,11,4,14,2,15,16,10,13,8,6,3,1),
          c(16,5,9,10,2,11,15,6,13,14,12,7,1,8,3,4),
          c(8,15,13,5,1,12,4,11,2,6,7,3,14,9,10),
          c(7,2,1,3,14,8,5,12,9,10,13,6,11,4),
          c(4,6,11,9,7,8,2,13,10,1,5,3,12),
          c(1,12,8,9,2,7,6,11,5,4,10,3),
          c(11,9,1,7,2,10,5,6,4,8,3),
          c(5,9,6,4,2,1,7,3,8,10),
          c(6,9,4,2,5,8,7,3,1),
          c(7,2,5,3,1,8,4,6),
          c(6,7,4,2,3,5,1),
          c(1,3,5,2,4,6),
          c(1,3,4,5,2),
          c(2,3,1,4),
          c(2,1,3),
          c(1,2))

# Ask Sama 3:

for (j in 1:length(samples[,1])){
  data <- read.table(samples[j,1])[,x[[j]]]
  for (i in 1:dim(data)[2]) { 
    temp <- data.frame(value = data[,i])
    temp$k <- as.factor(rep(i, times = length(temp$value)))
    temp[sampleid] <- as.factor(ids[sampleid][,1])
    temp$k_value <- as.factor(rep(paste("k = ", dim(data)[2], sep = ""), times = length(temp$value)))
    temp <- merge(ids, temp)
    data_for_plot <- rbind(data_for_plot, temp)}}

# Ask Sama 4:

x_lab <- (sampleid)

# Creates ngsAmix plots:

ngsAdmix <-
ggplot(data_for_plot, aes(x = get(sampleid), y = value, fill = k)) + labs(x = x_lab) +
 geom_bar(stat = "identity", width = 0.85) +
  facet_grid(k_value ~ get(target), space = "free_x", scales = "free_x") +
  scale_x_discrete(expand = c(0, 0)) + 
  scale_y_continuous(expand = c(0, 0), breaks = NULL) +
  theme(panel.background = element_rect(fill = '#000000'),
        panel.grid.minor.x = element_blank(),
        legend.position = "none",
        panel.grid.major = element_blank(),
        panel.spacing = unit(0.2, "lines"),
        plot.title = element_blank(),
        axis.title = element_blank(),
        axis.text.x = element_text(colour = "#000000", size = 6, angle = 90, vjust = 0.5, hjust = 1),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        strip.background = element_rect(colour = "#000000", fill = '#FAFAFA', size = 0.05),
        strip.text.x = element_text(colour = "#000000", face = "bold", size = 7, angle = 270, margin = margin(0.1, 0, 0.1, 0, "cm")),
        strip.text.y = element_text(colour = "#000000", face = "bold", size = 7, angle = 270, margin = margin(0, 0.1, 0, 0.1, "cm")))

ngsAdmix_G <- ggplotGrob(ngsAdmix)

ngsAdmix_G <- gtable_add_rows(ngsAdmix_G, unit(1, "cm"), pos = 5)

# Adds top strips:

ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#df65b0", size = .75, lwd = 0.25)), textGrob("America", gp = gpar(cex = .75, fontface = 'bold', col = "black"))), t = 6, l = 4, b = 6, r = 23, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#045a8d", size = .75, lwd = 0.25)), textGrob("Europe",gp = gpar(cex = .75, fontface = 'bold', col = "black"))), t = 6, l = 25, b = 6, r = 49, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#d0d1e6", size = .5, lwd = 0.25)), textGrob("Africa",gp = gpar(cex = .75, fontface = 'bold', col = "black"))), t = 6, l = 51, b = 6, r = 53, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#a6bddb", size = .5, lwd = 0.25)), textGrob("Middle East",gp = gpar(cex = .75, fontface = 'bold', col = "black"))), t = 6, l = 55, b = 6, r = 69, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#2b8cbe", size = .5, lwd = 0.25)), textGrob("South Asia",gp = gpar(cex = .75, fontface = 'bold', col = "black"))), t = 6, l = 71, b = 6, r = 75, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#c51b8a", size = .5, lwd = 0.25)), textGrob("Oceania",gp = gpar(cex = .75, fontface = 'bold', col = "black"))), t = 6, l = 77, b = 6, r = 77, name = c("a", "b"))

ngsAdmix_G <- gtable_add_rows(ngsAdmix_G, unit(2/10, "line"), 6)

# Creates & Saves the final Map Panel:

grid.newpage()
grid.draw(ngsAdmix_G)
ggsave(ngsAdmix_G, file = "FPGP--ngsAdmix.pdf", device = cairo_pdf, width = 40, height = 15, dpi = 1000)

#
##
### The END ~~~~