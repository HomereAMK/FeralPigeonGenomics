setwd("C:/Users/ganpa/OneDrive - Danmarks Tekniske Universitet/Skrivebord/DTU-Aqua--Postdoc/Past/Core/FPGP -- FINISHING/FPGP--GitHub/FeralPigeonGenomicsProject/FPGP--CovHeatMap/")



###   Creates FPGP--Map | By George PACHECO   ###



data=read.table("Loci_Merged.coverage.km.tsv", , sep="\t", check.names=FALSE)
library(pheatmap)  
pheatmap(as.matrix(data), border_color="black", treeheight_row=125, treeheight_col=125, cellwidth=10, cellheight=10, cutree_rows=12, cutree_cols=10, filename = "PBGP Loci Stats Loci_Merged.coverage -- To be Edited.pdf")