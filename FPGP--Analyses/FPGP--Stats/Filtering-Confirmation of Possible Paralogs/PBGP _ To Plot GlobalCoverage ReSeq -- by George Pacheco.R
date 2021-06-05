setwd("/Users/hintze/Desktop/PBGP--FINAL/Anaysis/Stats/Filtering-Confirmation_of_Possible_Paralogs/")
library(ggplot2)
library(scales)
a <- read.table("PBGP--OnlyRe-Seqed_RemovedBadLoci_100Ind_PossibleParalogs_IntersectedWithBedRemovedBadLoci.mean")
colnames(a) <- c("Loci","Coverage")
a[,2] <- round(a[,2])
head(a)

ggplot(a, aes(x = Coverage, group = 1)) +
  geom_density(colour = "orange", fill = "orange", alpha = 0.1, adjust = 0.5) +
  theme(legend.position = "none") +
  scale_x_continuous("Global Depth",
                     breaks = c(50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800),
                     expand = c(0,0),
                     labels = c("50X", "100X", "150X", "200X", "250X", "300X", "350X", "400X", "450X", "500X", "550X", "600X", "650X", "700X", "750X", "800X"),
                     limits = c(0,809)) +
  scale_y_continuous("Density",
                     breaks = c(0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009), 
                     expand = c(0,0),
                     labels = c("1e-03", "2e-03", "3e-03", "4e-03", "5e-03", "6e-03", "7e-03", "8e-03", "9e-03"),
                     limits = c(0, 0.007075)) +
  theme(axis.title=element_text(size=12, face="bold")) +
  theme(axis.text.x = element_text(size=9, color="#000000"),
        axis.text.y = element_text(size=9, color="#000000")) +
  theme(panel.background = element_rect(fill = '#F3F3F3')) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "#000000", size = 0.4)) +
  theme(axis.ticks.x = element_line(size=0.4, color="#000000"), 
        axis.ticks.y = element_line(color="#000000", size=0.4))
  theme(axis.title=element_text(size=12, face="bold", color="#000000")) +
  theme(panel.border = element_blank())

ggsave("PBGP--GlobalCoverage--ParalogTest.pdf", height=2, width=3.5, scale=3)

