#Abbiamo 2 metodi per installare pacchetti: 
# - pacchetti da CRAN ( controllati da sviluppatori di R)> install.packages()
# - pacchetti esterni dal CRAN, come "imageRy" che si trova su GitHub > install_github MA per usare questa dobbiamo usare un'altra funzione, che è devtools(che è su CRAN)

#Installa pacchetto "Terra" con la funzione install.packages
install.packages("terra") #ricorda le virgolette
#Per verificare che il pacchetto sia stato installato, richiamalo con la funzione library
library(terra) #visualizzerai la versione del pacchetto installato, qui: terra 1.7.71

#Installa la funzione devtools dal CRAN per poi poter usare imageRy
install.packages("devtools") #ricordati sempre le virgolette
#Per verificare che il pacchetto sia stato installato, richiamalo con la funzione library
library(devtools)

#Installa la repository imageRy da github
install_github("ducciorocchini/imageRy")
#Per verificare che il pacchetto sia stato installato, richiamalo con la funzione library
library(imageRy) 

#RIASSUMENDO  devtools::install_github  

#Per rimuovere pacchetti: 
remove.packages()
