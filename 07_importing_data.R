###23 aprile 2024
# Importing data from external sources

#Riprendiamo i seguenti pacchetti:
library(terra)
library(imageRy)

#Con la seguente funzione, spieghiamo al sistema qual è la cartella del nostro pc che useremo per caricare i dati, indicandola tra le parentesi:
setwd("/Users/silviagirlanda/Downloads") #set working directory
#assicurati di usare lo slash e non il backslash

#Questa funzione serve a crerae degli oggetti raster spaziali:
eclissi<-rast("eclissi.png") #lo assegno all'oggetto eclissi
