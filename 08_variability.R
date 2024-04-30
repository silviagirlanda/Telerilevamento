####30 aprile 2024

#Riprendiamo i soliti pacchetti:
library(imageRy) #da qui estrarremo il dato da utilizzare
library(terra)

library(viridis)
#pacchetto viridis consente la visibilità a tutti, compresi i daltonici

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

#Proviamo a valutare la VARIABILITÀ, con il metodo "Moving Window", usando una finestra esterna di calcolo della dev standard di cui sceglieremo la dimensione in pixel.
#La dev standard lavora su un'unica variabile, quindi dobbiamo scegliere un'unica banda, quella dell'infrarosso.

#Associamo la prima banda dell'immagine satellitare all'oggetto "nir"
nir <- sent[[1]]

#Plottiamola:
plot(nir)

#Modifichiamo i colori:
cl <- colorRampPalette(c("red","orange","yellow"))(100) #3 colori in 100 sfumature

#Plottiamo con i nuovi colori:
plot(nir, col=cl)


