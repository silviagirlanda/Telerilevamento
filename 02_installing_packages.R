#Installiamo pacchetto "Terra" con la funzione install.packages
install.packages("terra") #mi raccomando ricordati le virgolette

#per verificare che il pacchetto sia stato installato deve essere richiamato com la funzione library
library("terra") #visualizzere la versione del pacchetto installato, qui: terra 1.7.71

#su R abbiamo due errori: warning(bone fa lo stesso) o error(è un problema)
#per rimuovere pacchetti: remove.packages()

#Abbiamo 2 metodi per installare pacchetti: 
# - cran (pacchetti controllati da sviuluppatori di R)> install.packages()
# - pacchetti esterni da CRAN, come "imagery" che si trova su GitHub > install.github MA per usare questa dobbiamo usare un'altra funzione, che è devtools(che è su CRAN)
