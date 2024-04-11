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
g2000 <- im.import("greenland.2000.tif")

#Plottiamola, scegliendo una palette:
clg<-colorRampPalette(c("black","blue","white","red")) (100) #nero sono T più basse, rosso T più alte
plot(g2000,col=clg) #la parte nera, ossia più fredda, è quella più interna

#Importiamo anche le altre immagini degli anni successivi:
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

#Creiamo un multiframe con 2 immagini, in 1 riga e 2 colonna:
par(mfrow=c(1,2))
plot(g2000, col=clg)
plot(g2015, col=clg)

#Creiamo un multiframe con tutte le 4 immagini, in 2 righe e 2 colonne:
par(mfrow=c(2,2))
plot(g2000, col=clg)
plot(g2005, col=clg)
plot(g2010, col=clg)
plot(g2015, col=clg)

#Per facilitare il tutto, posso fare uno stack e assegnarlo all'oggetto "greenland":
greenland <-c(g2000, g2005, g2010, g2015)
plot(greenland,col=clg)

#Faccio la differenza tra primo e quarto livello:
difg = greenland[[1]] - greenland [[4]]

#Plottiamo:
plot(difg, colo=cl)
