### The BEGINNING ~~~~~
##
# ~ Creates FPGP--CoverageHeatMap | By George Pacheco.


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(pheatmap, tidyverse, ggrepel, extrafont, cowplot, grid)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads data ~
KMs <- read.table("FPG--Loci_Merged.coverage.km.tsv", sep = "\t", row.names = 1, header = TRUE, check.names = FALSE)
Weights <- na.omit(as.matrix(read.table("FPG--Loci_Merged.coverage.km_weights.txt", sep = ","))[1, ])


# Loads data ~
KMs_Weighted <- KMs * Weights
Dist_Weighted <- dist(t(KMs_Weighted), method = "manhattan")


# Gets number of rows and columns ~
NC <- ncol(KMs)
NR <- nrow(KMs)

# Defines QC ~ 
QC <- data.frame(matrix(ncol = 1, nrow = 488, dimnames = list(NULL, c("SampleStatus"))))
rownames(QC) <- colnames(KMs)
QC$SampleStatus <- ifelse(rownames(QC) %in% c("FPGP_1-Blank-GBS", "FPGP_2-Blank-GBS", "FPGP_3-Blank-GBS", "FPGP_4-Blank-GBS",
                                                        "FPGP_5-Blank-GBS", "FPGP_Extra-Blank-GBS", "Sumba_02-GBS", "Nolsoy_02-GBS",
                                                        "Salvador_08-GBS", "Sumba_03-GBS", "Nolsoy_01-GBS", "Nolsoy_04-GBS", "London_13-GBS",
                                                        "Salvador_12-GBS", "Berlin_16-GBS", "Salvador_11-GBS"), "BadSample", "GoodSample")

# Defines QC colours ~
colours = list(SampleStatus = c(BadSample = "#bf00ff", GoodSample = "#00a387"))

# Creates the plot ~
pheatmap(KMs,
         border_color = "black", annotation = QC, annotation_colors = colours, annotation_legend = TRUE,
         clustering_distance_cols = Dist_Weighted, clustering_distance_rows = "manhattan",
         cellwidth = 10, cellheight = 10,
         cutree_rows = max(5, floor(NR * 20/1000)), cutree_cols = max(5, floor(NC * 20/1000)),
         treeheight_row = max(10, floor(NR * .5)), treeheight_col=max(10,floor(NC * .5)),
         filename = "FPG--CoverageHeatMap.jpg")


#
##
### The END ~~~~~