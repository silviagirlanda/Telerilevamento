#--------9 aprile 2024
#Si parte da un'immagine satellitare, la importiamo, la classfichiamo e poi creereamo dei grafici. 

#Quantifying land cover variability

#Installiamo dei pacchetti necessari (ggplot2)
install.packages("ggplot2")
install.packages("patchwork")
#Richiamiamolo con:
library(ggplot2)

#Richiamiamo anche gli altri pacchetti:
library(terra)
library(imageRy)
library(patchwork)

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

#Per avere conferma:
plot(m1992c)
#classe 1 = suolo nudo
#classe 2 = foresta

plot(m2006c)
#classe 1 = suolo nudo
#classe 2 = foresta

#Ora vogliamo quantificare le frequenze, ossia il numero di pixel in ogni classe: 

#1992

f1992<-freq(m1992c)
#Richiama l'oggetto:
f1992 #qui visualizzerai il numero di pixel per ogni classe

#Ora facciamo una proporzione tra il numero di pixel di una classe e il totale.
#Per conoscere il totale dei pixel:
tot1992<-ncell(m1992c)

#La proporzione risulterà quindi:
prop1992 = f1992 / tot1992 #c'è l'uguale perchè è un'operazione matematica
#La percentuale risulterà:
perc1992 = prop1992 * 100

#Appuntiamo i dati ottenuti:
#percentuali: foresta = 83%, suolo nudo = 17%

#2006

#Ora ripetiamo lo stesso per il 2006:
f2006<-freq(m2006c)
#Richiama l'oggetto:
f2006 

#Ora facciamo una proporzione tra il numero di pixel di una classe e il totale.
#Per conoscere il totale dei pixel:
tot2006<-ncell(m2006c)

#La proporzione risulterà quindi:
prop2006 = f2006 / tot2006 
#La percentuale risulterà:
perc2006 = prop2006 * 100

#Appuntiamo i dati ottenuti:
#percentuali: foresta = 45%, suolo nudo = 55%

#Ottenuti i dati, costruiamo un dataset, con la funzione data.frame che ci consente di creare delle tabelle:
class <- c("forest","human")
y1992 <- c(83,17)
y2006 <- c(45,55)

tabout <- data.frame(class, y1992, y2006)
#Richiama l'oggetto:
tabout

#Per vedere la tabella:
view(tabout)

#Ora facciamo il grafico:
ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity",fill="white")
#aes ossia aestethic: attribuiamo i nostri assi e i colori classificati. 
#con il + aggiungiamo un tipo di geometria ossia le barre dell'istogramma: con identity usiamo il valore così com'è

#Ripetiamo lo stesso per il 2006:
ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity",fill="white")

#Ora mettiamo insieme i grafici ottenuti.
#Installiamo un pacchetto "patchwork" e richiama il pacchetto.

#Assegniamo a p1 e p2 i ggplot:
p1<-ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity",fill="white")
p2<-ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity",fill="white")

p1 + p2 #Così visualizzerai i due grafici affiancati: ma la scala dei due grafici è diversa. 

#Per aggiustare questo, diamo un intervallo di valori per la y con la funzione ylim:
p1<-ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity",fill="white") + ylim(c(0,100))
p2<-ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity",fill="white") + ylim(c(0,100))

p1 + p2 #Ora si vede giusto il confronto tra 1992 e 2006.
