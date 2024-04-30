####30 aprile 2024

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
#La dev standard lavora su un'unica variabile, quindi dobbiamo scegliere un'unica banda, quella dell'infrarosso.

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
# matrix: 1/9 perchè useremo un unico pixel su 9, la matrice è di 3 x 3.
# funzione usata è "standard deviation" N.B. non nominare con sd perchè corrisponde al nome della funzione

#Rinominiamo l'oggetto:
sd3 <- focal(nir, matrix (1/9, 3, 3), fun=sd)

#Plottiamola:
plot(sd3)

#Modifichiamo i colori usando "viridis", un pacchetto di colori adatto anche a coloro che hanno problemi di daltonismo.Installiamolo. 
install.packages("viridis")
#Riprendiamolo:
#library(viridis)

#Usiamo nuovamente colorRampPalette ma usando "viridis", un pacchetto di colori che già esiste:
viridisc <- colorRampPalette(viridis(7))(100)
#il 7 indica che è la settima palette in un pacchetto di palette

#Plottiamolo:
plot(sd3, col=viridisc)





      



