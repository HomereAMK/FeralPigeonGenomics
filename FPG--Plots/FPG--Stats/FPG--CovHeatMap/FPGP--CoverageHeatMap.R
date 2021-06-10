### The BEGINNING ~~~~
##
# Creates FPGP--CoverageHeatMap | By George PACHECO


# Sets working directory ~

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages ~

pacman::p_load(pheatmap, tidyverse, ggrepel, extrafont, cowplot)

# Imports extra fonts ~

loadfonts(device = "win", quiet = TRUE)

# Loads data ~

KMs_float16 <- read.table("FPGP--Loci_Merged.coverage_float16.km.tsv", sep = "\t", row.names = 1, header = TRUE, check.names = FALSE)
Weights_float16 <- na.omit(as.matrix(read.table("FPGP--Loci_Merged.coverage_float16.km_weights.txt", sep = ","))[1, ])

data_weighted_float16 <- KMs * Weights_float16
dist_weighted_float16 <- dist(t(data_weighted_float16), method = "manhattan")

nc_float16 <- ncol(KMs_float16)
nr_float16 <- nrow(KMs_float16)

KMs_uint8 <- read.table("FPGP--Loci_Merged.coverage_unit8.km.tsv", sep = "\t", row.names = 1, header = TRUE, check.names = FALSE)
Weights_uint8 <- na.omit(as.matrix(read.table("FPGP--Loci_Merged.coverage_unit8.km_weights.txt", sep = ","))[1, ])

data_weighted_uint8 <- KMs * Weights_uint8
dist_weighted_uint8 <- dist(t(data_weighted_uint8), method = "manhattan")

nc_uint8 <- ncol(KMs_uint8)
nr_uint8 <- nrow(KMs_uint8)

# Creates the plot:

pheatmap(KMs_float16,
         border_color="black",
         clustering_distance_cols = dist_weighted_float16, clustering_distance_rows = "manhattan",
         cellwidth = 10, cellheight = 10,
         cutree_rows = max(5, floor(nr_float16*20/1000)), cutree_cols = max(5, floor(nc_float16*20/1000)),
         treeheight_row = max(10, floor(nr_float16*0.5)), treeheight_col=max(10,floor(nc_float16*0.5)),
         filename = "FPGP--CovHeatMap_float16.pdf")

pheatmap(KMs_uint8,
         border_color="black",
         clustering_distance_cols = dist_weighted_uint8, clustering_distance_rows = "manhattan",
         cellwidth = 10, cellheight = 10,
         cutree_rows = max(5, floor(nr_uint8*20/1000)), cutree_cols = max(5, floor(nc_uint8*20/1000)),
         treeheight_row = max(10, floor(nr_uint8*0.5)), treeheight_col=max(10,floor(nc_uint8*0.5)),
         filename = "FPGP--CovHeatMap_uint8.pdf")

#
##
### The END ~~~~