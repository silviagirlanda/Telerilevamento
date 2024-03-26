#Spectral indices

#Riprendiamo i pacchetti che ci servono:
library(terra)
library(imageRy)

#Vediamo la lista dei dati del pacchetto imageRy
im.list()

#Importiamo la seguente immagine del Matogrosso:
im.import("matogrosso_l5_1992219_lrg.jpg") #il nome del file è così perchè ha corrispondenza con il sito EarthObservatory o con Nasa Visible Earth

#Nominiamolo:
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")

#bande
#banda 1 = NIR
#banda 2 = rosso = R
#banda 3 = verde = G

#Plottiamo i dati
im.plotRGB(m1992, r=1, g=2, b=3) #vediamo foresta pluviale in rosso nel 1992: acqua non appare nera perchè è presente grande quantità di sedimento

#Mettiamo infrarosso (NIR) sul verde:
im.plotRGB(m1992, r=2, g=1, b=3) #le parti in rosa sono zone di suolo nudo, ossia distrutte dalla deforestazione

#Mettiamo NIR sul blu, per far si che risultino gialle (giallo è un colore che colpisce molto occhio umano) le zone più colpite
im.plotRGB(m1992, 2, 3, 1) #la geometria che appare in giallo è euclidea, quindi antropogenica
