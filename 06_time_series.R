#--------------------11 APRILE 2024
###Secondo metodo di classficare i cambiamenti nel tempo

#Riprendiamo i precedenti pacchetti:
library(terra)
library(imageRy)

#Richiamiamo la lista dei dati:
im.list()

#Importiamo le immagini EN (European Nitrogen) di gennaio e marzo 2020 e attribuiamole a degli oggetti:
EN01<-im.import("EN_01.png") 
EN13<-im.import("EN_13.png")

#Creiamo un multiframe, con le immagini una sopra all'altra:
par(mfrow=c(2,1)) #2 righe e 1 colonna
im.plotRGB.auto(EN01) #nuova funzione che prende in automatico le prime 3 bande (vedi manuale di imageRy)
im.plotRGB.auto(EN13)


difEN = EN01[[1]] - EN13[[1]] #Sottrazione tra pixel del primo livello di EN01 e pixel del primo livello di EN13. C'è l'uguale perchè si tratta di un'operazione matematica.
cl <- colorRampPalette(c("blue","white","red")) (100) #scelgo la banda di colori: blu è valore minimo, rosso è valore massimo

#Plottiamo:
plot(difEN, col=cl)

###Scioglimento dei ghiacciai in Groenlandia

#Importiamo Groenlandia del 2000:
g2000<-im.import("greenland.2000.tif")

#Plottiamola, scegliendo una palette:
clg<-colorRampPalette(c("black","blue","white","red")) (100) #nero sono T più basse, rosso T più alte
plot(g2000,col=clg) #la parte nera, ossia più fredda, è quella più interna

