### The BEGINNING ~~~~
##
# > Plots FPGP--PopGenEstimates | By George PACHECO


# Sets working directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages:

pacman::p_load(ggplot2, scales, extrafont)

# Imports extra fonts:

loadfonts(device = "win", quiet = TRUE)

# Loads the data

Data <- read.table("GoodSamples_NoSrisoriaNoCpalumbus-DoSaf-WithWrapper-DoThetas-NoWrapper.PopGenSummary", sep = "\t", header = FALSE)
colnames(Data) <- c("Population", "NSites", "Pi", "tW", "Td")

# Reorganises the data:

Data$Population <- factor(Data$Population, ordered = T, levels = c("Cpalumbus", "PigeonIsland", "Trincomalee", "Abadeh", "Tehran", "Crete", "Sardinia", "Vernelle", "Torshavn", "TelAviv", "TelAvivColony", "WadiHidan",
                                                         "Nairobi", "Colombo", "Lahijan", "Nowshahr", "Isfahan", "Guimaraes", "Barcelona", "Lisbon", "Salvador", "Tatui", "Denver", "Santiago", "SaltLakeCity",
                                                         "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas", "Prague", "Berlin", "Copenhagen",  "Johannesburg", "London",  "Perth"))

# Creates the plots:

ggplot(Data, aes(factor(Population), tW)) + geom_point(fill = "#F79999", size= 2) +
     labs(x = Data$Population, y = "Watson's Theta") +
     theme(panel.background = element_rect(fill = '#FAFAFA'),
           panel.grid.minor = element_blank(),
           panel.border = element_blank(),
           axis.line = element_line(colour = "#000000", size = 0.3),
           axis.title.x = element_blank(),
           axis.title.y = element_text(size = 22, face = "bold", color = "#000000", margin = margin(t = 0, r = 20, b = 0, l = 0)),
           axis.text.x = element_text(colour="#000000", size = 16, angle = 90, vjust = 0.5, hjust = 1),
           axis.text.y = element_text(color="#000000", size = 16),
           axis.ticks.x = element_blank(),
           axis.ticks.y = element_line(color="#000000", size=0.3),
           legend.position = "none")

ggsave(file = "PopGenStats-tW.eps", device = cairo_pdf, height = 3.6, width = 6, scale = 2, dpi = 1000)