# To Plot Heterozygosity Data Summary

setwd("/Users/hintze/Desktop/PhD\ Action\ Plan/Core\ Projects/Finishing/FPGP--FINAL/Analyses/FPGP--Stats/FPGP--HeterozygosityCalc/")
  
library(ggplot2)
library(scales)

a <- read.table("FPGP--GoodSamples--Article--Ultra.Heterozygosity.txt", sep = "\t", header = FALSE)
colnames(a) <- c("Sample_ID", "Location", "Het", "Data_Type")

a$Location <- factor(a$Location, ordered=T, levels=c("SaltLakeCity", "Denver","Virginia","Monterrey","MexicoCity","TlaxcalaDeXicohtencatl","SanCristobalDeLasCasas","Santiago","Salvador",
                                                         "Tatui","Ejde", "Kunoy", "LjosAir","Nolsoy","Sumba","Torshavn", "Copenhagen","Cambridge","London","Berlin","Prague","Jihlava","Vernelle","Barcelona","Guimaraes","Lisbon",
                                                         "Sardinia","Crete", "Nairobi","Johannesburg","Lahijan","Nowshahr","Tehran","Isfahan","Abadeh", "TelAviv","TelAvivColony","WadiHidan",
                                                         "Colombo", "PigeonIsland","Trincomalee","Perth", "Wellawatte", "Wattala", "Crupestris", "Cpalumbus", "Srisoria"))

x <- ggplot(a, aes(factor(Location), Het)) + geom_boxplot(aes(fill = "#F79999"), outlier.size = 1.5, width = 0.3) +
     labs(x = a$Location, y = "Proportion of Heterozygous Sites") +
     theme(panel.background = element_rect(fill = '#FAFAFA'), panel.grid.minor=element_blank(), panel.border = element_blank()) +
     theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
     theme(axis.title.x=element_blank(),
           axis.title.y=element_text(size=20, face="bold", color="#000000", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
     theme(axis.text.x = element_text(colour="#000000", size=16, angle=90, vjust=0.5, hjust=1),
           axis.text.y = element_text(color="#000000", size=16)) +
     theme(axis.ticks.x = element_blank(),
           axis.ticks.y = element_line(color="#000000", size=0.3)) +
     theme(legend.position = "none")

plot(x)

ggsave(x, file = "FPGP--GoodSamples--Article--Ultra.Heterozygosity.eps", height=3.6, width=6, scale=3, dpi = 1000)
