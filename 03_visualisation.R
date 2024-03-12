#Satellite data visualization in R by imageRy

#Richiamiamo i pacchetti utilizzati
library(terra)
library(imageRy)

#list of available data in imageRy
im.list()

#per importare i dati dal pacchetto
im.import("matogrosso_ast_2006209_lrg.jpg")
#assegniamo all'oggetto mato tutto quello scritto sopra per facilitare
mato<-im.import("matogrosso_ast_2006209_lrg.jpg") #così visualizzerai l'immagine
