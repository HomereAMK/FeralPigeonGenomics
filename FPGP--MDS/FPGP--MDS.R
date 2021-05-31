setwd("/Users/hintze/Desktop/PhD\ Action\ Plan/Core\ Projects/Finishing/FPGP--FINAL/Analyses/FPGP--MDS/")

library(optparse)
library(ggplot2)
library(plyr)
library(RColorBrewer)

option_list <- list(make_option(c('-i','--in_file'), action='store', type='character', default="stdin", help='Input file'),
                    make_option(c('--no_header'), action='store_true', type='logical', default=FALSE, help='Input file has no header'),
                    make_option(c('--var_excl'), action='store', type='character', default=NULL, help='Variables to exclude from analysis'),
                    make_option(c('-a','--annot'), action='store', type='character', default=NULL, help='File with indiv annotations'),
                    make_option(c('--id_column'), action='store', type='numeric', default=1, help='Column to use as ID'),
                    make_option(c('-L','--in_maj_labels'), action='store', type='character', default=NULL, help='Column from annotation file to use as MAJOR label'),
                    make_option(c('-l','--in_min_labels'), action='store', type='character', default=NULL, help='Column from annotation file to use as MINOR label'),
                    make_option(c('-c','--in_colors'), action='store', type='character', default=NULL, help='Column from input file to use as individual colors'),
                    make_option(c('-s','--plot_size'), action='store', type='numeric', default=1, help='Plot size'),
                    make_option(c('-t','--plot_title'), action='store', type='character', default=NULL, help='Plot title'),
                    make_option(c('-x', '--plot_x_limits'), action='store', type='character', default=NULL, help='Comma-sepparated values for plot X-axis limits (eg: "-1,1")'),
                    make_option(c('-y', '--plot_y_limits'), action='store', type='character', default=NULL, help='Comma-sepparated values for plot Y-axis limits (eg: "-1,1")'),
                    make_option(c('-o','--out_file'), action='store', type='character', default=NULL, help='Output file'),
                    make_option(c('--debug'), action='store_true', type='logical', default=FALSE, help='Debug mode')
)
opt <- parse_args(OptionParser(option_list = option_list))
opt$in_file="FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.mds"
opt$annot="FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra.annot"
opt$id_column=1
opt$in_maj_labels="Location"
opt$out_file="FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra_Location.pdf"

# Print parameters
cat('# Input file:', opt$in_file, fill=TRUE)
cat('# Input file has header:', !opt$no_header, fill=TRUE)
cat('# Excluded variables:', opt$var_excl, fill=TRUE)
cat('# Annotations file:', opt$annot, fill=TRUE)
cat('# ID column:', opt$id_column, fill=TRUE)
cat('# Major label variable:', opt$in_maj_labels, fill=TRUE)
cat('# Minor label variable:', opt$in_min_labels, fill=TRUE)
cat('# Individual colors:', opt$in_colors, fill=TRUE)
cat('# Plot size:', opt$plot_size, fill=TRUE)
cat('# Plot title:', opt$plot_title, fill=TRUE)
cat('# Plot X-axis limits:', opt$plot_x_limits, fill=TRUE)
cat('# Plot Y-axis limits:', opt$plot_y_limits, fill=TRUE)
cat('# Out file:', opt$out_file, fill=TRUE)
cat('# Debug mode?:', opt$debug, fill=TRUE)

### Check plot X-axis limits
if(!is.null(opt$plot_x_limits))
  opt$plot_x_limits <- as.numeric( gsub("\\(|\\)|\"", "", strsplit(opt$plot_x_limits, ",", fixed=TRUE)[[1]]) )

### Check plot Y-axis limits
if(!is.null(opt$plot_y_limits))
  opt$plot_y_limits <- as.numeric( gsub("\\(|\\)|\"", "", strsplit(opt$plot_y_limits, ",", fixed=TRUE)[[1]]) )

### Read data
cat("# \tReading input file...", fill=TRUE)
data <- read.table(opt$in_file, row.names=1, sep="\t", header=!opt$no_header, stringsAsFactors=FALSE, check.names=FALSE)
n <- ncol(data)
if(opt$debug)
  print(data)

# Read annotation file
if(!is.null(opt$annot)){
  cat("# \tReading annotations file...", fill=TRUE)
  annot <- read.table(opt$annot, sep="\t", header=TRUE, stringsAsFactors=FALSE)
  if(opt$debug)
    print(annot)
  data <- merge(data, annot, by.x=0, by.y=opt$id_column)
  # Get rownames back into place
  rownames(data) <- data[,1]; data <- data[,-1]
  data[colnames(annot)[opt$id_column]] <- rownames(data)
}

# Exclude variables
if( !is.null(opt$var_excl) ) {
  cat("# \tExcluding variables...", fill=TRUE)
  opt$var_excl <- unlist(strsplit(opt$var_excl, ","))
  data <- data[!(rownames(data) %in% opt$var_excl),]
}

# Set plot title
if(is.null(opt$plot_title))
  opt$plot_title <- basename(opt$in_file)

# Get Major labels mean location
colors <- NULL
if(!is.null(opt$in_maj_labels)){
  cat("# Calculating Major labels...", fill=TRUE)
  # Merge Major labels
  in_maj_labels <- unlist(strsplit(opt$in_maj_labels, ",", fixed=TRUE))
  tmp_data <- data[,in_maj_labels[1]]
  data[in_maj_labels[1]] <- NULL
  if(length(in_maj_labels) > 1){
    for (cnt in 2:length(in_maj_labels)){
      tmp_data <- paste(tmp_data, data[,in_maj_labels[cnt]], sep="/")
      data[in_maj_labels[cnt]] <- NULL
    }
    opt$in_maj_labels <- "MERGE"
  }
  
  # Make sure Major label column is after data
  data <- data.frame(data, tmp_data)
  colnames(data)[ncol(data)] <- opt$in_maj_labels
  # Convert to factor, in case there is a Major label with just numbers
  data[,opt$in_maj_labels] <- factor(data[,opt$in_maj_labels])
  # If label was in input file, decrease number of data columns
  if(is.null(opt$annot) || !opt$in_maj_labels %in% colnames(annot))
    n = n - 1
  # Get mean value for Major label
  data_mean <- ddply(data, opt$in_maj_labels, function(x){colMeans(x[, 1:n], na.rm=TRUE)})
  colors <- as.character(opt$in_maj_labels)
}
# If color variable provided, override previous definitions
if (!is.null(opt$in_colors))
  colors <- as.character(opt$in_colors)

### Plot

pdf(opt$out_file, width=opt$plot_size*8, height=opt$plot_size*6)
for(i in 1:(n-1)){
  for(j in (i+1):n){
    plot <- ggplot(data, aes_string(x=colnames(data)[i], y=colnames(data)[j], colour=colors))
    #plot <- ggplot(data[-which(data$NPA_Group %in% c("Non NPA Breed","Feral")),], aes_string(x=colnames(data)[i], y=colnames(data)[j], colour=colors))
    #stat_ellipse(type = "norm", linetype = 2)
    #plot <- ggplot(aes(text=paste("Sample: ", opt$annot)))
    plot <- plot + 
      labs(x = "Dimension 1", y = "Dimension 2", color = "NPA's Groups") +
      theme_bw() +
      #geom_hline(aes(yintercept=0), colour="black", size=0.2) + 
      #geom_vline(aes(xintercept=0), colour="black", size=0.2) +
      theme(axis.title=element_text(size=10, face="bold")) +
      theme(legend.title=element_text(size=10, face="bold")) +
      theme(legend.text=element_text(size=8)) +
      theme(panel.background = element_rect(fill = '#F3F3F3')) +
      theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank(),
            plot.title=element_text(size=10)) +
      theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
      theme(panel.border = element_blank()) +
      guides(colour=guide_legend(override.aes=list(alpha=1, size=3), ncol=1)) +
      coord_cartesian(xlim=opt$plot_x_limits, ylim=opt$plot_y_limits) +
      #theme(legend.background = element_rect(fill="#F3F3F3")) +
      theme(axis.text.x = element_text(color="#000000", size=7),
            axis.text.y = element_text(color="#000000", size=7)) +
      theme(axis.ticks.x = element_line(color="#000000", size=0.3), axis.ticks.y = element_line(color="#000000", size=0.3))
      
    # Colors
    #    if(!is.null(opt$in_colors)){
    #      plot <- plot + scale_colour_manual(values=data[,colors])
    #    }else{
    if(nrow(data) < 8){
      plot <- plot + scale_colour_brewer(palette="Set1")
    }else{
      plot <- plot + scale_colour_discrete()
    }
    #    }
    
    # Minor labels
    if(is.null(opt$in_min_labels)){
      plot <- plot + geom_point(alpha=0.7, size=1) +
        theme(legend.position="right", 
              legend.key = element_rect(fill=NA),
              legend.title=element_blank())
           }else{
      plot <- plot + geom_text(aes_string(label=opt$in_min_labels), alpha=0.1, size=1.5)
    }
    
    # Major labels
    if(!is.null(opt$in_maj_labels))
      if(!is.null(opt$in_colors)){
        #plot <- plot + geom_text(data=data_mean, aes_string(label=opt$in_maj_labels), size=3, colour="black", show.legend=FALSE)
      }else{
        #plot <- plot + geom_text(data=data_mean, aes_string(label=opt$in_maj_labels, color=colors), size=3, show.legend=FALSE)
      }
    print(plot)
  }
}

x <- dev.off()

#######################################

data$Location <- factor(data$Location, ordered=T, levels=c("America", "SaltLakeCity", "Denver", "Virginia", "Monterrey", "MexicoCity", "TlaxcalaDeXicohtencatl", "SanCristobalDeLasCasas", "Santiago", "Salvador", "Tatui","",
                                                           "Europe","FaroeIslands", "Copenhagen", "Cambridge","London","Berlin","Prague", "Jihlava","Vernelle","Barcelona","Guimaraes","Lisbon","Sardinia","Crete", " ",
                                                           "Africa","Nairobi","Johannesburg","  ",
                                                           "Asia","Lahijan","Nowshahr","Tehran","Isfahan","Abadeh", "TelAviv","TelAvivColony","WadiHidan","Colombo", "PigeonIsland","Trincomalee", "   ",
                                                           "Oceania","Perth"))

data$Location

ggplot(data, aes_string(x="D1_3.25448642972517", y="D3_1.49711709599922", colour="Location")) + geom_point(alpha = 1, size = 2.2, shape = data$Shape) +
  
  scale_fill_manual(values=c("#F3F3F3", "#1b9e77", "#d95f02", "#7570b3", "#1b9e77", "#ff7f00", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#F3F3F3", "#F3F3F3",
                             "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#F3F3F3","#F3F3F3",
                             "#1b9e77", "#a6761d", "#F3F3F3","#F3F3F3", "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "##ff7f00", "#e7298a", "#66a61e", "#e6ab02",
                             "#F3F3F3","#F3F3F3", "#7570b3"), drop=FALSE) +
  scale_colour_manual(values=c("#F3F3F3", "#1b9e77", "#d95f02", "#7570b3", "#1b9e77", "#ff7f00", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#F3F3F3", "#F3F3F3",
                               "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#F3F3F3","#F3F3F3",
                               "#1b9e77", "#a6761d", "#F3F3F3","#F3F3F3", "#1b9e77", "#d95f02", "#7570b3", "#e7298a", "#66a61e", "#e6ab02", "#a6761d", "#ff7f00", "#e7298a", "#66a61e", "#e6ab02",
                               "#F3F3F3","#F3F3F3", "#7570b3"), drop=FALSE) +
  
  scale_x_continuous("Dimension 1 (3.25%)",
                     breaks = c(-0.050, -0.025, 0, 0.025, 0.050),
                     labels = c("-0.050", "-0.025", "0", "0.025", "0.050"),
                     expand = c(0,0),
                     limits = c(-0.077, 0.052)) +
  scale_y_continuous("Dimension 3 (1.50%)",
                     breaks = c(-0.050, -0.025, 0, 0.025, 0.050), 
                     expand = c(0,0),
                     labels = c("-0.050", "-0.025", "0", "0.025", "0.050"), 
                     limits = c(-0.077, 0.052)) +
  theme(legend.key = element_blank()) +
  theme(legend.title=element_blank()) +
  theme(axis.title=element_text(size=13, face="bold")) +
  theme(legend.text=element_text(size=11)) +
  theme(legend.position=c(.935, 0.5)) +
  theme(panel.background = element_rect(fill = '#FAFAFA')) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank()) +
  guides(colour=guide_legend(override.aes=list(alpha=1, size=3, shape = c(NA, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, NA, NA, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, NA, NA, 2, 2, NA, NA,
        0, 0, 0, 0, 0, 0, 0, 0, 12, 12, 12, NA, NA, 14)), ncol=1)) +
  coord_cartesian(xlim=opt$plot_x_limits, ylim=opt$plot_y_limits) +
  theme(legend.background = element_rect(fill="#FAFAFA", colour = "#000000", size = 0.3)) +
  theme(axis.text.x = element_text(color="#000000", size=11),
        # angle=270, vjust=0.5, hjust=1
        axis.text.y = element_text(color="#000000", size=11)) +
  theme(axis.ticks.x = element_line(color="#000000", size=0.3), axis.ticks.y = element_line(color="#000000", size=0.3))

ggsave("FPGP--GoodSamples_NoSrisoriaNoCpalumbusNoCrupestrisNoDuplicatesNoCaptives--Article--Ultra_MDS_1-3.eps", height=15, width=18, scale=1, dpi = 1000)