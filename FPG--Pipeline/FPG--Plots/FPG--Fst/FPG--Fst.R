### The BEGINNING ~~~~
##
# ~ Plots FPG--Fst | By George Pacheco.


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(pheatmap, tidyverse, reshape2)

?pheatmap


# Loads Fst table ~
data <- read.table("FPG--Fst.tsv", sep = "\t", header = FALSE, stringsAsFactors = FALSE)


# Adds column names ~
colnames(data) <- c("Pop1", "Pop2", "LociNumber", "Unweighted", "Weighted")


# Removes populations ~
data = subset(data, Pop1 != "Cpalumbus" & Pop2 != "Cpalumbus")
data = subset(data, Pop1 != "TelAvivColony" & Pop2 != "TelAvivColony")


# Melts data ~
pops = union(data$Pop1, data$Pop2)
n = length(pops)


# Creates Fst-Sites matrix ~
FstSites <- matrix(0, nrow = n, ncol = n, dimnames = list(pops, pops))
for (i in 1:nrow(data)) {
  FstSites[data[i, "Pop1"], data[i, "Pop2"]] = data[i, "LociNumber"]
  FstSites[data[i, "Pop2"], data[i, "Pop1"]] = data[i, "Weighted"]}


# Writes Fst-Sites matrix ~
write.table(FstSites, "FPG--Fst-Sites.txt", sep = "\t", row.names = TRUE, col.names = TRUE)


# Creates Fst-Fst matrix ~
Fst <- matrix(0, nrow = n, ncol = n, dimnames = list(pops, pops))
for (i in 1:nrow(data)) {
  Fst[data[i, "Pop1"], data[i, "Pop2"]] = data[i, "Weighted"]
  Fst[data[i, "Pop2"], data[i, "Pop1"]] = data[i, "Weighted"]}


# Writes Fst-Fst matrix ~
write.table(Fst, "FPG--Fst-Fst.txt", sep = "\t", row.names = TRUE, col.names = TRUE)


# Creates & Saves the heatmap ~
pheatmap(Fst, clustering_distance_rows = "correlation", clustering_distance_cols = "correlation", border_color = "black", cellwidth = 10, cellheight = 10,
         treeheight_row = 55, treeheight_col = 55, filename = "FPG--Fst.jpg")


#
##
### The END ~~~~~