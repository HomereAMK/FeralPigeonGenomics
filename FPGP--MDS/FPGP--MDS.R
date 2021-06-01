### The BEGINNING ~~~~
##
# > Plots FPGP--MDS | By George PACHECO


# Sets working directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages:

pacman::p_load(optparse, ggplot2, plyr, RColorBrewer, extrafont)

# Imports extra fonts:

loadfonts(device = "win", quiet = TRUE)

# Loads list of options:

option_list <- list(make_option(c('-i','--in_file'), action = 'store', type = 'character', default = "stdin", help = 'Input file'),
                    make_option(c('-a','--annot'), action = 'store', type = 'character', default = NULL, help = 'File with indiv annotations'),
                    make_option(c('--id_column'), action = 'store', type = 'numeric', default = 1, help = 'Column to use as ID'),
                    make_option(c('-L','--in_maj_labels'), action = 'store', type = 'character', default = NULL, help = 'Column from annotation file to use as MAJOR label'),
                    make_option(c('-l','--in_min_labels'), action = 'store', type = 'character', default = NULL, help = 'Column from annotation file to use as MINOR label'),
                    make_option(c('--no_header'), action = 'store_true', type = 'logical', default = FALSE, help = 'Input file has no header'),
                    make_option(c('--var_excl'), action = 'store', type = 'character', default = NULL, help = 'Variables to exclude from analysis'))
                    
# Defines parameters:

opt <- parse_args(OptionParser(option_list = option_list))
opt$in_file = "FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.mds"
opt$annot = "FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.annot"
opt$id_column = 1
opt$in_maj_labels = "Location"

### Reads data

data <- read.table(opt$in_file, row.names = 1, sep = "\t", header = !opt$no_header, stringsAsFactors = FALSE, check.names = FALSE)
n <- ncol(data)

# Reads annotation file

if(!is.null(opt$annot)){
annot <- read.table(opt$annot, sep = "\t", header = TRUE, stringsAsFactors=FALSE)
data <- merge(data, annot, by.x = 0, by.y = opt$id_column)
  
# Gets rownames back into place:
  
rownames(data) <- data[,1]; data <- data[,-1]
data[colnames(annot)[opt$id_column]] <- rownames(data)}

# Excludes variables:

if( !is.null(opt$var_excl)){
opt$var_excl <- unlist(strsplit(opt$var_excl, ","))
data <- data[!(rownames(data) %in% opt$var_excl),]}

# Sets plot title

if(is.null(opt$plot_title))
opt$plot_title <- basename(opt$in_file)

# Gets Major labels mean location

colors <- NULL
if(!is.null(opt$in_maj_labels)){

# Merge Major labels
  
in_maj_labels <- unlist(strsplit(opt$in_maj_labels, ",", fixed = TRUE))
tmp_data <- data[,in_maj_labels[1]]
data[in_maj_labels[1]] <- NULL
if(length(in_maj_labels) > 1){
   for (cnt in 2:length(in_maj_labels)){
    tmp_data <- paste(tmp_data, data[,in_maj_labels[cnt]], sep="/")
    data[in_maj_labels[cnt]] <- NULL}
    opt$in_maj_labels <- "MERGE"}
  
# Make sure Major label column is after data
  
data <- data.frame(data, tmp_data)
colnames(data)[ncol(data)] <- opt$in_maj_labels
  
# Converts to factor, in case there is a Major label with just numbers
  
data[,opt$in_maj_labels] <- factor(data[,opt$in_maj_labels])
  
# If label was in input file, decreases number of data columns
  
if(is.null(opt$annot) || !opt$in_maj_labels %in% colnames(annot))
n = n - 1

# Gets mean value for Major label

data_mean <- ddply(data, opt$in_maj_labels, function(x){colMeans(x[, 1:n], na.rm = TRUE)})
colors <- as.character(opt$in_maj_labels)}

##############################################################

# Reorganises the data:

data$Location <- factor(data$Location, ordered = T, levels = c("America", "SaltLakeCity", "Denver", "Virginia", "Monterrey", "MexicoCity", "TlaxcalaDeXicohtencatl", "SanCristobalDeLasCasas", "Santiago", "Salvador", "Tatui","",
                                                           "Europe","FaroeIslands", "Copenhagen", "Cambridge","London","Berlin","Prague", "Jihlava","Vernelle","Barcelona","Guimaraes","Lisbon","Sardinia","Crete", " ",
                                                           "Africa","Nairobi","Johannesburg","  ",
                                                           "Asia","Lahijan","Nowshahr","Tehran","Isfahan","Abadeh", "TelAviv","TelAvivColony","WadiHidan","Colombo", "PigeonIsland","Trincomalee", "   ",
                                                           "Oceania","Perth"))

#MDS_12 <-
ggplot(data, aes_string(x = "D1_3.25448642972517", y = "D2_1.88108101324778", colour = "Location")) +
       geom_point(alpha = 1, size = 2.2, shape = data$Shape) +
  
  scale_fill_manual(values = c("#F3F3F3", "#1b9e77", "#d95f02", "#7570b3", "#1b9e77", "#ff7f00", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#F3F3F3", "#F3F3F3",
                             "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#F3F3F3","#F3F3F3",
                             "#1b9e77", "#a6761d", "#F3F3F3","#F3F3F3", "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "##ff7f00", "#e7298a", "#66a61e", "#e6ab02",
                             "#F3F3F3","#F3F3F3", "#7570b3"), drop = FALSE) +
  
  scale_colour_manual(values = c("#F3F3F3", "#1b9e77", "#d95f02", "#7570b3", "#1b9e77", "#ff7f00", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#F3F3F3", "#F3F3F3",
                               "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#F3F3F3","#F3F3F3",
                               "#1b9e77", "#a6761d", "#F3F3F3","#F3F3F3", "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#ff7f00", "#e7298a", "#66a61e", "#e6ab02",
                               "#F3F3F3","#F3F3F3", "#7570b3"), drop = FALSE) +
  
  scale_x_continuous("Dimension 1 (3.25%)",
                     breaks = c(-0.050, -0.025, 0, 0.025, 0.050),
                     labels = c("-0.050", "-0.025", "0", "0.025", "0.050"),
                     expand = c(0,0),
                     limits = c(-0.077, 0.052)) +
  scale_y_continuous("Dimension 2 (1.88%)",
                     breaks = c(-0.050, -0.025, 0, 0.025, 0.050), 
                     expand = c(0,0),
                     labels = c("-0.050", "-0.025", "0", "0.025", "0.050"), 
                     limits = c(-0.077, 0.052)) +
  theme(panel.background = element_rect(fill = '#FAFAFA'),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        legend.background = element_rect(fill="#FAFAFA", colour = "#000000", size = 0.3),
        legend.key = element_blank(),
        legend.position = c(.935, 0.5),
        legend.title = element_blank(),
        legend.text = element_text(size = 11),
        axis.title.x = element_text(size = 18, face = "bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 18, face = "bold", margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text = element_text(color = "#000000", size = 13),
        axis.ticks = element_line(color = "#000000", size = 0.3),
        axis.line = element_line(colour = "#000000", size = 0.3)) +
  guides(colour = guide_legend(override.aes = list(alpha = 1, size = 3,
         shape = c(NA, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, NA, NA, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, NA, NA, 2, 2, NA, NA,
        0, 0, 0, 0, 0, 0, 0, 0, 12, 12, 12, NA, NA, 14)), ncol = 1))
  
# Creates & Saves the final MDS Panel:

ggsave("FPGP--MDS_c.pdf", device = cairo_pdf, height = 15, width = 18, scale = 0.825, dpi = 1000)

#
##
### The END ~~~~