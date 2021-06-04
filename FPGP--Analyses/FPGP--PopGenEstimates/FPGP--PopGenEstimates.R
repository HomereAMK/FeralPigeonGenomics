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

PopGen <- read.table("FPGP--MDS.PopGenSummary", sep = "\t", header = FALSE)
Hets <- read.table("FPGP--HetProportions.HetSummary", sep = "\t", header = FALSE)

# Adds column names:

colnames(PopGen) <- c("Population", "NSites", "Nucleotide Diversity", "Watson's Theta", "Tajima's D", "BioStatus")
colnames(Hets) <- c("Sample_ID", "Population", "Het", "DataType")

Hets %>% mutate(BioStatus =
                  case_when(
                    endsWith(Population, "Torshavn") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Ejde") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Sumba") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "LjosAir") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Kunoy") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Nolsoy") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Crete") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Sardinia") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Vernelle") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "WadiHidan") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "PigeonIsland") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Trincomalee") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Guimaraes") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Lisbon") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Barcelona") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Berlin") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Cambridge") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Colombo") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Copenhagen") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "London") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Prague") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Jihlava") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Abadeh") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Isfahan") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Lahijan") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Nowshahr") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Tehran") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "TelAviv") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "SaltLakeCity") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Denver") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Virginia") ~ "Localities Outside Natural Range",
                    endsWith(Population, "TlaxcalaDeXicohtencatl") ~ "Localities Outside Natural Range",
                    endsWith(Population, "MexicoCity") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Monterrey") ~ "Localities Outside Natural Range",
                    endsWith(Population, "SanCristobalDeLasCasas") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Santiago") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Salvador") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Tatui") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Johannesburg") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Nairobi") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Perth") ~ "Localities Outside Natural Range",
                    endsWith(Population, "TelAvivColony") ~ "Captive Populations",
                    endsWith(Population, "Wattala") ~ "Captive Populations",
                    endsWith(Population, "Wellawatte") ~ "Captive Populations",
                    endsWith(Population, "Srisoria") ~ "Outgroup",
                    endsWith(Population, "Cpalumbus") ~ "Outgroup",
                    endsWith(Population, "Crupestris") ~ "Outgroup"))

# Reorganises the data:

Data$Population <- factor(Data$Population, ordered = T,
                   levels = c("Torshavn", "Crete", "Sardinia", "Vernelle", "Wadi Hidan", "Pigeon Island", "Trincomalee",
                              "Lisbon", "Guimaraes", "Barcelona", "London", "Berlin", "Copenhagen", "Prague", "Tel Aviv", "Abadeh", "Tehran", "Lahijan", "Nowshahr", "Isfahan", "Colombo",
                              "Denver", "Salt Lake City", "Tlaxcala de Xicohtencatl", "Mexico City", "Monterrey",
                              "San Cristobal de las Casas", "Santiago", "Salvador", "Tatui", "Johannesburg", "Nairobi", "Perth",
                              "Tel Aviv Colony"))

# Prepares the data:

Data_lg <- gather(Data, "Estimate", "Value", Nucleotide_Diversity, Watson's Theta, Tajima's D)

# Creates the plots:

ggplot(data = Data_lg, aes(x = get(Population))) +
  geom_point(aes(x = Population, y = Value, fill = BioStatus), colour = "black", shape = 21, size = 3.5, alpha = .9) +
  facet_grid(vars(Estimate), scales = "free") +
  scale_fill_manual(values = c("#56B4E9", "#E69F00", "#44AA99", "#F0E442"), drop = FALSE) +
  scale_colour_manual(values = c("#56B4E9", "#E69F00", "#44AA99", "#F0E442"), drop = FALSE) +
  theme(panel.background = element_rect(fill = "#FAFAFA"),
        panel.grid.major.x = element_line(color = "#ededed", linetype = "dashed", size = .00005),
        panel.grid.major.y = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.border = element_blank(),
        axis.line = element_line(colour = "#000000", size = .3),
        axis.title = element_blank(),
        axis.text.x = element_text(colour="#000000", size = 16, face = "bold", family = "Helvetica", angle = 90, vjust = .5, hjust = 1),
        axis.text.y = element_text(color="#000000", size = 16, family = "Helvetica"),
        axis.ticks.x = element_line(color="#000000", size = .3),
        axis.ticks.y = element_line(color="#000000", size = .3),
        strip.background = element_rect(colour = "#000000", fill = "#d6d6d6", size = .05),
        strip.text = element_text(colour="#000000", size = 14, face = "bold", family = "Georgia"),
        legend.position = "right")

# Saves the final plot:

ggsave(file = "FPGP--PopGenEstimates.pdf", device = cairo_pdf, height = 8, width = 12, scale = 1.5, dpi = 1000)

#
##
### The END ~~~~