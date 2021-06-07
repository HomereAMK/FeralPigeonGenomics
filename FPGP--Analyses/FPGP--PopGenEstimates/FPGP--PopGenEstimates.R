### The BEGINNING ~~~~
##
# > Plots FPGP--PopGenEstimates | By George PACHECO


# Sets working directory:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#install.packages("pacman")#install to use the function below
pacman::p_load(scales, extrafont, dplyr, grid, lubridate, cowplot, egg, tidyverse, stringr, reshape)


# Imports extra fonts:
#~~~~~~~~~~~~~~~~~~~~~~~~~~
loadfonts(device = "win", quiet = TRUE)



# Loads the data:
#~~~~~~~~~~~~~~~~~
PopGen <- read.table("FPGP--MDS.PopGenSummary", sep = "\t", header = FALSE); head(PopGen)
Hets <- read.table("FPGP--HetProportions.HetSummary", sep = "\t", header = FALSE); head(Hets)



# Tidying up data frames
#~~~~~~~~~~~~~~~~~~~~~~~~
## Adds column names:
#colnames(PopGen) <- c("Population", "NSites", "Nucleotide Diversity", "Watson's Theta", "Tajima's D", "BioStatus") #Never use aposthropes in any programming language. Also, avoid using spaces between words -- all this causes problems! Instead, use "underscores". You can always change the names in your plotting routine afterwards.
colnames(PopGen) <- c("Population", "NSites", "Nucleotide_Diversity", "Watson_Theta", "Tajima_D", "BioStatus")
colnames(Hets) <- c("Sample_ID", "Population", "Het", "DataType")


## Corrects the names of the localities:
# Consider my comment made above -- Avoid using blank spaces between words

# Hets$Population <- sub("SaltLakeCity", "Salt Lake City", Hets$Population)
# Hets$Population <- sub("TlaxcalaDeXicohtencatl", "Tlaxcala de Xicohtencatl", Hets$Population)
# Hets$Population <- sub("SanCristobalDeLasCasas", "San Cristobal de las Casas", Hets$Population)
# Hets$Population <- sub("MexicoCity", "Mexico City", Hets$Population)
# Hets$Population <- sub("Tatui", "Tatuí", Hets$Population)
# Hets$Population <- sub("Torshavn", "Tórshavn", Hets$Population)
# Hets$Population <- sub("Ejde", "Eiði", Hets$Population)
# Hets$Population <- sub("LjosAir", "Ljós Áir", Hets$Population)
# Hets$Population <- sub("Guimaraes", "Guimarães", Hets$Population)
# Hets$Population <- sub("TelAvivColony", "Tel Aviv Colony", Hets$Population)
# Hets$Population <- sub("TelAviv", "Tel Aviv", Hets$Population)
# Hets$Population <- sub("WadiHidan", "Wadi Hidan", Hets$Population)
# Hets$Population <- sub("PigeonIsland", "Pigeon Island", Hets$Population)

levels(PopGen$Population)
PopGen$Population <- as.factor(gsub(" ", "", PopGen$Population, fixed = TRUE)) #Removing whitespace from factor levels

PopGen$BioStatus <- as.factor(gsub(" ", "_", PopGen$BioStatus)) #Now do the reverse thing with BioStatus



## Adds new column to Hets df (BioStatus):
# See suggestion below for a shorter solution? 
# Note: Keep consistency in colum names that are common across the two DFs (eg. BioStatus vs. BiologicalStatus)
Hets$BioStatus <- ifelse(Hets$Population %in% c("Torshavn","Ejde","Sumba","LjosAir","Kunoy","Nolsoy","Crete",
                                                "Sardinia","Vernelle","WadiHidan","PigeonIsland","Trincomalee"), "Remote_Localities_Within_Natural_Range",
                  ifelse(Hets$Population %in% c("Guimaraes","Lisbon","Barcelona","Berlin","Cambridge",
                                                "Colombo","Copenhagen","London","Prague","Jihlava","Abadeh",
                                                "Isfahan","Lahijan","Nowshahr","Tehran","TelAviv"), "Urban_Localities_Within_Natural_Range",
                  ifelse(Hets$Population %in% c("SaltLakeCity","Denver","Virginia","TlaxcalaDeXicohtencatl",
                                                "MexicoCity","Monterrey","SanCristobalDeLasCasas","Santiago",
                                                "Salvador","Tatui","Johannesburg","Nairobi","Perth"), "Localities_Outside_Natural_Range",
                  ifelse(Hets$Population %in% c("TelAvivColony","Wattala", "Wellawatte"), "Captive_Populations", "Outgroups"))))
                 
Hets$BioStatus <- as.factor(Hets$BioStatus)

HetsUp <- Hets #To keep consistency with your script


# HetsUp <- Hets %>% mutate(BiologicalStatus =
#                    case_when(
#                     endsWith(Population, "Tórshavn") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Eiði") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Sumba") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Ljós Áir") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Kunoy") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Nolsoy") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Crete") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Sardinia") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Vernelle") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Wadi Hidan") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Pigeon Island") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Trincomalee") ~ "Remote Localities Within Natural Range",
#                     endsWith(Population, "Guimarães") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Lisbon") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Barcelona") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Berlin") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Cambridge") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Colombo") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Copenhagen") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "London") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Prague") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Jihlava") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Abadeh") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Isfahan") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Lahijan") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Nowshahr") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Tehran") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Tel Aviv") ~ "Urban Localities Within Natural Range",
#                     endsWith(Population, "Salt Lake City") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Denver") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Virginia") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Tlaxcala de Xicohtencatl") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Mexico City") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Monterrey") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "San Cristobal de las Casas") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Santiago") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Salvador") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Tatuí") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Johannesburg") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Nairobi") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Perth") ~ "Localities Outside Natural Range",
#                     endsWith(Population, "Tel Aviv Colony") ~ "Captive Populations",
#                     endsWith(Population, "Wattala") ~ "Captive Populations",
#                     endsWith(Population, "Wellawatte") ~ "Captive Populations",
#                     endsWith(Population, "Srisoria") ~ "Outgroup",
#                     endsWith(Population, "Cpalumbus") ~ "Outgroup",
#                     endsWith(Population, "Crupestris") ~ "Outgroup"))





# Removes unwanted populations:
out <- c("Ejde","Sumba","LjosAir","Kunoy","Nolsoy","Cambridge","Jihlava","Wattala","Wellawatte","Srisoria","Cpalumbus","Crupestris")
HetsUp <- filter(HetsUp, !Population %in% out)
HetsUp$Population <- factor(HetsUp$Population) #Drop empty factor levels


# HetsUp <- subset(HetsUp, 
#                   HetsUp$Population != "Eiði" &
#                   HetsUp$Population != "Sumba" &
#                   HetsUp$Population != "Ljós Áir" &
#                   HetsUp$Population != "Kunoy" &
#                   HetsUp$Population != "Nolsoy" &
#                   HetsUp$Population != "Cambridge" &
#                   HetsUp$Population != "Jihlava" &
#                   HetsUp$Population != "Wattala" &
#                   HetsUp$Population != "Wellawatte" &
#                   HetsUp$Population != "Srisoria" &
#                   HetsUp$Population != "Cpalumbus" &
#                   HetsUp$Population != "Crupestris")



## Standardize column names and/or factor levels that are common across the DFs
# This is extremely important if later below you will have to merge the two datasets for your potting routine

setdiff(colnames(PopGen), colnames(HetsUp)) #Population & BioStatus seems ok


# Population
nlevels(PopGen$Population);nlevels(HetsUp$Population) #FIXME: There seems to be a missing Population in your GenPops DF. Is this normal? Let's check below which Pop. is missing

#Check missing Population
setdiff(levels(HetsUp$Population), levels(PopGen$Population))
setdiff(levels(PopGen$Population),levels(HetsUp$Population))
# "Virginia" is the missing population; besides, note that "SanCristobalDeLasCasas" & "TlaxcalaDeXicohtencatl" are spelled differentely. Let's fix this:


levels(PopGen$Population)[c(23,30)] <- c("SanCristobalDeLasCasas","TlaxcalaDeXicohtencatl")


# BioStatus 
nlevels(PopGen$BioStatus);nlevels(HetsUp$BioStatus) #FIXME: Same as for "Population"

#Check missing BioStatus
setdiff(levels(HetsUp$BioStatus), levels(PopGen$BioStatus))
# "Outgroups" is the missing BioStatus



## Reorganises the data:
PopGen$Population <- factor(PopGen$Population, ordered = T,
                            levels = c("Torshavn", "Crete", "Sardinia", "Vernelle", "WadiHidan", "PigeonIsland", "Trincomalee",
                                       "Lisbon", "Guimaraes", "Barcelona", "London", "Berlin", "Copenhagen", "Prague", "TelAviv", "Abadeh", "Tehran", "Lahijan", "Nowshahr", "Isfahan", "Colombo",
                                       "Denver", "SaltLakeCity", "TlaxcaladeXicohtencatl", "MexicoCity", "Monterrey",
                                       "SanCristobalDeLasCasas", "Santiago", "Salvador", "Tatui", "Johannesburg", "Nairobi", "Perth",
                                       "TelAvivColony"))

HetsUp$Population <- factor(HetsUp$Population, ordered = T,
                            levels = c("Torshavn", "Crete", "Sardinia", "Vernelle", "WadiHidan", "PigeonIsland", "Trincomalee",
                                       "Lisbon", "Guimaraes", "Barcelona", "London", "Berlin", "Copenhagen", "Prague", "TelAviv", "Abadeh", "Tehran", "Lahijan", "Nowshahr", "Isfahan", "Colombo",
                                       "Denver", "SaltLakeCity", "Virginia", "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas", "Santiago", "Salvador", "Tatui",
                                       "Johannesburg", "Nairobi", "Perth",
                                       "TelAvivColony"))



# PopGen$Population <- factor(PopGen$Population, ordered = T,
#                             levels = c("Torshavn", "Crete", "Sardinia", "Vernelle", "Wadi Hidan", "Pigeon Island", "Trincomalee",
#                                        "Lisbon", "Guimaraes", "Barcelona", "London", "Berlin", "Copenhagen", "Prague", "Tel Aviv", "Abadeh", "Tehran", "Lahijan", "Nowshahr", "Isfahan", "Colombo",
#                                        "Denver", "Salt Lake City", "Tlaxcala de Xicohtencatl", "Mexico City", "Monterrey",
#                                        "San Cristobal de las Casas", "Santiago", "Salvador", "Tatui", "Johannesburg", "Nairobi", "Perth",
#                                        "Tel Aviv Colony"))
#
# HetsUp$Population <- factor(HetsUp$Population, ordered = T,
#                             levels = c("Tórshavn", "Crete", "Sardinia", "Vernelle", "Wadi Hidan", "Pigeon Island", "Trincomalee",
#                                        "Lisbon", "Guimarães", "Barcelona", "London", "Berlin", "Copenhagen", "Prague", "Tel Aviv", "Abadeh", "Tehran", "Lahijan", "Nowshahr", "Isfahan", "Colombo",
#                                        "Denver", "Salt Lake City", "Virginia", "Tlaxcala de Xicohtencatl", "Mexico City", "Monterrey", "San Cristobal de las Casas", "Santiago", "Salvador", "Tatuí",
#                                        "Johannesburg", "Nairobi", "Perth",
#                                        "Tel Aviv Colony"))



## Convert DF from wide to long
#PopGenUp <- gather(PopGen, Estimate, Value, "Nucleotide Diversity", "Watson's Theta", "Tajima's D")
PopGenUp <- gather(PopGen, Estimate, Value, "Nucleotide_Diversity", "Watson_Theta", "Tajima_D")



# Creates the plots:

PlotPopGen <-
 ggplot(data = PopGenUp, aes(x = get(Population))) +
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

PlotHets <-
 ggplot(HetsUp, aes(factor(Population), Het)) +
  #geom_boxplot(aes(fill = BiologicalStatus), outlier.size = 1.5, width = 0.3) +
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

# Saves the final plots:

ggsave(PlotPopGen, file = "FPGP--PopGen.pdf", device = cairo_pdf, height = 8, width = 12, scale = 1.5, dpi = 1000)
ggsave(PlotHets, file = "FPGP--Hets.pdf", device = cairo_pdf, height = 8, width = 12, scale = 1.5, dpi = 1000)

#
##
### The END ~~~~