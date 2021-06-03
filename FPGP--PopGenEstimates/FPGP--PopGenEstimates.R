### The BEGINNING ~~~~
##
# > Plots FPGP--PopGenEstimates | By George PACHECO


# Sets working directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages:

pacman::p_load(ggplot2, scales, extrafont, dplyr, grid, lubridate, cowplot, egg, tidyverse)

# Imports extra fonts:

loadfonts(device = "win", quiet = TRUE)

# Loads the data

Data <- read.table("GoodSamples_NoSrisoriaNoCpalumbus-DoSaf-WithWrapper-DoThetas-NoWrapper.PopGenSummary", sep = "\t", header = FALSE)

# Adds 

colnames(Data) <- c("Population", "NSites", "Pi", "tW", "Td")

# Reorganises the data:

Data$Population <- factor(Data$Population, ordered = T, levels = c("Cpalumbus", "PigeonIsland", "Trincomalee", "Abadeh", "Tehran", "Crete", "Sardinia", "Vernelle", "Torshavn", "TelAviv", "TelAvivColony", "WadiHidan",
                                                         "Nairobi", "Colombo", "Lahijan", "Nowshahr", "Isfahan", "Guimaraes", "Barcelona", "Lisbon", "Salvador", "Tatui", "Denver", "Santiago", "SaltLakeCity",
                                                         "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas", "Prague", "Berlin", "Copenhagen",  "Johannesburg", "London",  "Perth"))

# Prepares the data:

Data_lg <- gather(Data, Estimate, Value, Pi, tW, Td)

# Creates the plots:

ggplot(data = Data_lg, aes(x = get(Population))) +
  geom_point(aes(x = Population, y = Value), size = 2.5, alpha = 0.9) +
  facet_grid(vars(Estimate), labeller = labeller(facet.labs), scales = "free") +
  theme(panel.background = element_rect(fill = '#FAFAFA'),
        panel.grid = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "#000000", size = 0.3),
        axis.title = element_blank(),
        axis.text.x = element_text(colour="#000000", size = 16, face = "bold", family = "Helvetica", angle = 90, vjust = 0.5, hjust = 1),
        axis.text.y = element_text(color="#000000", size = 16, family = "Helvetica"),
        axis.ticks.x = element_line(color="#000000", size = 0.3),
        axis.ticks.y = element_line(color="#000000", size = 0.3),
        strip.background = element_rect(colour = "#000000", fill = '#c9c9c9', size = 0.05),
        strip.text = element_text(colour="#000000", size = 4, face = "bold", family = "Georgia"),
        legend.position = "none")

facet.labs <- c("Nucleotide Diversity", "Watson's Theta", "Tajima's D")

# Saves the final plot:

ggsave(file = "FPGP--PopGenEstimates_NEW.pdf", device = cairo_pdf, height = 8, width = 12, scale = 1.5, dpi = 1000)

#
##
### The END ~~~~