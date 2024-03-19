#Satellite data visualization in R by imageRy

#Richiamiamo i pacchetti utilizzati
library(terra)
library(imageRy)

#Lista di tutti i dati disponibili presenti nel pacchetto
im.list()

#Per importare i dati dal pacchetto
im.import("matogrosso_ast_2006209_lrg.jpg")
#Assegniamo all'oggetto mato tutto quello scritto sopra per facilitare
mato<-im.import("matogrosso_ast_2006209_lrg.jpg") #così visualizzerai l'immagine

#Provo a plottare i dati
plot(mato)

#Proviamo con un'immagine composta da una singola banda, il procedimento è lo stesso
im.import("sentinel.dolomites.b2.tif")
b2<-im.import("sentinel.dolomites.b2.tif")

#Per cambiare i colori dell'immagine, inserisci tra parentesi quelli che vuoi
colorRampPalette(c("black","gray","light grey"))(3) 
#il c serve per concatenare tutti i diversi elementi di un array; il 3 indica i livelli di colore, ossia 3 sfumature

#Assegniamolo ad un oggetto che si chiama clg
clg<-colorRampPalette(c("black","gray","light grey"))(3)
#uniamo tutto e plottiamo
plot(b2,col=clg)

#Possiamo aumentare i numeri di sfumature
clg<-colorRampPalette(c("black","gray","light grey"))(100)
#Proviamo a cambiare i colori
clcyan<-colorRampPalette(c("magenta","cyan4","cyan"))(100)
clch<-colorRampPalette(c("magenta","cyan4","cyan","chartreuse"))(100) 
plot(b2,col=clch)

#Importiamo anche le altre bande:
im.import("sentinel.dolomites.b3.tif")
b3<-im.import("sentinel.dolomites.b3.tif") #verde
plot(b3,col=clch)

b4<-im.import("sentinel.dolomites.b4.tif") #rosso
plot(b4,col=clch)

b8<-im.import("sentinel.dolomites.b8.tif") #infrarosso
plot(b8,col=clch)

#Creiamo un MULTIFRAME con la seguente funzione:
par(mf) #mf sta per multiframe
par(mfrow=c(2,2)) #il primo valore indica il numero di righe, il secondo il numero di colonne. Sono un array quindi vanno concatenati con c
#è stato così creato un telaio in cui andranno inserite le bande.
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

#Creiamo uno stack tramite la funzione c() per creare un'immagine satellitare MULTISPETTRALE, nominandolo a tuo piacimento.
stacksent<-c(b2,b3,b4,b8) #creo un array con le diverse bande e lo assegno all'oggetto stacksent
plot(stacksent,col=clch)#Creiamo il plot con le 4 bande

#Vogliamo plottare solo la banda 8. In R i singoli elementi si selezionano con le [].
plot(stacksent[[4]],col=clch) #per lavorare su un singolo elemento di un vettore. Le quadre sono doppie perchè abbiamo una matrice.

#Per distruggere il device precedente(di fatto chiude il grafico e basta):
dev.off()

#19 MARZO 2023------------------------------------------------------------
#RGB PLOTTING
#Questo stacksent è uguale all'elemento n.2 che corrisponde al blu e via via così

#stacksent[[1]] = b2 = blue
#stacksent[[2]] = b3 = green
#stacksent[[3]] = b4 = red
#stacksent[[4]] = b8 = nir infrared

im.plotRGB()
#Dichiaro nome immagine(qui stacksent) e dichiaro quali sono le tre compnenti che corrispondono ai 3 filtri
im.plotRGB(stacksent,r=3,g=2,b=1)
im.plotRGB(stacksent,3,2,1)
#Associamo il livello 1 al blu, il 2 al verde, il 3 al rosso -> otterrò un'immagine con i colori reali

#Per evidenziare il verde, sostituiamo il filtro rosso con la componente infrarossa: tutto quello che riflette infrarosso diventerà rosso
im.plotRGB(stacksent,4,2,1)

#Esercizio: fai par con due immagini una a lato dell'altra, una con i colori reali, l'altra con quelli infrarosso
par(mfrow=c(1,2))
im.plotRGB(stacksent,3,2,1)
im.plotRGB(stacksent,4,2,1)

#In realtà nel telerilevamento, si fa skippare tutto.
im.plotRGB(stacksent,4,3,2) #il risultato sarà uguale a quello nella riga 92, perchè comanda la banda meno correlata con le altre, qui l'infrarosso
#4:infrarosso; 3:rosso; 2:verde

#Verfichiamo con un par.
par(mfrow=c(1,3))
im.plotRGB(stacksent,3,2,1) #colori naturali
im.plotRGB(stacksent,4,2,1) #infrarosso mantenendo le altre due barre
im.plotRGB(stacksent,4,3,2) #infrarosso ma cambiando le altre bande

#Proviamo altre combinazioni.
im.plotRGB(stacksent,3,4,2) #infrarosso nel verde. Solitamente qui il suolo nudo diventa rosa.
im.plotRGB(stacksent,3,2,4) #infrarosso sul blu: per evidenziare suolo nudo che diventa giallo (colore che colpisce di più l'occhio umano)

#Esercizio: metti le quattro immagini insieme.
par(mfrow=c(1,4))
im.plotRGB(stacksent,3,2,1) #colori naturali
im.plotRGB(stacksent,4,2,1) #nir su rosso
im.plotRGB(stacksent,3,4,2) #nir su verde
im.plotRGB(stacksent,3,2,4) #nir su blu

#Nuova funzione: grande matrice con diversi grafici all'interno, tra cui indice di Pearson etc. 
pairs(stacksent)

#Per avere info su una certa immagine, come il numero dei pixel, etc. Scrivi nome dell'immagine.
b2
