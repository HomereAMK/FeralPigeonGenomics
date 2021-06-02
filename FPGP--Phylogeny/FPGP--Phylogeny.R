### The BEGINNING ~~~~
##
# > Plots FPGP--Phylogeny | By George PACHECO


# Sets working directory:

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Loads required packages:

pacman::p_load(ggtree, ggplot2, ggrepel, extrafont, treeio)

# Imports extra fonts:

loadfonts(device = "win", quiet = TRUE)

# Reads data:

ggtree(Tree) + geom_nodelab(aes(label = label))
ggtree(Tree) + geom_nodelab(aes(label = label), subset = as.numeric(label) > 90)

Tree_New <- read.newick("FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.FINAL.raxml.support",
                       node.label = 'support', root.position = )

Tree <- read.tree(file = "FPGP--GoodSamples_NoSrisoriaNoCpalumbus--Article--Ultra.FINAL.raxml.support")
ggtree(Tree, layout="circular") +
geom_rootpoint() +
geom_tiplab(align = TRUE, linesize = .5) +
geom_label_repel(aes(label = bootstrap, fill = bootstrap)) +
  theme(panel.background = element_rect(fill = '#FAFAFA'),
        panel.grid.minor.x = element_blank(),
        legend.position = "none",
        panel.grid.major = element_blank(),
        plot.title = element_blank(),
        axis.title = element_blank(),
        axis.text.x = element_text(colour = "#000000", size = 6, angle = 90, vjust = 0.5, hjust = 1),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        strip.text.x = element_text(colour = "#000000", face = "bold", size = 7, angle = 270, margin = margin(0.1, 0, 0.1, 0, "cm")),
        strip.text.y = element_text(colour = "#000000", face = "bold", size = 7, angle = 270, margin = margin(0, 0.1, 0, 0.1, "cm")))



ggsave(file = "FPGP--Phylogeny.pdf", device = cairo_pdf, width = 20, height = 20, dpi = 1000)
geom_tiplab()

?ggtree

?reroot

#geom_nodelab(aes(label = label)) +
#geom_text(aes(label=node), hjust=-.3)


raxml_file <- system.file("extdata/RAxML", "", package = "treeio")
read.raxml(raxml_file)
raxml



