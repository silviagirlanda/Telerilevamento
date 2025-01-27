###------------------------------------------------------23 aprile 2024
# Importing data from external sources

#Riprendiamo i seguenti pacchetti:
library(terra)
library(imageRy)

#Con la seguente funzione, spieghiamo al sistema qual è la cartella del nostro pc che useremo per caricare i dati, indicandola tra le parentesi:
setwd("/Users/silviagirlanda/Downloads") #set working directory
#assicurati di usare lo slash e non il backslash!

#Questa funzione serve a crerae degli oggetti raster spaziali. Importiamo l'immagine con la funzione rast.
eclissi<-rast("eclissi.png") #lo assegno all'oggetto eclissi

#Vediamo tutte le informazioni annesse all'immagine:
eclissi

#Ora plottiamo l'immagine con la solita funzione nota in imageRy:
im.plotRGB(eclissi,1,2,3) #la visualizziamo normalmente. È possibile invertire le bande. 

#Facciamo la differenza tra due bande, come già fatto con gli indici spettrali:
dif = eclissi [[1]] - eclissi [[2]]
plot(dif)

###Importiamo un'altra immagine, cercata sul sito di EarthObservatory:
forest<-rast("global_lcc_goodes.png")
#https://earthobservatory.nasa.gov/features/ForestCarbon

#Plottimola:
im.plotRGB(forest,1,2,3)

###Importiamo i dati da Copernicus:
soil<-rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc")

#Plottiamo:
plot(soil)

#Per plottare solo il primo livello:
plot(soil[[1]])

#Per ritagliare i dati:
ext <-c(25,30,55,58) # i primi 2 valori di coordinate defiscono x minima e x massima, i secondi due la y minima e la y massima
soilcrop <- crop (soil,ext)

#Plottiamo il nuovo ritaglio:
plot(soilcrop)



