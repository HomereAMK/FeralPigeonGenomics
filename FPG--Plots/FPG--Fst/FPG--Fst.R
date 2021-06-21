### The BEGINNING ~~~~
##
# ~ Plots FPGP--PopGenEstimates | By Marie-Christine RUFENER & George PACHECO


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(pheatmap)


# Loads Fst table ~
data <- read.table("AfterChrGenome_PGP--Fst.tsv", sep = "\t", header = FALSE, stringsAsFactors = FALSE)


# Adds column names ~
colnames(data) <- c("Pop1", "Pop2", "LociNumber", "Unweighted", "Weighted")

# Removes populations ~
#data = subset(data, Pop1 != "XXX" & Pop2 != "XXX")
#data = subset(data, Pop1 != "XXX_1" & Pop2 != "XXX_1")

pops = union(data$Pop1, data$Pop2)
n = length(pops)


# Removes populations ~
FstSites <- matrix(0, nrow = n, ncol = n, dimnames = list(pops, pops))
for (i in 1:nrow(data)) {
  mat[data[i, "Pop1"], data[i, "Pop2"]] = data[i, "LociNumber"]
  mat[data[i, "Pop2"], data[i, "Pop1"]] = data[i, "Weighted"]}


# Removes populations ~
write.table(FstSites, "AfterChrGenome_PGP--Fst_Sites.txt", sep = "\t", row.names = TRUE, col.names = TRUE)


# Removes populations ~
Fst <- matrix(0, nrow = n, ncol = n, dimnames = list(pops, pops))
for (i in 1:nrow(T)) {
  mat[data[i, "Pop1"], data[i, "Pop2"]] = data[i, "Weighted"]
  mat[data[i, "Pop2"], data[i, "Pop1"]] = data[i, "Weighted"]}


# Removes populations ~
write.table(Fst, "AfterChrGenome_PGP--Fst.txt", sep = "\t", row.names = TRUE, col.names = TRUE)


# Removes populations ~
pheatmap(Fst, treeheight_row = 60, treeheight_col = 60, clustering_distance_rows = "correlation", clustering_distance_cols = "correlation", filename = "FPG--Fst.pdf")


#
##
### The END ~~~~~