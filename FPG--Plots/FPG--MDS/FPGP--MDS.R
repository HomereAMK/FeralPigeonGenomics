### The BEGINNING ~~~~
##
# > Plots FPGP--MDS | By George PACHECO


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(optparse, tidyverse, plyr, RColorBrewer, extrafont, ggforce)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads list of options ~
option_list <- list(make_option(c('-i','--in_file'), action = 'store', type = 'character', default = "stdin", help = 'Input file'),
                    make_option(c('-a','--annot'), action = 'store', type = 'character', default = NULL, help = 'File with indiv annotations'),
                    make_option(c('--id_column'), action = 'store', type = 'numeric', default = 1, help = 'Column to use as ID'),
                    make_option(c('-L','--in_maj_labels'), action = 'store', type = 'character', default = NULL, help = 'Column from annotation file to use as MAJOR label'),
                    make_option(c('-l','--in_min_labels'), action = 'store', type = 'character', default = NULL, help = 'Column from annotation file to use as MINOR label'),
                    make_option(c('--no_header'), action = 'store_true', type = 'logical', default = FALSE, help = 'Input file has no header'),
                    make_option(c('--var_excl'), action = 'store', type = 'character', default = NULL, help = 'Variables to exclude from analysis'))

  
# Defines parameters ~
opt <- parse_args(OptionParser(option_list = option_list))
opt$in_file = "FPG_MDS.mds"
opt$annot = "FPG_MDS.annot"
opt$id_column = 1
opt$in_maj_labels = "Population"


# Reads data ~
data <- read.table(opt$in_file, row.names = 1, sep = "\t", header = !opt$no_header, stringsAsFactors = FALSE, check.names = FALSE)
n <- ncol(data)


# Reads annotation file ~
if(!is.null(opt$annot)){
annot <- read.table(opt$annot, sep = "\t", header = TRUE, stringsAsFactors=FALSE)
colnames(annot) <- c("Sample_ID", "Population")
data <- merge(data, annot, by.x = 0, by.y = opt$id_column)


# Gets rownames back into place ~
rownames(data) <- data[,1]; data <- data[,-1]
data[colnames(annot)[opt$id_column]] <- rownames(data)}


# Excludes variables ~
if( !is.null(opt$var_excl)){
opt$var_excl <- unlist(strsplit(opt$var_excl, ","))
data <- data[!(rownames(data) %in% opt$var_excl),]}


# Gets Major labels mean location ~
colors <- NULL
if(!is.null(opt$in_maj_labels)){


# Merge Major labels ~
in_maj_labels <- unlist(strsplit(opt$in_maj_labels, ",", fixed = TRUE))
tmp_data <- data[,in_maj_labels[1]]
data[in_maj_labels[1]] <- NULL
if(length(in_maj_labels) > 1){
   for (cnt in 2:length(in_maj_labels)){
    tmp_data <- paste(tmp_data, data[,in_maj_labels[cnt]], sep="/")
    data[in_maj_labels[cnt]] <- NULL}
    opt$in_maj_labels <- "MERGE"}


# Make sure Major label column is after data ~
data <- data.frame(data, tmp_data)
colnames(data)[ncol(data)] <- opt$in_maj_labels


# Converts to factor, in case there is a Major label with just numbers~
data[,opt$in_maj_labels] <- factor(data[,opt$in_maj_labels])


# If label was in input file, decreases number of data columns ~
if(is.null(opt$annot) || !opt$in_maj_labels %in% colnames(annot))
n = n - 1


# Gets mean value for Major label ~
data_mean <- ddply(data, opt$in_maj_labels, function(x){colMeans(x[, 1:n], na.rm = TRUE)})
colors <- as.character(opt$in_maj_labels)}


# Expands the data by adding BioStatus ~
data$BioStatus <- ifelse(data$Population %in% c("Torshavn","Ejde","Sumba","LjosAir","Kunoy","Nolsoy", "Crete", "Sardinia","Vernelle","WadiHidan","PigeonIsland","Trincomalee"), "Remote_Localities_Within_Natural_Range",
                  ifelse(data$Population %in% c("Guimaraes","Lisbon","Barcelona","Berlin","Cambridge",
                                               "Colombo","Copenhagen","London","Prague","Jihlava","Abadeh",
                                               "Isfahan","Lahijan","Nowshahr","Tehran","TelAviv"), "Urban_Localities_Within_Natural_Range",
                  ifelse(data$Population %in% c("SaltLakeCity","Denver", "FeralVA", "FeralUT", "TlaxcalaDeXicohtencatl",
                                               "MexicoCity","Monterrey","SanCristobalDeLasCasas","Santiago",
                                               "Salvador","Tatui","Johannesburg","Nairobi","Perth"), "Localities_Outside_Natural_Range",
                  ifelse(data$Population %in% c("TelAvivColony","Wattala", "Wellawatte"), "Captive_Populations", NA))))


# Expands the data by adding Groups ~
data$Groups <- # Remote Localities Within Natural Range
                 ifelse(data$Population %in% c("PigeonIsland", "Trincomalee"), "Group A",
                 ifelse(data$Population %in% c("Abadeh", "Tehran", "Crete", "Sardinia", "Vernelle", "Torshavn", "Ejde", "Sumba", "LjosAir", "Kunoy", "Nolsoy"), "Group B",
                 ifelse(data$Population %in% c("TelAviv", "TelAvivColony", "WadiHidan"), "Group C",
                 ifelse(data$Population %in% c("Nairobi", "Colombo", "Lahijan", "Nowshahr", "Wellawatte", "Isfahan"), "Group D",
                 ifelse(data$Population %in% c("Guimaraes", "Barcelona", "Lisbon", "Salvador", "Tatui","Denver" , "Santiago", "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas"), "Group E",
                 ifelse(data$Population %in% c("Jihlava", "Prague", "Berlin", "SaltLakeCity", "Johannesburg", "London", "Cambridge", "Perth", "Copenhagen"), "Group F", "Not Grouped"))))))
                                                                          

# Creates alternative Population column ~
data$Population_cbind <- data$Population


# Combines all populations from the Faroe Islands ~
levels(data$Population_cbind <- sub("Torshavn", "FaroeIslands", data$Population_cbind))
levels(data$Population_cbind <- sub("Ejde", "FaroeIslands", data$Population_cbind))
levels(data$Population_cbind <- sub("Sumba", "FaroeIslands", data$Population_cbind))
levels(data$Population_cbind <- sub("LjosAir", "FaroeIslands", data$Population_cbind))
levels(data$Population_cbind <- sub("Kunoy", "FaroeIslands", data$Population_cbind))
levels(data$Population_cbind <- sub("Nolsoy", "FaroeIslands", data$Population_cbind))
                          
                          
## Reorders BioStatus ~
data$BioStatus <- factor(data$BioStatus, ordered = T,
                           levels = c("Remote_Localities_Within_Natural_Range",
                                      "Urban_Localities_Within_Natural_Range",
                                      "Localities_Outside_Natural_Range",
                                      "Captive_Populations"))


# Defines the shapes to be used for each Group ~
Shapes <- as.vector(c(# Group A
                      8, 
                      # Group B
                      21,
                      # Group C
                      22,
                      # Group D
                      23,
                      # Group E
                      24,
                      # Group F
                      25,
                      # Not Grouped
                      9))


# Creates the subset Colour_Pops ~
Colour_Pops <- data %>%
 filter(Population == "PigeonIsland" | Population == "Trincomalee" | Population == "Wattala")


# Creates the subset Fill_Pops ~
PopsOut <- c("PigeonIsland", "Trincomalee", "Wattala")
Fill_Pops <- filter(data, !Population %in% PopsOut)


# Creates MDS plots ~
MDS_12 <-
ggplot(data, aes_string(x = "D1_3.22314862567792", y = "D2_1.95080884235087")) +
  geom_point(data = Fill_Pops, aes(fill = BioStatus, shape = Groups), size = 2.8, alpha = .9, stroke = .3) +
  geom_point(data = Colour_Pops, aes(colour = BioStatus, shape = Groups ), size = 2.8, alpha = .9, stroke = .3) +
  scale_colour_manual(values = c("#44AA99", "#d01c8b"), labels = gsub("_", " ", levels(data$BioStatus))) +
  scale_fill_manual(values = c("#44AA99", "#F0E442", "#E69F00", "#d01c8b"), labels = gsub("_", " ", levels(data$BioStatus))) +
  geom_mark_ellipse(aes(color = BioStatus, group = Population_cbind, filter = Population_cbind == "FaroeIslands", label = "Faroe Islands"),
                    label.buffer = unit(8, 'mm'), con.colour = "black", con.type = "straight", label.fill = NA, show.legend = FALSE) +
  geom_mark_ellipse(aes(color = BioStatus, group = Population, filter = Population == "PigeonIsland", label = "Pigeon Island"),
                    label.buffer = unit(35, 'mm'), con.colour = "black", con.type = "straight", label.fill = NA, show.legend = FALSE) +
  geom_mark_ellipse(aes(color = BioStatus, group = Population, filter = Population == "Trincomalee", label = "Trincomalee"),
                    label.buffer = unit(16, 'mm'), con.colour = "black", con.type = "straight", label.fill = NA, show.legend = FALSE) +
  scale_shape_manual(values = Shapes) +
  scale_x_continuous("Dimension 1 (3.22%)",
                     breaks = c(-0.075, -0.050, -0.025, 0, 0.025),
                     labels = c("-0.075", "-0.050", "-0.025", "0", "0.025"),
                     expand = c(0,0),
                     limits = c(-0.077, 0.03)) +
  scale_y_continuous("Dimension 2 (1.95%)",
                     breaks = c(-0.050, -0.025, 0, 0.025, 0.050), 
                     expand = c(0,0),
                     labels = c("-0.050", "-0.025", "0", "0.025", "0.050"), 
                     limits = c(-0.060, 0.052)) +
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
  guides(fill = guide_legend(title = "Biological Status", title.theme = element_text(size = 16, face = "bold", family = "Helvetica"),
                               label.theme = element_text(size = 14, family = "Helvetica"),
                               override.aes = list(size = 4.5, shape = 21, alpha = .9), order = 1),
         shape = guide_legend(title = "Groups", title.theme = element_text(size = 16, face = "bold", family = "Helvetica"),
                              label.theme = element_text(size = 14, family = "Helvetica"),
                              override.aes = list(size = 4.5, alpha = .9), order = 2), colour = "none")


# Creates & Saves the final MDS Panel ~
ggsave(MDS_12, file = "FPG--MDS_12.pdf", device = cairo_pdf, scale = 1.5, width = 12, height = 8, dpi = 600)



#
##
### The END ~~~~








# Reorganises the data:
data$Population <- factor(data$Population, ordered = T, levels = c("Torshavn", "Ejde", "Sumba", "LjosAir", "Kunoy", "Nolsoy", "Crete", "Sardinia", "Vernelle", "WadiHidan",
                                                                   "PigeonIsland","Trincomalee", "Guimaraes", "Lisbon", "Barcelona", "Berlin", "Cambridge", "Colombo",
                                                                   "Copenhagen", "London", "Prague", "Jihlava", "Abadeh", "Isfahan", "Lahijan", "Nowshahr", "Tehran",
                                                                   "TelAviv", "SaltLakeCity","Denver", "FeralVA", "FeralUT", "TlaxcalaDeXicohtencatl", "MexicoCity",
                                                                   "Monterrey", "SanCristobalDeLasCasas", "Santiago", "Salvador", "Tatui", "Johannesburg", "Nairobi", "Perth",
                                                                   "TelAvivColony","Wattala", "Wellawatte"))


# Expands the data by adding Shape ~
data$Locality <- # Remote Localities Within Natural Range
  ifelse(data$Population %in% c("Torshavn"), 0,
  ifelse(data$Population %in% c("Ejde"), 1,
  ifelse(data$Population %in% c("Sumba"), 2,
  ifelse(data$Population %in% c("LjosAir"), 3,
  ifelse(data$Population %in% c("Kunoy"), 4,
  ifelse(data$Population %in% c("Nolsoy"), 5,
  ifelse(data$Population %in% c("Crete"), 6,
  ifelse(data$Population %in% c("Sardinia"), 7,
  ifelse(data$Population %in% c("Vernelle"), 8,
  ifelse(data$Population %in% c("WadiHidan"), 9,
  ifelse(data$Population %in% c("PigeonIsland"), 10,
  ifelse(data$Population %in% c("Trincomalee"), 11,
          
  # Urban Localities Within Natural Range
  ifelse(data$Population %in% c("Guimaraes"), 0,
  ifelse(data$Population %in% c("Lisbon"), 1,
  ifelse(data$Population %in% c("Barcelona"), 2,
                                                                                                           ifelse(data$Population %in% c("Berlin"), 3,
                                                                                                                  ifelse(data$Population %in% c("Cambridge"), 4,
                                                                                                                         ifelse(data$Population %in% c("Colombo"), 5,
                                                                                                                                ifelse(data$Population %in% c("Copenhagen"), 6,
                                                                                                                                       ifelse(data$Population %in% c("London"), 7,
                                                                                                                                              ifelse(data$Population %in% c("Prague"), 8,
                                                                                                                                                     ifelse(data$Population %in% c("Jihlava"), 9,
                                                                                                                                                            ifelse(data$Population %in% c("Abadeh"), 10,
                                                                                                                                                                   ifelse(data$Population %in% c("Isfahan"), 11,
                                                                                                                                                                          ifelse(data$Population %in% c("Lahijan"), 12,
                                                                                                                                                                                 ifelse(data$Population %in% c("Nowshahr"), 13,
                                                                                                                                                                                        ifelse(data$Population %in% c("Tehran"), 14,
                                                                                                                                                                                               ifelse(data$Population %in% c("TelAviv"), 15,
                                                                                                                                                                                                      
                                                                                                                                                                                                      # Localities Outside Natural Range
                                                                                                                                                                                                      ifelse(data$Population %in% c("SaltLakeCity"), 0,
                                                                                                                                                                                                             ifelse(data$Population %in% c("Denver"), 1,
                                                                                                                                                                                                                    ifelse(data$Population %in% c("FeralVA"), 2,
                                                                                                                                                                                                                           ifelse(data$Population %in% c("FeralUT"), 3,
                                                                                                                                                                                                                                  ifelse(data$Population %in% c("MexicoCity"), 4,
                                                                                                                                                                                                                                         ifelse(data$Population %in% c("Monterrey"), 5,
                                                                                                                                                                                                                                                ifelse(data$Population %in% c("SanCristobalDeLasCasas"), 6,
                                                                                                                                                                                                                                                       ifelse(data$Population %in% c("TlaxcalaDeXicohtencatl"), 7,
                                                                                                                                                                                                                                                              ifelse(data$Population %in% c("Santiago"), 8,
                                                                                                                                                                                                                                                                     ifelse(data$Population %in% c("Salvador"), 9,
                                                                                                                                                                                                                                                                            ifelse(data$Population %in% c("Tatui"), 10,
                                                                                                                                                                                                                                                                                   ifelse(data$Population %in% c("Johannesburg"), 11,
                                                                                                                                                                                                                                                                                          ifelse(data$Population %in% c("Nairobi"), 12,  
                                                                                                                                                                                                                                                                                                 ifelse(data$Population %in% c("Perth"), 13,
                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                        # Captive Populations
                                                                                                                                                                                                                                                                                                        ifelse(data$Population %in% c("TelAvivColony"), 0,
                                                                                                                                                                                                                                                                                                               ifelse(data$Population %in% c("Wellawatte"), 1,
                                                                                                                                                                                                                                                                                                                      ifelse(data$Population %in% c("Wattala"), 2, NA)))))))))))))))))))))))))))))))))))))))))))))






Shapes <- as.vector(c(# Remote Localities Within Natural Range
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
  # Urban Localities Within Natural Range
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
  # Localities Outside Natural Range
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
  # Captive Populations
  0, 1, 2))

TEST <- as.vector(c(# Remote Localities Within Natural Range
  "\u25A0", "\u25A1", "\u25A2", "\u25A3", "\u25A4", "\u25A5", "\u25A6", "\u25B0", "\u25B1", "\u25B2", "\u25B3",
  # Urban Localities Within Natural Range
  "\u25B4", "\u25B5", "\u25C6", "\u25C0", "\u25C1", "\u25C2", "\u25C3", "\u25C4", "\u25C5", "\u25C6", "\u25D0", "\u25D1", "\u25D2", "\u25D3", "\u25D4", "\u25D5",
  # Localities Outside Natural Range
  "\u25D6", "\u25E0", "\u25E1", "\u25E2", "\u25E3", "\u25E4", "\u25E5", "\u25E6", "\u25F0", "\u25F1", "\u25F2", "\u25F3", "\u25F4", "\u25F5", "\u25F6",
  # Captive Populations
  "\u25F6", "\u25F7", "\u25F8"))





MDS_12 <-
  ggplot(data, aes_string(x = "D1_3.22314862567792", y = "D2_1.95080884235087")) +
  geom_point(aes(shape = Population, color = BioStatus), alpha = 1, size = 2.2) +
  scale_colour_manual(values = c("#44AA99", "#F0E442", "#E69F00", "#56B4E9"), labels = gsub("_", " ", levels(data$BioStatus))) +
  scale_shape_manual(values = Shapes) +
  geom_mark_ellipse(aes(color = BioStatus, group = Population, filter = Population == "PigeonIsland", label = "Pigeon Island"),
                    con.colour = "#44AA99", label.fontface = "bold", label.buffer = unit(20, 'mm'), con.type = "straight", con.cap = 0, label.fill = NA, show.legend = FALSE) +
  geom_mark_ellipse(aes(color = BioStatus, group = Population, filter = Population == "Trincomalee", label = "Trincomalee"),
                    con.colour = "#44AA99", label.fontface = c("bold", "bold"), position = "identity", label.buffer = unit(30, 'mm'), con.type = "straight", con.cap = 0, label.fill = NA, show.legend = FALSE) +
  scale_x_continuous("Dimension 1 (3.22%)",
                     breaks = c(-0.050, -0.025, 0, 0.025, 0.050),
                     labels = c("-0.050", "-0.025", "0", "0.025", "0.050"),
                     expand = c(0,0),
                     limits = c(-0.077, 0.052)) +
  scale_y_continuous("Dimension 2 (1.95%)",
                     breaks = c(-0.050, -0.025, 0, 0.025, 0.050), 
                     expand = c(0,0),
                     labels = c("-0.050", "-0.025", "0", "0.025", "0.050"), 
                     limits = c(-0.077, 0.052)) +
  theme(panel.background = element_rect(fill = '#FAFAFA'),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        plot.margin = unit(c(0, 0, 0, 0), "cm"),
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
  guides(colour = guide_legend(title = "Biological Status", order = 1, title.theme = element_text(size = 13, face = "bold", family = "Helvetica"),
                               label.theme = element_text(size = 12, family = "Helvetica"),
                               override.aes = list(size = 3, alpha = .9), ncol = 1),
         shape = guide_legend(title = "Locality", order = 2, title.theme = element_text(size = 13, face = "bold", family = "Helvetica"),
                              label.theme = element_text(size = 12, family = "Helvetica"),
                              override.aes = list(size = 3, alpha = .9), ncol = 2))