setwd("/Users/hintze/Desktop/PBGP--FINAL/Anaysis/Stats/Filtering-Confirmation_of_Possible_Paralogs/")
library(ggplot2)
library(scales)

a0 <- read.table("PBGP--GoodSamples_RemovedBadLoci_95Ind_ParalogTest_IntersectedWithRemovedBadLoci.mean")
colnames(a0) <- c("Loci","Coverage")
#a0[,2] <- round(a0[,2])
b0 <- data.frame(Coverage = a0$Coverage, Type = "All Loci", color="#000000")

a1 <- read.table("PBGP--GoodSamples_RemovedBadLoci_95Ind_ParalogTest_IntersectedWithRemovedBadLoci_PossibleParalogs-g650.mean")
colnames(a1) <- c("Loci","Coverage")
#a1[,2] <- round(a1[,2])
b1 <- data.frame(Coverage = a1$Coverage, Type = "Possible Paralog Loci")

a2 <- read.table("PBGP--GoodSamples_RemovedBadLoci_95Ind_ParalogTest_IntersectedWithRemovedBadLoci-PossibleParalogs-g650.mean")
colnames(a2) <- c("Loci","Coverage")
#a1[,2] <- round(a2[,2])
b2 <- data.frame(Coverage = a2$Coverage, Type = "After Filtering")

c <- rbind(b0, b1)
  
ggplot(c, aes(x = Coverage, fill = Type, colour = Type)) +
  geom_density(alpha = 0.1, adjust = 0.5) +
  theme(legend.title=element_blank()) +
  theme(legend.text=element_text(size=10, color="#000000")) +
  theme(legend.position=c(.8, 0.5)) +
  theme(legend.background = element_rect(fill = FALSE)) +
  scale_x_continuous("Global Depth (K)",
                     breaks = c(1000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000, 60000, 65000, 70000, 75000, 80000, 85000),
                     labels = c("1X", "5X", "10X", "15X","20X", "25X", "30X", "35X", "40X", "45X", "50X", "55X", "60X", "65X","70X", "75X", "80X", "85X"),
                     expand = c(0,0),
                     limits = c(0, 85000)) +
  scale_y_continuous("Density",
                     breaks = c(0.00001, 0.00002, 0.00003, 0.00004, 0.00005, 0.00006, 0.00007, 0.00008, 0.00009), 
                     expand = c(0,0),
                     labels = c("1e-05", "2e-05", "3e-05", "4e-05", "5e-05", "6e-05", "7e-05", "8e-05", "9e-05"), 
                     limits = c(0, 0.000094)) +
  theme(axis.text.x = element_text(size=9, color="#000000"),
        axis.text.y = element_text(size=9, color="#000000")) +
  theme(panel.background = element_rect(fill = '#F3F3F3')) +
  theme(axis.ticks.x = element_line(size=0.4, color="#000000"),
        axis.ticks.y = element_line(size=0.4, color="#000000")) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor=element_blank(), 
        axis.line=element_line(colour="#000000", size=0.4, color="#000000")) +
  theme(axis.title=element_text(size=12, face="bold", color="#000000")) +
  theme(panel.border=element_blank())

ggsave("PBGP--GlobalCov-ParalogCofirmation.pdf", height=2, width=3.5, scale=3)