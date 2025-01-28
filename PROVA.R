#### FASE PRELIMINARE ####
#Installo i pacchetti necessari:
library(terra) # Per la funzione rast()
library(imageRy) # Per im.plotRGB() e im.classify()
library(viridis) # Per utilizzare colorRampPalette adatte a chi soffre di deuteranomalia (daltonismo)
library(ggplot2) # Per la creazione dei boxplot
library(patchwork) # Per visualizzare i boxplot insieme


# Imposto la cartella di lavoro, dove sono state posizionate le immagini relative alla zona di Predazzo e vicina alla Foresta di Paneveggio (avendo cura di sostiuire i backslash con gli slash).
# Il seguente codice ha l'obiettivo di evidenziare i cambiamenti nei termini di copertura forestale a seguito della tempesta Vaia del 2018 e della conseguente diffusione epidemica del bostrico (Ips typographus),
# mettendo a confronto l'estate del 2017 (pre Vaia), l'estate del 2019 (post Vaia) e l'estate del 2024. L'area analizzata ricopre circa 93 km2.
setwd("C:/Telerilevamento") #posizionata vicino alla sorgente del computer per facilitare i percorsi

# Le immagini sono state catturate da Sentil-2 e scaricate liberamente da Copernicus Browser, sottoforma di file TIFF-16bit, selezionando le bande del:
# - blu (b2);
# - verde(b3);
# - rosso(b4);
# - infrarosso(b8).

# Per ogni anno d'analisi, creo uno stack comprendente tutte le bande, assegnate precedentemente ad un oggetto. 

a17_2 <- rast("17_2.tiff")
a17_3 <- rast("17_3.tiff")
a17_4 <- rast("17_4.tiff")
a17_8 <- rast("17_8.tiff")
a17 <- c(a17_2, a17_3, a17_4, a17_8)

a19_2 <- rast("19_2.tiff")
a19_3 <- rast("19_3.tiff")
a19_4 <- rast("19_4.tiff")
a19_8 <- rast("19_8.tiff")
a19 <- c(a19_2, a19_3, a19_4, a19_8)

a24_2 <- rast("24_2.tiff")
a24_3 <- rast("24_3.tiff")
a24_4 <- rast("24_4.tiff")
a24_8 <- rast("24_8.tiff")
a24 <- c(a24_2, a24_3, a24_4, a24_8)

### CALCOLO NDVI ###


