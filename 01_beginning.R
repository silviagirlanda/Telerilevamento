# First script R

#R a calculator
a<-5*2
b<-4*7

a+b

#arrays

flowers<-c(3,6,8,10,15,18)
flowers

bees<-c(10,16,25,42,61,73)
bees
#posso mettere in relazione flowers con bees, ad es. facendo un grafico (sulla x avrò flowers, sulla y avrò bees)
plot(flowers,bees)

#possiamo cambiare il simbolo 
plot(flowers,bees,pch=19)

#posso cambiare la dimensione
plot(flowers,bees,pch=19,cex=2) # in questo caso raddoppio
plot(flowers,bees,pch=19,cex=.5) #qui si dimezzerranno

#posso cambiare il colore, ricordandosi di metterlo tra virgolette ""
plot(flowers,bees,pch=19,cex=.5,col="cyan3")
#per salvare vai su "Commit changes..."
