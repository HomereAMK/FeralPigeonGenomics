# To Plot SNP Density

setwd("/Users/hintze/Desktop/PBGP--FINAL/Anaysis/Stats/SNP-Info/")

library(ggplot2)

a <- read.table("PBGP--GoodSamples_MinMaf-0.005_doHaploCall.ANGSD.ScaffoldInfo_OnlyWithSNPs.txt")
colnames(a) <- c("Scaffold","ScaffoldLength", "NumberOfSNPs")

a <- cbind(a,round=round(a$NumberOfSNPs/a$ScaffoldLength,4))

quantile(a$round, probs=.95)
ggplot(a, aes(Scaffold,round)) +
  scale_x_discrete("Scaffold"),
                     #breaks = c(10000000, 20000000, 30000000, 40000000, 50000000, 60000000, 70000000),
                     #labels = c("1e+07", "2e+07", "3e+07", "4e+07", "5e+07", "6e+07", "7e+07"),
                     #limits = c(0, 80000000),
                     #expand = c(0,0)) +
  scale_y_continuous("# of SNPs") +
                     #breaks = c(500, 1000, 1500, 2000, 2500),
                     #labels = c("500", "1000", "1500", "2000","2500"),
                     #limits = c(0, 2600),
                     #expand = c(0,0)) +
  #labs(x = "Scaffolds", y = "SNP Density") +
  theme(axis.text.x=element_blank(),
        axis.text.y=element_blank()) +
  theme(axis.title.x = element_text(size = 12, color="#000000", face="bold"), 
        axis.title.y=element_text(size = 12, color="#000000", face="bold")) +
  theme(panel.background = element_rect(fill = '#F3F3F3')) +
  theme(axis.ticks.x = element_line(size=0.4, color="#000000"),
        axis.ticks.y = element_line(size=0.4, color="#000000")) +
  theme(panel.grid.major = element_blank(),
      panel.grid.minor=element_blank(), 
      axis.line=element_line(colour="#000000", size=0.4, color="#000000")) +
  theme(panel.border=element_blank())

ggsave("Adoro_OnlyWithSNPs.pdf", height=2, width=3.5, scale=3)