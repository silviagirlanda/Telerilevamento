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

a17_4 <- rast("17_4.tiff") #red
a17_3 <- rast("17_3.tiff") #green
a17_2 <- rast("17_2.tiff") #blue
a17_8 <- rast("17_8.tiff") #nir
a17 <- c(a17_4, a17_3, a17_2, a17_8)

a19_4 <- rast("19_4.tiff") #red
a19_3 <- rast("19_3.tiff") #green
a19_2 <- rast("19_2.tiff") #blue
a19_8 <- rast("19_8.tiff") #nir
a19 <- c(a19_4, a19_3, a19_2, a19_8)

a24_4 <- rast("24_4.tiff") #red
a24_3 <- rast("24_3.tiff") #green
a24_2 <- rast("24_2.tiff") #blue
a24_8 <- rast("24_8.tiff") #nir
a24 <- c(a24_4, a24_3, a24_2, a24_8)

#Creo un multiframe per visualizzare insieme le immagini grazie alla funzione par(), creando una griglia di 1 riga e 3 colonne e aggiungendo i titoli:

par(mfrow=c(1,3))
im.plotRGB(a17, 1,2,3,title="2017")
im.plotRGB(a19, 1,2,3,title="2019")
im.plotRGB(a24, 1,2,3,title="2024")

#Chiudo il device precedente:
dev.off()

### NDVI ###
# Calcolo l'NDVI (Normalized Difference Vegetation Index), utilizzato se le immagini hanno bit differenti ed è quindi necessaria una normalizzazione.
# NDVI = NIR-RED/NIR+RED

# Prima seleziono una scala di colori dal pacchetto viridis, inclusivo per le persone che soffrono di daltonismo.
cl<-colorRampPalette(viridis(7))(100)

NDVI_2017<-(a17[[4]]-a17[[1]])/(a17[[4]]+a17[[1]])
plot(NDVI_2017,col=cl)

NDVI_2019<-(a19[[4]]-a19[[1]])/(a19[[4]]+a19[[1]])
plot(NDVI_2019,col=cl)

NDVI_2024<-(a24[[4]]-a24[[1]])/(a24[[4]]+a24[[1]])
plot(NDVI_2024,col=cl)

# Creo un multiframe e plotto le immagini insieme:
par(mfrow=c(1,3))
plot(NDVI_2017,col=cl)
plot(NDVI_2019,col=cl)
plot(NDVI_2024,col=cl)

dev.off()

# Calcolo la differenza in termini di NDVI tra 2017 e 2019 (??????????????????????????):
NDVI_diff1<-NDVI_2017-NDVI_2019
plot(NDVI_diff1, col=cl)

# E tra 2019 e 2024:
NDVI_diff2<-NDVI_2019-NDVI_2024
plot(NDVI_diff2, col=cl)

##### Classifico in 2 classi:

NDVI_class1<-im.classify(NDVI_diff1, 2)
plot(NDVI_class1)

NDVI_class2<-im.classify(NDVI_diff2, 2)
plot(NDVI_class2)

par(mfrow=c(1,2))
plot(NDVI_class1)
plot(NDVI_class2)

##### Classifico in 2 classi e inserisco in un multiframe con la funzione par():
par(mfrow=c(1,3))
class2017 <- im.classify(a17, num_clusters=2)
class2019 <- im.classify(a19,num_clusters =2)
class2024 <- im.classify(a24,num_clusters=2)
