data("iris")

largoPetalo<-iris$Sepal.Length
library(tidyverse)
#summarise para resumir
resume_largoPetalo<- summarise(iris,mediaPetalLenght=mean(iris$Petal.Length),DesviacionPetalLenght=sd(iris$Petal.Length))
