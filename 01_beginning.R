# First script R

#R come calcolatore
a<-5*2
b<-4*7

a+b
a*b
a-b
a/b

#Posso creare arrays con simbolo di assegnazione

flowers<-c(3,6,8,10,15,18)
flowers

bees<-c(10,16,25,42,61,73)
bees
#Posso mettere in relazione flowers con bees, ad es. facendo un grafico (primo elemento corrisponde a x, secondo a y)
plot(flowers,bees)

#Possiamo cambiare la forma del simbolo 
plot(flowers,bees,pch=19)

#Posso cambiare la dimensione del simbolo
plot(flowers,bees,pch=19,cex=2) # in questo caso raddoppio la dimensione
plot(flowers,bees,pch=19,cex=.5) #qui si dimezza la dimensione

#Posso cambiare il colore, ricordandosi di metterlo tra virgolette ""
plot(flowers,bees,pch=19,cex=.5,col="cyan3")

#Per salvare vai su "Commit changes..."
