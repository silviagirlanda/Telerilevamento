#Spectral indices

#Riprendiamo i pacchetti che ci servono:
library(terra)
library(imageRy)

#Vediamo la lista dei dati del pacchetto imageRy
im.list()

#Importiamo l'immagine del Matogrosso del 1992:
im.import("matogrosso_l5_1992219_lrg.jpg") #il nome del file è così perchè ha corrispondenza con il sito EarthObservatory o con Nasa Visible Earth

#Nominiamolo:
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")

#Bande
#banda 1 = infrarosso = NIR
#banda 2 = rosso = R
#banda 3 = verde = G

#Plottiamo i dati
im.plotRGB(m1992, r=1, g=2, b=3) #vediamo foresta pluviale in rosso nel 1992: acqua non appare nera perchè è presente grande quantità di sedimento

#Mettiamo infrarosso (NIR) sul verde:
im.plotRGB(m1992, r=2, g=1, b=3) #le parti in rosa sono zone di suolo nudo, ossia distrutte dalla deforestazione

#Mettiamo NIR sul blu, per far si che risultino gialle (giallo è un colore che colpisce molto occhio umano) le zone più colpite
im.plotRGB(m1992, 2, 3, 1) #la geometria che appare in giallo è euclidea, quindi antropogenica

#Importiamo l'immagine del Matogrosso del 2006:
im.import("matogrosso_ast_2006209_lrg.jpg")

#Nominiamola:
m2006<- im.import("matogrosso_ast_2006209_lrg.jpg")

#Facciamo un par tra 1992 e 2006, con una riga e due colonne:
par(mfrow=c(1,2))
im.plotRGB(m1992, 1, 2, 3) #si vede foresta rigoliosa
im.plotRGB(m2006, 1, 2, 3) #si vede foresta distrutta

#Cancelliamo:
dev.off()

#Mettiamo NIR su verde:
im.plotRGB(m2006, 2, 1, 3) #aumenta molto il rosa: soprattutto a sud, tutto è distrutto

#Mettiamo NIR su blu:
im.plotRGB(m2006, 2, 3, 1)

#Uniamo tutte le 6 immagini insieme, su 2 righe e 3 colonne:
par(mfrow=c(2,3))
im.plotRGB(m1992, 1, 2, 3) #1992 nir on red
im.plotRGB(m1992, 2, 1, 3) #1992 nir on green
im.plotRGB(m1992, 2, 3, 1) #1992 nir on blue
im.plotRGB(m2006, 1, 2, 3) #2006 nir on red
im.plotRGB(m2006, 2, 1, 3) #2006 nir on green
im.plotRGB(m2006, 2, 3, 1) #2006 nir on blue


#---------------------------------------------------4 aprile 2024
#Calcolo indice di vegetazione (DVI)
#Prendo ogni singolo pixel della banda e faccio la sottrazione tra NIR e R per ottenere DVI

#DVI1992

dvi1992 = m1992[[1]] - m1992[[2]] #dichiaro quale elemento voglio utilizzare, ossia il primo e secondo elemento di un'imm satellitare
#c'è = perchè si tratta di un'operazione matematica

# Funzione alternativa:
# dvi1992 = m1992$matogrosso~2219_lrg_1 - m1992$matogrosso~2219_lrg_2 :lego con il simbolo del $ la prima e seconda banda, troppo macchinoso

#Se invio il singolo elemento leggo tutte le informazioni ad esso annesse. 
dvi1992

#Plottiamo il DVI1992:
cl <-colorRampPalette(c("darkblue","yellow","red","black"))(100) #simile ai colori della rainbowcolor, ma qui ci sta bene
plot(dvi1992,col=cl)

#DVI2006

#Ripetiamo lo stesso per il DVI del 2006
#Importala e rinominala
m2006<- im.import("matogrosso_ast_2006209_lrg.jpg")
#Calcoliamo DVI2006:
dvi2006 = m2006[[1]] - m2006[[2]]

#Plottiamo il DVI2006:
cl <-colorRampPalette(c("darkblue","yellow","red","black"))(100) #giallo usato perchè è uno dei colori che colpisce maggiormente la retina
plot(dvi2006,col=cl)

#Esercizio: Plottiamo dvi1992 a lato di dvi2006
par(mfrow=c(1,2))
plot(dvi1992,col=cl)
plot(dvi2006,col=cl)
#range è in funzione della radiazione radiometrica

#NDVI (Normalized Difference Vegetation Index)
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])

#Plottiamo:
par(mfrow=c(1,2))
plot(ndvi1992,col=cl)
plot(ndvi2006,col=cl)
#il range NON è in funzione della radiazione radiometrica ma va da -1 a 1

#Nel pacchetto imageRy è presente una funzione speciale:
im.dvi #CONTROLLA
im.ndvi #CONTROLLA
