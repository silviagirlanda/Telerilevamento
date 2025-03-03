####---------------------------------------------------30 aprile 2024
# MISURA DELLA VARIABILITA': a partire da un'immagine, si possono misurare i valori di riflettanza per ogni pixel. 
# Vedendo come riflette ogni pixel per le bande si forma una grafico: più i punti sono simili, più la nuvola sarà compatta.
# Maggiore è la variabilità in termini spettrali maggiore sarà la variabilità a livello ambientale e quindi saranno presenti più nicchie ecologiche e più specie.
# Si può applicare la stessa variabilità per la geomorfologia. Questo grazie alla deviazione standard: presa una curva normale, la ds sarà il 68% dei dati. 
# Maggiore è la deviazione standard, maggiore sarà la variabilità ecosistemica/geomorfologica.

#Riprendiamo i soliti pacchetti:
library(imageRy) #da qui estrarremo il dato da utilizzare
library(terra)

#install.packages("viridis") -> vedi più giù
library(viridis) # "viridis" consente la visibilità a tutti, compresi i daltonici

#Visualizziamo le liste dei dati:
im.list()

#Importiamo un'immagine del Satellite Sentinel, con una risoluzione di 10m, e rinominiamola
sent <- im.import ("sentinel.png")

#Plottiamo:
im.plotRGB(sent, r=1, g=2, b=3) #vegetazione è rossa; suolo nudo è celeste; acqua è nera perchè assorbe infrarosso
# nir = banda 1
# rosso = banda 2
# verde = banda 3

im.plotRGB(sent, r=2, g=1, b=3) 
# rosso = banda 1
# nir = banda 2
# verde = banda 3

#Proviamo a valutare la VARIABILITÀ, con il metodo "Moving Window", usando una finestra esterna di calcolo della dev standard di cui sceglieremo la dimensione in pixel, solitamente 3 x 3 pixel.
#La dev standard lavora su un'unica variabile, quindi dobbiamo scegliere un'unica banda, quella dell'infrarosso. Si calcola la deviazione standard di ogni pixel e la si riporta sul pixel centrale
#Così facendo si ottiene una mappa completa con tutte le deviazioni standard degli intervalli dati dalla grandezza della moving window. 

#Associamo la prima banda dell'immagine satellitare all'oggetto "nir"
nir <- sent[[1]]

#Plottiamola:
plot(nir)

#Modifichiamo i colori:
cl <- colorRampPalette(c("red","orange","yellow"))(100) #3 colori in 100 sfumature

#Plottiamo con i nuovi colori:
plot(nir, col=cl)

#Useremo la nuova funzione "focal" che permette di estarre valori focali, ossia statistiche, in un gruppo di valori: qui la dev standard.
focal(nir, matrix (1/9, 3, 3), fun=sd)
# nir è l'immagine usata
# matrix: è una matrice ossia il secondo argomento della funzione focal(). 1/9 perchè useremo un unico pixel su 9, la matrice è di 3 x 3 pixel. È l'unità di misura. 
# numero di pixel per colonna e per riga;
# funzione usata è "standard deviation" N.B. non nominare con sd perchè corrisponde al nome della funzione

#Rinominiamo l'oggetto:
sd3 <- focal(nir, matrix (1/9, 3, 3), fun=sd)

#Plottiamola:
plot(sd3)

#Modifichiamo i colori usando "viridis", un pacchetto di colori adatto anche a coloro che hanno problemi di daltonismo.Installiamolo. 
install.packages("viridis")
#Riprendiamolo:
#library(viridis)

#Usiamo nuovamente colorRampPalette ma usando "viridis", un pacchetto di colori che già esiste, e rinominiamolo:
viridisc <- colorRampPalette(viridis(7))(100)
#il 7 indica che è la settima palette in un pacchetto di palette

#Plottiamolo:
plot(sd3, col=viridisc)
#alta variabilità a livello morfologico nelle zone di passaggio tra neve e non neve
# la variabilità viene indicata con la differenza di colore: dove è stato rimarcato il giallo vi è maggiore variabilità. Vengono risaltati molto di più i bordi.
# più è piccola la finestra, maggiore sarà la misura di dettaglio della deviazione standard. 

###Calcola la sd di una moving window di 7 x 7 pixel:
sd7 <- focal(nir, matrix (1/49, 7, 7), fun=sd)

#Plottiamolo:
plot(sd7,col=viridisc)
#essendoci più pixel nel calcolo, la ds risulta più alta in zone più ampie. Il valore massimo è inferiore a quello di prima perchè abbiamo più pixel simili, quindi minor sqm.

###Calcola la sd di una moving window di 13 x 13 pixel:
sd13 <- focal(nir, matrix (1/169, 13, 13), fun=sd)

#Facciamo uno stack delle 3 immagini delle sd:
sdstack <- c(sd3, sd7, sd13)

#Plottiamo:
plot(sdstack, col=viridisc)

# La banda che più viene scelta per eseguire questi calcoli è quella del NIR perché è più discriminante. Se non ci fosse il nir, allora si potrebbe ovviare
# con le componenti principali, delle quali la prima componente comprenderà la più ampia variabilità. Essendo le bande originali molto correlate tra loro si 
# esegue l'analisi delle componenti principali così da avere la componente con la più alta variabilità. 
####-----
#Introduzione a prossima lezione. 
#Per vedere la correlazione:
pairs(sent)
