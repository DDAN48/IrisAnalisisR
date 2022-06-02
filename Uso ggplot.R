library(tidyverse)

githubURL <- ("https://raw.githubusercontent.com/Curso-programacion/Tarea_1/master/Protected_Areas.rds")
download.file(githubURL, "PA.rds", method = "curl")
PA <- readRDS("PA.rds")

ggplot(PA,aes(x=PA$STATUS_YR,y=PA$TERR_AREA) )+
  geom_point(aes(color=PA$DESIG))+
  theme_dark()
data("iris")

#USANDO DIAMONDS

data("diamonds")
ggplot(diamonds, aes(x=diamonds$carat,y=diamonds$price))+geom_point(aes(color=diamonds$cut,alpha=0.7))+
  theme_bw()

#modificando escalas
ggplot(PA,aes(x=PA$STATUS_YR,y=PA$TERR_AREA) )+
  geom_point(aes(color=PA$DESIG))+
  theme_dark()

#como no se puede apreciar correctamente los puntos ya que estan muy concentrados, podemos aplicar un logaritmo
#en la variable TERR_AREA 

PA<-PA %>% mutate(lgTERR_AREA=log(PA$TERR_AREA))

ggplot(PA,aes(x=PA$STATUS_YR,y=PA$lgTERR_AREA) )+
  geom_point(aes(color=PA$DESIG))+
  theme_dark()


#ALGO mejor para interpretar es usar el scale

ggplot(PA,aes(x=PA$STATUS_YR,y=PA$TERR_AREA) )+
  geom_point(aes(color=PA$DESIG))+scale_y_continuous(labels=scales::comma)#podemos modificar los labels de los 
#yticks con labels=scales::comma para mostrar sin los exponenciales pero perdimos la visualización que teniamos con LOG

#la recuperamos aplicando el log pero directamente a la escala con scale_y_log, esto genera la escala logaritmica pero 
#podemos seguir observando los valores con sus valores originales 
ggplot(PA,aes(x=PA$STATUS_YR,y=PA$TERR_AREA) )+
  geom_point(aes(color=PA$DESIG))+scale_y_log10(labels=scales::comma)+labs(title='Areas Protegidas de Chile',x='Area de Terreno',y='Año')

#otra cosa que podemos hacer es cambiar es el tamaño del punto


ggplot(PA,aes(x=PA$STATUS_YR,y=PA$TERR_AREA) )+
  geom_point(aes(color=PA$DESIG,size=PA$TERR_AREA))+scale_y_log10(labels=scales::comma)+labs(title='Areas Protegidas de Chile',x='Area de Terreno',y='Año')


#Haremos la prueba del tamaño con el  dataframe de mtcars
data("mtcars")
ggplot(mtcars,aes(x=mtcars$wt,y=mtcars$mpg))+geom_point(aes(color=mtcars$cyl,size=mtcars$hp))+labs(title='MPG VS PESO',x='MPG',y='PESO')

#VEAMOS el uso de marcadores shape

ggplot(PA,aes(x=PA$STATUS_YR,y=PA$TERR_AREA) )+
  geom_point(aes(color=PA$DESIG,size=PA$TERR_AREA,shape=PA$IUCN_CAT))+scale_y_log10(labels=scales::comma)+labs(title='Areas Protegidas de Chile',x='Area de Terreno',y='Año')



#BOXPLOTS

ggplot(iris,aes(x=Species,y=Sepal.Length))+geom_boxplot(aes(fill=iris$Species))

#modificando los colores del area fill de manera manual


ggplot(iris,aes(x=Species,y=Sepal.Length))+geom_boxplot(aes(fill=iris$Species))+scale_fill_manual(values=c('red','blue','green'))


#grafica jitter esta es en el mismo sentido una grafica plot simple de puntos , pero permite siempre ver los puntos 
#por que dispersa los mismo de manera aleatori para poder visualizarlos con respecto al dato categorico , lo ideal es usarlo con variables categoricas y continuas
ggplot(iris,aes( x=iris$Species ,y=iris$Sepal.Width))+geom_jitter(aes(color=iris$Species))

#combinanso graficas
ggplot(iris,aes( x=iris$Species ,y=iris$Sepal.Width))+geom_boxplot() +geom_jitter(aes(color=iris$Species))


#grafico de violin

ggplot(iris,aes(x=iris$Species,y=iris$Sepal.Length))+geom_violin(aes(fill=iris$Species))

#agregando un color propio

ggplot(iris,aes(x=iris$Species,y=iris$Sepal.Length))+geom_violin(aes(fill=iris$Species))+scale_fill_manual(values=c('red','blue','black'))+
  labs(title='Sepal.Lenght for Species',x='Species',y='Sepal.Lenght')

#Mezclando graficos 

ggplot(iris, aes(x=Species, y=Sepal.Length))+geom_violin(aes(fill=iris$Species),alpha=0.3)+geom_jitter()




#ordenando por tamaño con factor_reorder en la variable que queremos ordenar que es x en este caso pero tomando como referencia
#la variable que desemos o formulemos por ejemplo ordenado por la media del ancho del petalo por especies

ggplot(iris, aes(x=fct_reorder(Species,iris$Sepal.Width,.desc=FALSE), y=iris$Sepal.Width))+geom_boxplot(aes(fill=iris$Species),alpha=0.3)

#reordenando por la funcion que queramos

ggplot(iris, aes(x=fct_reorder(Species,iris$Sepal.Width,.desc=FALSE, .fun=max), y=iris$Sepal.Width))+geom_boxplot(aes(fill=iris$Species),alpha=0.3)

#realizando otras pruebas con el df PA , para esta vemos que la escala actual no permite visualizar los datos correctamente
ggplot(PA,aes(x=PA$IUCN_CAT,y=PA$TERR_AREA))+geom_boxplot()

#ajustamo la escala del eje mediante el uso de logoritmo y usamos labels=scales::comma , para mejorar la visualización

ggplot(PA,aes(x=PA$IUCN_CAT,y=PA$TERR_AREA))+geom_boxplot()+scale_y_log10(labels=scales::comma)

#ahora ordenamos ,  coloreamos y biselamos la mediana con notch=T

ggplot(PA,aes(x=fct_reorder(PA$IUCN_CAT,PA$TERR_AREA),y=PA$TERR_AREA))+geom_boxplot(aes(fill=PA$IUCN_CAT),notch=T)+scale_y_log10(labels=scales::comma)

#Agregamos unos labes

ggplot(PA,aes(x=fct_reorder(PA$IUCN_CAT,PA$TERR_AREA),y=PA$TERR_AREA))+
  geom_boxplot(aes(fill=PA$IUCN_CAT),notch=T)+
  scale_y_log10(labels=scales::comma)+
  labs(title = 'TERRA AREA for UCN CAT',x='UCN CAT',y='TERRA AREA')+facet_wrap(~SUB_LOC)

#como podemos observar es dificil ver valores en el eje y , para arreglar esto podemos hacerlo con el uso de 
#de los breaks en la funcion de scale



df<-PA %>% group_by(IUCN_CAT) %>% summarise(mediana=median(TERR_AREA), media=mean(TERR_AREA))


ggplot(PA,aes(x=fct_reorder(PA$IUCN_CAT,PA$TERR_AREA),y=PA$TERR_AREA))+
  geom_boxplot(aes(fill=PA$IUCN_CAT),notch=T)+
  scale_y_log10(labels=scales::comma, breaks=c(rbind(df$mediana,df$media)) )+
  labs(title = 'TERRA AREA for UCN CAT',x='UCN CAT',y='TERRA AREA')


ggplot(PA,aes(x=fct_reorder(PA$IUCN_CAT,PA$TERR_AREA),y=PA$TERR_AREA))+
  geom_boxplot(aes(fill=PA$IUCN_CAT),notch=T)+
  scale_y_log10(labels=scales::comma, breaks=df$mediana)+
  labs(title = 'TERRA AREA for UCN CAT',x='UCN CAT',y='TERRA AREA')

#SUBDIVIDAR GRAFICAS CON RESPECTO A UNA VARIABLE CON facet_wrap(~VARIABLE)

ggplot(PA,aes(x=fct_reorder(PA$IUCN_CAT,PA$TERR_AREA),y=PA$TERR_AREA))+
  geom_boxplot(aes(fill=PA$IUCN_CAT),notch=T)+
  scale_y_log10(labels=scales::comma)+
  labs(title = 'TERRA AREA for UCN CAT',x='UCN CAT',y='TERRA AREA')
  +facet_wrap(~SUB_LOC)

#SUBDIVIDAR GRAFICAS CON RESPECTO A 1 O 2  VARIABLE CON facet_grid(VARIABLE1~VARIABLE2)

ggplot(PA,aes(x=fct_reorder(PA$IUCN_CAT,PA$TERR_AREA),y=PA$TERR_AREA))+
  geom_boxplot(aes(fill=PA$IUCN_CAT),notch=T)+
  scale_y_log10(labels=scales::comma)+
  labs(title = 'TERRA AREA for UCN CAT',x='UCN CAT',y='TERRA AREA')+facet_grid(~SUB_LOC~IUCN_CAT)

#una linea de tendencia sobre los puntos con regresiOn lineal
ggplot(mtcars, aes(x=wt,y=mpg))+geom_point()+geom_smooth(method='lm')
