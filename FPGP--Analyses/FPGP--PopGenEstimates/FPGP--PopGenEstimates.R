### The BEGINNING ~~~~
##
# ~ Plots FPGP--PopGenEstimates | By George PACHECO


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(scales, extrafont, dplyr, grid, lubridate, cowplot, egg, tidyverse, stringr, reshape)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads the data ~
PopGen <- read.table("FPGP--MDS.PopGenSummary", sep = "\t", header = FALSE); head(PopGen)
Hets <- read.table("FPGP--HetProportions.HetSummary", sep = "\t", header = FALSE); head(Hets)


# Tidies up data frames ~
colnames(PopGen) <- c("Population", "NSites", "Nucleotide_Diversity", "Watson_Theta", "Tajima_D", "BioStatus")
colnames(Hets) <- c("Sample_ID", "Population", "Het", "DataType")

levels(PopGen$Population)
PopGen$Population <- as.factor(gsub(" ", "", PopGen$Population, fixed = TRUE))
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

# Removes unwanted populations:
UnwantedPops <- c("Virginia", "Ejde", "Sumba", "LjosAir", "Kunoy", "Nolsoy", "Cambridge", "Jihlava",
                  "Wattala", "Wellawatte", "Srisoria", "Cpalumbus", "Crupestris")
HetsUp <- filter(HetsUp, !Population %in% UnwantedPops)
HetsUp$Population <- factor(HetsUp$Population) #Drop empty factor levels

## Standardize column names and/or factor levels that are common across the DFs
# This is extremely important if later below you will have to merge the two datasets for your potting routine

setdiff(colnames(PopGen), colnames(HetsUp)) #Population & BioStatus seems ok


# Population
nlevels(PopGen$Population); nlevels(HetsUp$Population) #FIXME: There seems to be a missing Population in your GenPops DF. Is this normal? Let's check below which Pop. is missing

#Check missing Population
setdiff(levels(HetsUp$Population), levels(PopGen$Population))
setdiff(levels(PopGen$Population),levels(HetsUp$Population))
# "Virginia" is the missing population; besides, note that "SanCristobalDeLasCasas" & "TlaxcalaDeXicohtencatl" are spelled differentely. Let's fix this:


levels(PopGen$Population)[c(23, 30)] <- c(
                                       "SanCristobalDeLasCasas",
                                       "TlaxcalaDeXicohtencatl")


# BioStatus 
nlevels(PopGen$BioStatus); nlevels(HetsUp$BioStatus) #FIXME: Same as for "Population"

#Check missing BioStatus
setdiff(levels(HetsUp$BioStatus), levels(PopGen$BioStatus))
# "Outgroups" is the missing BioStatus


## Reorganises the data:
PopGen$Population <- factor(PopGen$Population, ordered = T,
                            levels = c("Torshavn", "Crete", "Sardinia", "Vernelle", "WadiHidan", "PigeonIsland", "Trincomalee",
                                       "Lisbon", "Guimaraes", "Barcelona", "London", "Berlin", "Copenhagen", "Prague", "TelAviv", 
                                       "Abadeh", "Tehran", "Lahijan", "Nowshahr", "Isfahan", "Colombo", "Denver", "SaltLakeCity", 
                                       "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey","SanCristobalDeLasCasas", "Santiago", 
                                       "Salvador", "Tatui", "Johannesburg", "Nairobi", "Perth", "TelAvivColony"))

HetsUp$Population <- factor(HetsUp$Population, ordered = T,
                            levels = c("Torshavn", "Crete", "Sardinia", "Vernelle", "WadiHidan", "PigeonIsland", "Trincomalee",
                                       "Lisbon", "Guimaraes", "Barcelona", "London", "Berlin", "Copenhagen", "Prague", "TelAviv", "Abadeh", "Tehran", "Lahijan", "Nowshahr", "Isfahan", "Colombo",
                                       "Denver", "SaltLakeCity", "Virginia", "TlaxcalaDeXicohtencatl", "MexicoCity", "Monterrey", "SanCristobalDeLasCasas", "Santiago", "Salvador", "Tatui",
                                       "Johannesburg", "Nairobi", "Perth",
                                       "TelAvivColony"))

# Converts DF from wide into long ~
PopGenUp <- gather(PopGen, Estimate, Value, "Nucleotide_Diversity", "Watson_Theta", "Tajima_D")


# Includes data ID column ~
PopGenUp$ID <- factor(paste("PopGen"))
HetsUp$ID <- factor(paste("Hets"))

setdiff(colnames(PopGenUp),colnames(HetsUp))
setdiff(colnames(HetsUp),colnames(PopGenUp))

PopGenUp$Sample_ID <- NA
PopGenUp$Het <- NA
PopGenUp$DataType <- NA


HetsUp$NSites <- NA
HetsUp$Estimate <- NA
HetsUp$Value <- NA


## Reorders columns ~
intersect(colnames(PopGenUp), colnames(HetsUp))

PopGenUp <- PopGenUp[,c("Population","NSites","BioStatus","Estimate","Value","ID","Sample_ID","Het","DataType")]
HetsUp <- HetsUp[,c("Population","NSites","BioStatus","Estimate","Value","ID","Sample_ID","Het","DataType")]


## Bind the 2 DFs based on common columns (Population & BioStatus) ~
fulldf <- rbind(PopGenUp, HetsUp)

## Includes label for empty factor level (related to PHS)
idx <- which(fulldf$ID == "Hets")
fulldf[idx,"Estimate"] <- rep("PHS", length(idx))
fulldf$Estimate <- factor(fulldf$Estimate) #Set to factor for plotting


fulldf$Estimate <-
 factor(fulldf$Estimate, ordered = T, levels = c(
                                               "PHS",
                                               "Nucleotide_Diversity",
                                               "Tajima_D",
                                               "Watson_Theta"))

# Corrects the facet labels ~

ylable <- c(
          "Nucleotide_Diversity" = "Nucelotide Diversity",
          "Tajima_D"= "Tajima's D",
          "Watson_Theta" = "Watson's Theta",
          "PHS"= "Heterozygosity")

# Corrects the facet labels ~

levels(fulldf$Population)[c(1, 5, 6, 9, 23, 24, 25, 27, 34)] <- c(
                                                                 "Tórshavn",
                                                                 "Wadi Hidan",
                                                                 "Pigeon Island",
                                                                 "Guimarães",
                                                                 "Salt Lake City",
                                                                 "Tlaxcala de Xicohtencatl",
                                                                 "Mexico City",
                                                                 "San Cristobal de las Casas",
                                                                 "TelAvivColony")

# Creates the panel ~

PopGennEstimates <- 
ggplot() + 
  geom_point(data = subset(fulldf, ID =="PopGen"),
             aes(x = Population, y = Value, fill = BioStatus), colour = "black", shape = 21, size = 3.5, alpha = .9) +
  geom_boxplot(data = subset(fulldf, ID == "Hets"),
             aes(x = Population, y = Het, fill = BioStatus), outlier.size = 1.5, width = 0.3) +
  facet_grid(Estimate ~. , scales = "free", labeller = labeller(Estimate = ylable)) +
  scale_fill_manual(values = c("#56B4E9", "#E69F00", "#44AA99", "#F0E442"),
                    labels = gsub("_", " ", fulldf$BioStatus)) +
  scale_colour_manual(values = c("#56B4E9", "#E69F00", "#44AA99", "#F0E442")) +
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
        strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = 0.3),
        strip.text = element_text(colour = "#000000", size = 12, face = "bold", family = "Georgia"),
        legend.position = "top",
        legend.title = element_blank(),
        legend.background =element_blank(),
        legend.key = element_rect(fill = NA))


# Saves the panel ~
ggsave(PopGennEstimates, file = "FPGP--PopGenEstimates.pdf", device = cairo_pdf, height = 8, width = 12, scale = 1.5, dpi = 1000)


#
##
### The END ~~~~