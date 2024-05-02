##### 2 maggio 2024
#ANALISI MULTIVARIATA

#Recuperiamo i pacchetti:
library(terra)
library(imageRy)
library(viridis)

#Apriamo la lista di dati e usiamo le immagini delle dolomiti:
im.list()

#Importiamo i dati:
b2 <- im.import("sentinel.dolomites.b2.tif") #blu
b3 <- im.import("sentinel.dolomites.b3.tif") #verde
b4 <- im.import("sentinel.dolomites.b4.tif") #rosso
b8 <- im.import("sentinel.dolomites.b8.tif") #nir

#Creiamo uno stack, unendo le varie immagini:
sentdo<-c(b2, b3, b4, b8)

#Creiamo un plot:
im.plotRGB(sentdo, r=4, g=3, b=2)
#banda 4 montata su rosso, banda 3 su verde, banda 2 su blu

#Oppure:
im.plotRGB(sentdo, r=3, g=4, b=2)
#banda 3 montata su rosso, banda 4 su verde, banda 2 su blu

#Osserviamo quanto sono collegate tra di loro con la funzione "pairs", basato sulla matrice di Pearson:
pairs(sentdo)

