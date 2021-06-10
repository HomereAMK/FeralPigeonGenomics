### The BEGINNING ~~~~
##
# ~ Creates FPGP--CoverageHeatMap | By George PACHECO


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


# Creates the plot:
Oi <- pheatmap(KMs,
         border_color="black",
         clustering_distance_cols = Dist_Weighted, clustering_distance_rows = "manhattan",
         cellwidth = 10, cellheight = 10,
         cutree_rows = max(5, floor(NR * 20/1000)), cutree_cols = max(5, floor(NC * 20/1000)),
         treeheight_row = max(10, floor(NR * .5)), treeheight_col=max(10,floor(NC * .5)),
         filename = "FPGP--CovHeatMap.pdf")

str(Oi)

Oi_G <- ggplotGrob(Oi)

print(Oi)


#
##
### The END ~~~~