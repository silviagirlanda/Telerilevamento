#### FASE PRELIMINARE ####
{"type":"Polygon","coordinates":[[[11.587418,46.262112],[11.587418,46.331832],[11.742943,46.331832],[11.742943,46.262112],[11.587418,46.262112]]]}
#Installo i pacchetti necessari dal CRAN con la funzione install.packages(), il pacchetto va inserito tra virgolette:
# install.packages("terra")
# install.packages("ggplot2")
# install.packages("patchwork")
# install.packages("viridis")

# Per quanto riguarda imageRy, pacchetto esterno al CRAN e disponibile su GitHub, installo prima la funzione devtools() del CRAN:
# install.packages("devtools") 
# library(devtools)
# devtools::install_github("duccioroccchini/imageRy") #i due punti ripetuti indicano che install_github è funzione del pacchetto devtools

# Richiamo i pacchetti necessari, senza la necessità di usare le virgolette in quanto già presenti in R:
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

#Alla fine ho cambiato immagine perchè quezta mi dava problemi con NDVI classificazione:
#a17_4 <- rast("17_4.tiff") #red
#a17_3 <- rast("17_3.tiff") #green
#a17_2 <- rast("17_2.tiff") #blue
a#17_8 <- rast("17_8.tiff") #nir
#a17 <- c(a17_4, a17_3, a17_2, a17_8)

a17_4 <- rast("17b_4.tiff") #red
a17_3 <- rast("17b_3.tiff") #green
a17_2 <- rast("17b_2.tiff") #blue
a17_8 <- rast("17b_8.tiff") #nir
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

#Creo un multiframe per visualizzare insieme le immagini in true color grazie alla funzione par(), creando una griglia di 1 riga e 3 colonne e aggiungendo i titoli:

par(mfrow=c(1,3))
im.plotRGB(a17, 1,2,3,title="2017")
im.plotRGB(a19, 1,2,3,title="2019")
im.plotRGB(a24, 1,2,3,title="2024")

#Sostitusico il filtro rosso con la componente infrarossa per evidenziare il verde, ossia la copertura forestale: tutto quello che riflette infrarosso diventerà rosso
par(mfrow=c(1,3))
im.plotRGB(a17, 4,3,2,title="2017 (nir)")
im.plotRGB(a19, 4,3,2,title="2019 (nir)")
im.plotRGB(a24, 4,3,2,title="2024 (nir)")
##############àQUI SI METTONO IN ORDINE COSì PERCHè SI FA COSì E BOONE?

#Multiframe confronto tra tc e nir
par(mfrow=c(2,3))
im.plotRGB(a17, 1,2,3,title="2017")
im.plotRGB(a19, 1,2,3,title="2019")
im.plotRGB(a24, 1,2,3,title="2024")
im.plotRGB(a17, 4,3,2,title="2017 (nir)")
im.plotRGB(a19, 4,3,2,title="2019 (nir)")
im.plotRGB(a24, 4,3,2,title="2024 (nir)")


#Chiudo il device precedente:
dev.off()

##### DVI ###### ELIMINALOOOOOOOOOOOOOO POIIIIIIII
# Calcolo della DVI
cl<-colorRampPalette(viridis(7))(100)
no<-colorRampPalette(c("darkblue","yellow","red","black"))(100)
DVI_2017<-a17[[4]]-a17[[1]]
plot(DVI_2017,col=cl)

DVI_2019<-a19[[4]]-a19[[1]]
plot(DVI_2019,col=cl)

DVI_2024<-a24[[4]]-a24[[1]]
plot(DVI_2024,col=cl)

##### NDVI #####
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
#il range non è in funzione della radiazione radiometrica ma è un valore adimensionale che va da -1 a 1.

dev.off()
#-----------------------
# Calcolo la differenza in termini di NDVI tra 2017 e 2019 (??????????????????????????):
NDVI_diff1<-NDVI_2017-NDVI_2019
plot(NDVI_diff1, col=cl)

# E tra 2019 e 2024:
NDVI_diff2<-NDVI_2019-NDVI_2024
plot(NDVI_diff2, col=cl)

##### CLASSIFICAZIONE in 2 classi:
#___________________________________________________________________________________???????????????????????????????
NDVI_class1<-im.classify(NDVI_diff1,num_clusters = 2)
plot(NDVI_class1)

NDVI_class2<-im.classify(NDVI_diff2, 2)
plot(NDVI_class2)

par(mfrow=c(1,2))
plot(NDVI_class1)
plot(NDVI_class2)
#____________________________??????????????????????????
##### Classifico in 2 classi (è giusto il numero di 2 classi o sarebbe meglio 3????): 
#classe 1 = foresta abbattuta da Vaia o colpita da bostrico, insiedamenti urbani
#classe 2 = foresta sana e rigogliosa

class17 <- im.classify(a17,num_clusters = 2)
plot(class17)

class19 <- im.classify(a19,num_clusters = 2)
plot(class19)

class24 <- im.classify(a24,num_clusters = 2)
plot(class24)

#Ora vogliamo quantificare le FREQUENZE, ossia il numero di pixel in ogni classe: 
f17<-freq(class17) #se richiamo l'oggetto, vedrò la quantità di pixel per ogni classe

#Ora facciamo una proporzione tra il numero di pixel di una classe (CHE CLASSE??????) e il totale.
tot17<-ncell(class17) #per conoscere il totale dei pixel:
prop17 = f17 / tot17 #proporzione
perc17 = prop17 * 100 #percentuali: classe 1 = 60.57%  classe 2 = 39.43%

f19 <- freq(class19) 
tot19<-ncell(class19) #per conoscere il totale dei pixel:
prop19 = f19 / tot19 #proporzione
perc19 = prop19 * 100 #percentuali: classe 1 = 63.19%  classe 2 = 36.81%

f24 <- freq(class24) 
tot24<-ncell(class24) #per conoscere il totale dei pixel:
prop24 = f24 / tot24 #proporzione
perc24 = prop24 * 100 #percentuali: classe 1 = 56.15%  classe 2 = 43.85%

#########non sono per niente convinta
########quindi
### ##### Classifico in 3 classi: 
#classe 1 =
#classe 2 =
#classe 3 =

class_17 <- im.classify(a17,num_clusters = 3)
plot(class_17)

class_19 <- im.classify(a19,num_clusters = 3)
plot(class_19)

class_24 <- im.classify(a24,num_clusters = 3)
plot(class_24)

######## Classifico con NDVI
# classe 1 = uomo/neve/ghiaccio
# classe 2 = foresta/bosco
# classe 3 = prati/no bosco

c_ndvi17 <- im.classify(NDVI_2017,num_clusters = 3)
plot(c_ndvi17)

c_ndvi19 <- im.classify(NDVI_2019,num_clusters = 3)
plot(c_ndvi19)

c_ndvi24 <- im.classify(NDVI_2024,num_clusters = 3)
plot(c_ndvi24)

#Ora proviamo a calcolare le FREQUENZE (classe 2 dovrebbe essere quella delle foreste):

####ndvi2017
f_17 <- freq(c_ndvi17) 
tot_17<-ncell(c_ndvi17) #per conoscere il totale dei pixel:
prop_17 = f_17 / tot_17 #proporzione
perc_17 = prop_17 * 100 #percentuali: classe 1 = 9%  classe 2 = 76.1% classe 3 = 14.9%

####ndvi2019
f_19 <- freq(c_ndvi19) 
tot_19<-ncell(c_ndvi19) #per conoscere il totale dei pixel:
prop_19 = f_19 / tot_19 #proporzione
perc_19 = prop_19 * 100 #percentuali: classe 1 = 6.3%  classe 2 = 75.3% classe 3 = 18.4%

####ndvi2024
f_24 <- freq(c_ndvi24) 
tot_24<-ncell(c_ndvi24) #per conoscere il totale dei pixel:
prop_24 = f_24 / tot_24 #proporzione
perc_24 = prop_24 * 100 #percentuali: classe 1 = 7.5%  classe 2 = 70.6% classe 3 = 21.9%

#Ottenuti i dati, costruiamo un DATASET, con la funzione data.frame che ci consente di creare delle tabelle:
class <- c("bosco","uomo/neve/ghiaccio","no bosco")
y2017 <- c(76.1,9,14.9)
y2019 <- c(75.3,6.3,18.4)
y2024 <- c(70.6,7.5,21.9)

tabout <- data.frame(class, y2017, y2019, y2024)

#Per vedere la tabella (attenzione che è case sensitive!):
View(tabout)

#Realizzo i grafici per i singoli anni:
ggplot(tabout, aes(x=class, y=y2017, color=class)) + geom_bar(stat="identity",fill="white")
ggplot(tabout, aes(x=class, y=y2019, color=class)) + geom_bar(stat="identity",fill="white")
ggplot(tabout, aes(x=class, y=y2024, color=class)) + geom_bar(stat="identity",fill="white")

#Per aggiustare questo, diamo un intervallo di valori per la y con la funzione ylim:
p1<-ggplot(tabout, aes(x=class, y=y2017, color=class)) + geom_bar(stat="identity",fill="white") + ylim(c(0,100))
p2<-ggplot(tabout, aes(x=class, y=y2019, color=class)) + geom_bar(stat="identity",fill="white") + ylim(c(0,100))
p3<-ggplot(tabout, aes(x=class, y=y2024, color=class)) + geom_bar(stat="identity",fill="white") + ylim(c(0,100))

p1 + p2 + p3 #Per vedere il confronto
#####################################################
##Altro DATASET:
anno <- c("2017","2019","2024")
bosco <- c(76.1,75.3,70.6)
no_bosco <- c(14.9,18.4,21.9)
altro <- c(9,6.3,7.5)

tabout2 <- data.frame(anno, bosco, no_bosco, altro)

p1<-ggplot(tabout2, aes(x=anno, y=bosco, color=class)) + geom_bar(stat="identity",fill="white") + ylim(c(0,100))
p2<-ggplot(tabout2, aes(x=anno, y=no_bosco, color=class)) + geom_bar(stat="identity",fill="white") + ylim(c(0,100))
p3<-ggplot(tabout2, aes(x=anno, y=altro, color=class)) + geom_bar(stat="identity",fill="white") + ylim(c(0,100))


