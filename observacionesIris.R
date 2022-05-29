data("iris")

largoPetalo<-iris$Sepal.Length
library(tidyverse)
#summarise para resumir
resume_largoPetalo<- summarise(iris,mediaPetalLenght=mean(iris$Petal.Length),DesviacionPetalLenght=sd(iris$Petal.Length))

#resumen por group by

resumenGb<-group_by(iris,Species)

#resumen agrupado por especie , usamos group_by primero para agrupar y luego con summ
#summarise agrupamos segun los calculos , en PYTHON usamos groub_by y la funcion agg para calcular
resumenagurpado<-summarise(resumenGb,mediaPetalLenght=mean(iris$Petal.Length),DesviacionPetalLenght=sd(iris$Petal.Length))

###trabando con una base mtcars

data("mtcars")

Eficiencia<- group_by(mtcars,cyl,am)#agrupo popr numero de cilindros  y automatico o manual

#una vez agrupado podemos resumir y aplicar la formulacion sobre los los parametros
#que deseemos y se mostraran agrupados en este caso por cyl y am

Eficiencia<-summarise(Eficiencia,Eficiencia=mean(mpg),)

#MUTATE,permite crear variables nuevas , genera un df nuevo con todas y las nueva columna creada
#en python usamos assign , df.assign(petalo_Sepalo=df.Petal.Length/df.Sepal.Length)
df<- mutate(iris,petalo_Sepalo=Sepal.Length/Petal.Length)
df<-group_by(df,Species)


df<-summarise(df,petalo_SepaloM=mean(petalo_Sepalo),n=n())

#hablemos de PIPELINE %>% es una accion que se hace despues de otra de manera secuencial
#para la operacion anterior podemos hacerla de la siguiente manera

df<- iris %>% 
  mutate(petalo_Sepalo=Sepal.Length/Petal.Length) %>% 
  group_by(Species) %>% 
  summarise(petalo_SepaloM=mean(petalo_Sepalo),n=n())


#Si quiero hacer un summarise de todas las  variables 
#se agrupo por SPECIES y despues a todas las variables se le calculo la media y la sd
#pero se pasa a .funs una lista con los calculos que se realizaran
Resumen<-iris %>% group_by(Species) %>% summarise_all(.funs=list(Media=mean,SD=sd))



