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

#vogliamo plottare i dati
plot(mato)

#proviamo con un'immagine composta da una singola banda, il procedeimento è lo stesso
im.import("sentinel.dolomites.b2.tif")
b2<-im.import("sentinel.dolomites.b2.tif")

#per cambiare i colori dell'immagine, inserendo tra parentesi quelli che vogliamo
colorRampPalette(c("black","gray","light grey"))(3) 
#il c serve per concatenare tutti i diversi elementi di un array; il 3 indica i livelli di colore, ossia 3 sfumature

clg<-colorRampPalette(c("black","gray","light grey"))(3)
#uniamo tutto
plot(b2,col=clg)
#possiamo aumentare i numeri di sfumature
clg<-colorRampPalette(c("black","gray","light grey"))(100)
#cambiamo colori
clcyan<-colorRampPalette(c("magenta","cyan4","cyan"))(100)
clch<-colorRampPalette(c("magenta","cyan4","cyan","chartreuse"))(100) 
plot(b2,col=clch)

#importiamo anche le altre bande
im.import("sentinel.dolomites.b3.tif")
b3<-im.import("sentinel.dolomites.b3.tif") #verde
plot(b3,col=clch)

b4<-im.import("sentinel.dolomites.b4.tif") #rosso
plot(b4,col=clch)

b8<-im.import("sentinel.dolomites.b8.tif") #infrarosso
plot(b8,col=clch)

#Creiamo un multiframe con la seguente funzione:
par(mf) #mf sta per multiframe
par(mfrow=c(2,2)) #il primo valore indica il numero di righe, il secondo il numero dicolonne. Sono un array quindi vanno concatenati con c
#è stato così creato un telaio in cui andranno inserite le bande. Inseriamo quindi le bande. 
par(mfrow=c(2,2))
plot(b2,col=clch)
plot(b3,col=clch)
plot(b4,col=clch)
plot(b8,col=clch) #mi raccomando copia e incolla tutto il blocco

#Esercizio: prova a metterli in una singola riga
par(mfrow=c(1,4))
plot(b2,col=clch)
plot(b3,col=clch)
plot(b4,col=clch)
plot(b8,col=clch)

#Imipiliamo le bande tutte insieme, per crare un immagine satellitare vera e propria.
stacksent<-c(b2,b3,b4,b8) #creo un array con le diverse bande
plot(stacksent,col=clch)

#Vogliamo plottare solo la banda 8. In R i singoli elementi si selezionano con le [].
plot(stacksent[[4]],col=clch) #per lavorare su un singolo elemento di un vettore. Le quadre sono doppie perchè abbiamo una matrice.

#Per distruggere il device precedente:
dev.off()
