### To plot correlation between scaffold lengths and number of SNPs

setwd("/Users/hintze/Desktop/PBGP--FINAL/Anaysis/Stats/SNP-Info/")

library(ggplot2)

a <- read.table("PBGP--GoodSamples_MinMaf-0.005_doHaploCall.ANGSD.ScaffoldInfo_OnlyWithSNPs.txt")
colnames(a) <- c("Scaffold","ScaffoldLength", "NumberOfSNPs")
ggplot(a,aes(ScaffoldLength, NumberOfSNPs)) + stat_smooth(method="lm") + geom_point(alpha=0.7, color="#000000", size=1) +
  #annotate("text", label = "R?? = 0.9381192", x = 5000000, y = 1850, size = 5, colour = "#000000") +
  #annotate("text", label = "P-value < 2.2e-16", x = 5000000, y = 1700, size = 5, colour = "#000000") +
  scale_x_continuous("Scaffold Length",
                     breaks = c(10000000, 20000000, 30000000, 40000000, 50000000, 60000000, 70000000),
                     labels = c("1e+07", "2e+07", "3e+07", "4e+07", "5e+07", "6e+07", "7e+07"),
                     limits = c(0, 80000000),
                     expand = c(0,0)) +
  scale_y_continuous("# of SNPs",
                     breaks = c(500, 1000, 1500, 2000, 2500),
                     labels = c("500", "1000", "1500", "2000","2500"),
                     limits = c(0, 2600),
                     expand = c(0,0)) +
  theme(axis.text.x = element_text(size=9, color="#000000"),
        axis.text.y = element_text(size=9, color="#000000")) +
  theme(axis.title.x = element_text(size = 12, color="#000000", face="bold"),
        axis.title.y = element_text(size = 12, color="#000000", face="bold")) +
  theme(panel.background = element_rect(fill = '#F3F3F3')) +
  theme(axis.ticks.x = element_line(size=0.4, color="#000000"),
        axis.ticks.y = element_line(size=0.4, color="#000000")) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor=element_blank(), 
        axis.line=element_line(colour="#000000", size=0.4, color="#000000")) +
  theme(panel.border=element_blank())

ggsave("PBGP--ScaffoldLength-NumberOfSNPs_OnlyWithSNPs.pdf", height=2, width=3.5, scale=3)