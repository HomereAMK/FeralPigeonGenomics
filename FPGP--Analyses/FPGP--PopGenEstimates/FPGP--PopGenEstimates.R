### The BEGINNING ~~~~
##
# > Plots FPGP--PopGenEstimates | By George PACHECO


# Sets working directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages:

pacman::p_load(ggplot2, scales, extrafont, dplyr, grid, lubridate, cowplot, egg, tidyverse, stringr)

# Imports extra fonts:

loadfonts(device = "win", quiet = TRUE)

# Loads the data

PopGen <- read.table("FPGP--MDS.PopGenSummary", sep = "\t", header = FALSE)
Hets <- read.table("FPGP--HetProportions.HetSummary", sep = "\t", header = FALSE)

# Adds column names:

colnames(PopGen) <- c("Population", "NSites", "Nucleotide Diversity", "Watson's Theta", "Tajima's D", "BioStatus")
colnames(Hets) <- c("Sample_ID", "Population", "Het", "DataType")

# Corrects the names of the localities:

Hets$Population <- sub("SaltLakeCity", "Salt Lake City", Hets$Population)
Hets$Population <- sub("TlaxcalaDeXicohtencatl", "Tlaxcala de Xicohtencatl", Hets$Population)
Hets$Population <- sub("SanCristobalDeLasCasas", "San Cristobal de las Casas", Hets$Population)
Hets$Population <- sub("MexicoCity", "Mexico City", Hets$Population)
Hets$Population <- sub("Tatui", "Tatuí", Hets$Population)
Hets$Population <- sub("Torshavn", "Tórshavn", Hets$Population)
Hets$Population <- sub("Ejde", "Eiði", Hets$Population)
Hets$Population <- sub("LjosAir", "Ljós Áir", Hets$Population)
Hets$Population <- sub("Guimaraes", "Guimarães", Hets$Population)
Hets$Population <- sub("TelAvivColony", "Tel Aviv Colony", Hets$Population)
Hets$Population <- sub("TelAviv", "Tel Aviv", Hets$Population)
Hets$Population <- sub("WadiHidan", "Wadi Hidan", Hets$Population)
Hets$Population <- sub("PigeonIsland", "Pigeon Island", Hets$Population)

# Adds new column (BioStatus):

HetsUp <- Hets %>% mutate(BioStatus =
                  case_when(
                    endsWith(Population, "Tórshavn") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Eiði") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Sumba") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Ljós Áir") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Kunoy") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Nolsoy") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Crete") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Sardinia") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Vernelle") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Wadi Hidan") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Pigeon Island") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Trincomalee") ~ "Remote Localities Within Natural Range",
                    endsWith(Population, "Guimarães") ~ "Urban Localities Within Natural Range",
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
                    endsWith(Population, "Tel Aviv") ~ "Urban Localities Within Natural Range",
                    endsWith(Population, "Salt Lake City") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Denver") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Virginia") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Tlaxcala de Xicohtencatl") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Mexico City") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Monterrey") ~ "Localities Outside Natural Range",
                    endsWith(Population, "San Cristobal de las Casas") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Santiago") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Salvador") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Tatuí") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Johannesburg") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Nairobi") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Perth") ~ "Localities Outside Natural Range",
                    endsWith(Population, "Tel Aviv Colony") ~ "Captive Populations",
                    endsWith(Population, "Wattala") ~ "Captive Populations",
                    endsWith(Population, "Wellawatte") ~ "Captive Populations",
                    endsWith(Population, "Srisoria") ~ "Outgroup",
                    endsWith(Population, "Cpalumbus") ~ "Outgroup",
                    endsWith(Population, "Crupestris") ~ "Outgroup"))

head(HetsUp, n = 400)

# Reorganises the data:

PopGen$Population <- factor(PopGen$Population, ordered = T,
       levels = c("Torshavn", "Crete", "Sardinia", "Vernelle", "Wadi Hidan", "Pigeon Island", "Trincomalee",
                              "Lisbon", "Guimaraes", "Barcelona", "London", "Berlin", "Copenhagen", "Prague", "Tel Aviv", "Abadeh", "Tehran", "Lahijan", "Nowshahr", "Isfahan", "Colombo",
                              "Denver", "Salt Lake City", "Tlaxcala de Xicohtencatl", "Mexico City", "Monterrey",
                              "San Cristobal de las Casas", "Santiago", "Salvador", "Tatui", "Johannesburg", "Nairobi", "Perth",
                              "Tel Aviv Colony"))

HetsUp$Population <- factor(HetsUp$Population, ordered = T,
       levels = c("Tórshavn", "Eiði", "Sumba", "Ljós Áir", "Kunoy", "Nolsoy", "Crete", "Sardinia", "Vernelle", "Wadi Hidan", "Pigeon Island", "Trincomalee",
             "Lisbon", "Guimarães", "Barcelona", "London", "Cambridge", "Berlin", "Copenhagen", "Prague", "Jihlava", "Tel Aviv", "Abadeh", "Tehran",
             "Lahijan", "Nowshahr", "Isfahan", "Colombo",
             "Denver", "Salt Lake City", "Virginia", "Tlaxcala de Xicohtencatl", "Mexico City", "Monterrey", "San Cristobal de las Casas", "Santiago", "Salvador", "Tatuí",
             "Johannesburg", "Nairobi", "Perth", "Tel Aviv Colony", "Wellawatte", "Wattala", "Crupestris", "Cpalumbus", "Srisoria"))

ggplot(HetsUp, aes(factor(Population), Het)) +
  geom_boxplot(aes(fill = BioStatus), outlier.size = 1.5, width = 0.3) +
  labs(x = HetsUp$Population, y = "Proportion of Heterozygous Sites") +
  theme(panel.background = element_rect(fill = '#FAFAFA'),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "#000000", size = 0.3),
        axis.title.x=element_blank(),
        axis.title.y=element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text.x = element_text(colour = "#000000", size = 16, angle = 90, vjust = 0.5, hjust = 1),
        axis.text.y = element_text(color = "#000000", size = 16),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_line(color="#000000", size=0.3),
        legend.position = "none")

HetsUp[HetsUp$Population == c("Tatuí", "Copenhapen", "Berlin"), ]

HetsUp %>% filter(Population == c("Tatuí", "Copenhagen", "Berlin"))


HetsUp %>% filter(Population != "Wattala" | Population != "Wellawatte" | Population != "Srisoria")

endsWith(Population, "Wattala") ~ "Captive Populations",
endsWith(Population, "Wellawatte") ~ "Captive Populations",
endsWith(Population, "Srisoria") ~ "Outgroup",
endsWith(Population, "Cpalumbus") ~ "Outgroup",
endsWith(Population, "Crupestris") ~ "Outgroup"))

# Prepares the data:

PopGenUp <- gather(PopGen, Estimate, Value, "Nucleotide Diversity", "Watson's Theta", "Tajima's D")

head(PopGenUp)
head(HetsUp)

rbind(PopGenUp, HetsUp)

# Creates the plots:

ggplot(data = PopGen_lg, aes(x = get(Population))) +
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
        strip.text = element_text(colour="#000000", size = 12, face = "bold", family = "Georgia"),
        legend.position = "top",
        legend.title = element_blank(),
        legend.background =element_blank(),
        legend.key = element_rect(fill = NA))

# Saves the final plot:

ggsave(file = "FPGP--Het.pdf", device = cairo_pdf, height = 8, width = 12, scale = 1.5, dpi = 1000)

#
##
### The END ~~~~