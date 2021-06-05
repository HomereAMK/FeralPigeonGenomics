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
Mikkel_W <- read.table("Mikkel_Loci_Merged.coverage.km_weighted.tsv", sep = "\t", header = TRUE, check.names = FALSE)
Weights <- read.delim("WeightsTest.txt", header = FALSE, check.names = FALSE)

Weights <- read.table("WeightsTest.txt")

head(Weights_C)

Weights <- as.matrix(Weights)

data_weighted <- Mikkel * sqrt(MyVector_2)
dist_weighted <- dist(t(data_weighted), method = "manhattan")

nc <- ncol(Mikkel)
nr <- nrow(Mikkel)


pheatmap(Mikkel_W, border_color="black",
         clustering_distance_cols = dist_weighted, clustering_distance_rows = "manhattan",
         cellwidth = 10, cellheight = 10,
         cutree_rows = max(5, floor(nr*20/1000)), cutree_cols = max(5, floor(nc*20/1000)),
         treeheight_row = max(10, floor(nr*0.5)), treeheight_col=max(10,floor(nc*0.5)),
         filename = "TEST_PBGP_NEW_7.pdf")



Plot


MyVector <- rpois(n = 300, lambda = 10)


MyVector_2 <- c(8.60233,7,11.4891,5.19615,2.64575,10.8628,4.58258,7.68115,9.16515,4.79583,8.94427,4.12311,6.55744,7.81025,27.9106,10.3441,6.9282,8.3666,
4.24264,2,16.4012,17.9444,2.23607,4.12311,12.8062,196.942,9.89949,6.85565,11.1355,2,7.61577,4.12311,6.9282,10.198,7.61577,5,7.81025,40.2741,
9.53939,3.31662,7.28011,129.201,4.47214,4,3.74166,6.85565,4.24264,3.60555,12,8.24621,4.58258,5.09902,7.14143,3,11.1803,6.55744,6.08276,7.4162,
4.69042,6.40312,8.24621,5.19615,6.78233,6.9282,489.044,5.09902,7.2111,5.19615,3.74166,12.53,100.851,15.843,19.2094,10.0499,7.93725,3.87298,
10.3923,2.44949,4.79583,9.59166,7.87401,4.3589,7,7.81025,9.43398,2.44949,7.4162,3.4641,1.73205,9.64365,5.83095,19.0788,10.9087,4.24264,6.16441,
10.3441,7.2111,6.7082,8.30662,6.245,2.23607,3.60555,8.83176,4.79583,6.9282,8.544,3.16228,4.3589,9.89949,13.9284,2.23607,8.83176,5.91608,7.54983,
4.58258,3.87298,11.6619,2.44949,2.64575,9.53939,5.47723,6.7082,2.44949,9.43398,8,14,6.32456,4.69042,11.4891,5.19615,7.81025,5.74456,5.47723,
2.44949,12.2882,4.89898,7.07107,13.3417,4.12311,16.4317,5.74456,2.23607,4.89898,5.56776,20.8087,4.58258,5.47723,12.6491,9.16515,4.3589,5.19615,
6.85565,7,8.48528,8.18535,2.82843,5.65685,2.82843,8.24621,1.73205,4.89898,1.41421,7.14143,13.8924,33.6303,4.47214,7.87401,10.6301,5.38516,5.65685,
4.24264,6.7082,5.47723,6.48074,4.12311,5.2915,1.41421,5.47723,13.8203,5.91608,14.7986,3.16228,2.44949,4.47214,8.94427,4.69042,4.79583,1.73205,
21.6795,4.58258,2.64575,4.89898,5.19615,16.0935,3.31662,18.7083,3.16228,7.81025,21.6102,5.65685,8.42615,8.60233,3.74166,5.19615,13.3417,7.28011,
8.42615,3,8.24621,4.69042,1.41421,8.83176,6.48074,2.82843,6.16441,2.82843,8.12404,11.8743,5.09902,8.18535,6,4.24264,8.48528,8.24621,6.32456,
3.31662,10.7703,18.4662,7.2111,2.44949,9.53939,2.82843,8.83176,3.60555,5.19615,7.74597,5,5.2915,14.7648,9.84886,6.08276,16.6132,6.85565,17.4356,
17.4929,3.16228,3,4.47214,3.60555,3.87298,8.77496,5.65685,7.68115,12,4,5.19615,7,9.43398,5.2915,14.6287,3.4641,3.60555,2.82843,3.60555,3.31662,
6.7082,3.87298,4.58258,5.56776,4.89898,10.0499,4.3589,6.7082,1,7.28011,8.66025,6.55744,2.64575,3.4641,5.38516,9.16515,2.64575,9.79796,6.85565,1.41421,
16.0935,4,9.53939,10.8628,7.54983,5.83095,6.16441,5,4.69042,5.74456,3,5.19615,4.58258,8.66025,5.47723)












clustering_distance_cols=dist_weighted, clustering_distance_rows="manhattan",

pheatmap(Mikkel, border_color = "black", clustering_distance_cols = "manhattan", clustering_distance_rows = "manhattan")

CrazyDist <- dist(t(MyVector), method = "manhattan")

(t(MyVector))

head(CrazyDist)

data_weighted <- data * sqrt(as.vector(clust_sizes))




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