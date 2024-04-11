#--------------------11 APRILE 2024
#Secondo metodo di classficare i cambiamenti nel tempo (SCRIVITI APPUNTI DI ANIS DA IMMMAGINE) 

#Riprendiamo i precedenti pacchetti:
library(terra)
library(imageRy)

#Richiamiamo la lista dei dati:
im.list()

EN01<-im.import("EN_01.png") 
EN13<-im.import("EN_13.png")

par(mfrow=c(1,2))
im.plotRGB.auto(EN01) #
im.plotRGB.auto(EN13)
par(mfrow=c(2,1))
im.plotRGB.auto(EN01) #nuova funzione che prende in automatico le prime 3 bande (vedi manuale di imageRy)
im.plotRGB.auto(EN13)

difEN = EN01[[1]] - EN13[[1]] #Sottrazione tra pixel del primo livello di EN01 e pixel del primo livello di EN13. C'è l'uguale perchè si tratta di un'operazione matematica.
cl <- colorRampPalette(c("blue","white","red")) (100) #blu è valore minimo, rosso è valore massimo

#Plottiamo:
plot(difEN, col=cl)
