### The BEGINNING ~~~~
##
# Creates FPGP--CoverageHeatMap | By George PACHECO

# Sets Working Directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads libraries:

data=read.table("Loci_Merged.coverage.km.tsv", , sep="\t", check.names=FALSE)
library(pheatmap)  
pheatmap(as.matrix(data), border_color="black", treeheight_row=125, treeheight_col=125, cellwidth=10, cellheight=10, cutree_rows=12, cutree_cols=10, filename = "PBGP Loci Stats Loci_Merged.coverage -- To be Edited.pdf")

#
##
### The END ~~~~