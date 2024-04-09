#--------9 aprile 2024
#Si parte da un'immagine satellitare, la importiamo, la classfichiamo e poi creereamo dei grafici. 

#Quantifying land cover variability

#Installiamo dei pacchetti necessari (ggplot2)
install.packages("ggplot2")
#Richiamiamolo con:
library(ggplot2)

#Richiamiamo anche gli altri pacchetti:
library(terra)
library(imageRy)

#Lista di immagini:
im.list()

#Importiamo, anche, l'immagine del sole:
sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #nero livello energetico più basso, giallo livello energetico più alto

#Classifichiamo i dievrsi livelli eneergetici del sole:
sunc<-im.classify(sun,num_clusters = 3) # tra parentesi c'è nome immagine e numero di clusters che vogliamo

#Importiamo l'immagine del Matogrosso 1992 e rinominiamola:
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")

#Importiamo l'immagine del Matogrosso 2006 e rinominiamola:
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

#Classifichiamo l'immagine del Matogrosso del 1992:
m1992c<-im.classify(m1992,num_clusters=2)
#classe 1 = suolo nudo
#classe 2 = foresta

#Classifichiamo l'immagine del Matogrosso del 2006:
m2006c<-im.classify(m2006,num_clusters=2)
#classe 1 = suolo nudo
#classe 2 = foresta

#Ora vogliamo quantificare le frequenze:
