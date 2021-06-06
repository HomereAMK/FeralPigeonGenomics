### The BEGINNING ~~~~
##
# Creates FPGP--CoverageHeatMap | By George PACHECO

# Sets working directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages:

pacman::p_load(pheatmap, tidyverse, ggrepel, extrafont, cowplot)

# Imports extra fonts:

loadfonts(device = "win", quiet = TRUE)

# Loads data:

Mikkel <- read.table("Mikkel_Loci_Merged.coverage.km.tsv", sep = "\t", header = TRUE, check.names = FALSE)
Vector_M <- rpois(n = 300, lambda = 10)

data_weighted_M <- Mikkel * sqrt(Vector_M)
dist_weighted_M <- dist(t(data_weighted_M), method = "manhattan")

data_weighted_M_R <- Mikkel * Vector_M_R
dist_weighted_M_R <- dist(t(data_weighted_M_R), method = "manhattan")

nc_M <- ncol(Mikkel)
nr_M <- nrow(Mikkel)


Vector_M_R <- na.omit(as.matrix(read.table("WeightsTest_C.txt", sep = ","))[1,])



pheatmap(Mikkel, border_color="black",
         clustering_distance_cols = dist_weighted_M_R, clustering_distance_rows = "manhattan",
         cellwidth = 10, cellheight = 10,
         cutree_rows = max(5, floor(nr_M*20/1000)), cutree_cols = max(5, floor(nc_M*20/1000)),
         treeheight_row = max(10, floor(nr_M*0.5)), treeheight_col=max(10,floor(nc_M*0.5)),
         filename = "Mikkel_R_New.pdf")

Pigeon <- read.table("output_float16.km.tsv", sep = "\t", row.names = 1, header = TRUE, check.names = FALSE)
#Pigeon_W <- read.table("output_float16.km_weighted.tsv", sep = "\t", header = TRUE, check.names = FALSE)
Vector_P <- rpois(n = 100, lambda = 10)

head(Pigeon)

data_weighted_P <- Pigeon * sqrt(Vector_P)
dist_weighted_P <- dist(t(data_weighted_P), method = "manhattan")

nc_P <- ncol(Pigeon)
nr_P <- nrow(Pigeon)

pheatmap(Pigeon, border_color="black",
         clustering_distance_cols = dist_weighted_P, clustering_distance_rows = "manhattan",
         cellwidth = 10, cellheight = 10,
         cutree_rows = max(5, floor(nr_P*20/1000)), cutree_cols = max(5, floor(nc_P*20/1000)),
         treeheight_row = max(10, floor(nr_P*0.5)), treeheight_col=max(10,floor(nc_P*0.5)),
         filename = "Pigeons.pdf")

clustering_distance_cols=dist_weighted, clustering_distance_rows="manhattan",

pheatmap(Mikkel, border_color = "black", clustering_distance_cols = "manhattan", clustering_distance_rows = "manhattan")




Data <- read.table("output_float16.km_weighted.tsv", sep = "\t", header = TRUE)

data <- read.delim("output_float16.km_weighted.tsv", header = TRUE)

data_M <- as.matrix(data)

data_M <- t(data_M) #transpose


data_MUP <- scale(data_M)



pheatmap(data_M)

head(Data)

NC <- ncol(Data)
NR <- nrow(Data)

pheatmap(as.matrix(Data))

<pheatmap(Data, border_color = "black", clustering_distance_cols = dist_weighted, clustering_distance_rows = "manhattan", treeheight_row = max(10, floor(nr*0.5)),
         treeheight_c = max(10, floor(nr*0.5)), treeheight_col = max(10,floor(nc*0.5)), cellwidth = 10, cellheight = 10, cutree_rows = max(5,floor(nr*20/1000)),
         filename = Isac)

pheatmap(as.matrix(Data), border_color="black", treeheight_row=125, treeheight_col=125, cellwidth=10, cellheight=10, cutree_rows=12, cutree_cols=10, filename = "PBGP Loci Stats Loci_Merged.coverage -- To be Edited.pdf")

pheatmap(Data, border_color = "black", cluster_rows = TRUE, cluster_cols = TRUE, clustersing_distance_cols = "manhattan", clustering_distance_row = "manhattan",
         treeheight_row = 135, treeheight_col = 135, cellwidth = 10, cellheight = 10, cutree_rows = 6, cutree_cols = 6,
         filename = "TEST_PBGP.pdf")

pheatmap(Data, border_color = "black", cluster_rows = TRUE, cluster_cols = TRUE, clustersing_distance_cols = "manhattan", clustering_distance_row = "manhattan",
         treeheight_row = 135, treeheight_col = 135, cellwidth = 10, cellheight = 10, cutree_rows = 6, cutree_cols = 6,
         filename = "TEST_PBGP.pdf")

pheatmap(as.matrix(Data), border_color = "black", cluster_rows = TRUE, cluster_cols = TRUE, clustersing_distance_cols = "manhattan", clustering_distance_row = "manhattan",
         filename = "TEST_PBGP.pdf")

head(Data)

# treeheight_row = 135, treeheight_col = 135, cellwidth = 10, cellheight = 10, cutree_rows = 6, cutree_cols = 6,

?pheatmap




         pheatmap(data, border_color="black", cluster_rows = FALSE, cluster_cols = FALSE, cellwidth = 10, cellheight = 10, filename = TESTt))

# Clean-up
for (file in list.files(pattern=rnd_id)) {
  file.remove(file)
}
EOF
}
export -f plot_heatmap
\parallel -j $N_JOBS "plot_heatmap $((N_THREADS/N_JOBS)) {.} $K $N_START `dirname $0`" ::: *.coverage.tsv






pheatmap(as.matrix(data), border_color="black", treeheight_row=125, treeheight_col=125, cellwidth=10, cellheight=10, cutree_rows=12, cutree_cols=10, filename = "PBGP Loci Stats Loci_Merged.coverage -- To be Edited.pdf")

#
##
### The END ~~~~