### The BEGINNING ~~~~~
##
# ~ Plots FPG--Sites-ScaffoldsRegression | By George Pacheco.


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(tidyverse, extrafont)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads data ~
Data <- read.table("FPG--GoodSamples.ScaffoldInfo_OnlyWithSites.txt")
colnames(Data) <- c("Scaffold", "ScaffoldLength", "NumberOfSites")


# Performs regression ~
Regression <- lm(formula = Data$ScaffoldLength ~ Data$NumberOfSites, data = Data)
summary(Regression)


# Creates plot ~
Plot <-
 ggplot(Data, aes(ScaffoldLength, NumberOfSites)) +
  stat_smooth(method = "lm") +
  geom_point(alpha = 0.7, color = "#000000", size = 1) +
  annotate("text", label = "Multiple R-squared: 0.9905", x = 17000000, y = 130000, size = 5, colour = "#FF0000") +
  annotate("text", label = "P-value: < 2.2e-16", x = 17000000, y = 122500, size = 5, colour = "#FF0000") +
  scale_x_continuous("Scaffold Length",
                     breaks = c(10000000, 20000000, 30000000, 40000000, 50000000, 60000000, 70000000, 80000000, 90000000),
                     labels = c("10Mb", "20Mb", "30Mb", "40Mb", "50Mb", "60Mb", "70Mb", "80Mb", "90Mb"),
                     limits = c(0, 95000000),
                     expand = c(0,0)) +
  scale_y_continuous("# of Sites",
                     breaks = c(25000, 50000, 75000, 100000, 125000, 150000),
                     labels = c("25K", "50K", "75K", "100K", "125K", "150K"),
                     limits = c(0, 153000),
                     expand = c(0,0)) +
  theme(panel.border = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_rect(fill = "#ffffff"),
        axis.title.x = element_text(size = 16, color = "#000000", face = "bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 16, color = "#000000", face = "bold", margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text = element_text(size = 10, color = "#000000", face = "bold"),
        axis.ticks = element_line(size = .3, color = "#000000"),
        axis.line = element_line(colour = "#000000", size = .3, color = "#000000"))


# Saves plot ~
ggsave(Plot, file = "FPG--Sites-ScaffoldsRegression.pdf",
       device = cairo_pdf, width = 12, height = 8, dpi = 600)
ggsave(Plot, file = "FPG--Sites-ScaffoldsRegression.jpg",
       width = 12, height = 8, dpi = 600)


#
##
### The END ~~~~~
