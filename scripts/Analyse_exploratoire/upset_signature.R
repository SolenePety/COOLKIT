library(FactoMineR)
library(factoextra)
library("corrplot")
library(ggsci)
library(plotly)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(ComplexUpset)
library(pander)
library(knitr)
library(discoveR)
library(ade4)
library(adegraphics)
library(vegan)
library(MASS)
library(RColorBrewer)
library(here)

setwd(here("data","subsets"))

data=read.table(here("data","GEM2Net",'Gene_Swap_NO_NA.dat'),header=TRUE,sep='\t')

# Noms des colonnes sans les variables qualitatives
Gene=noquote(colnames(data[,c(-1,-2,-3)]))

#Noms des fichiers pour lecture dans boucle
GOSLIM=c("DEGDROUGHT.txt",
         "DEGGAMMA.txt",
         "DEGHEAVY.METAL.txt",
         "DEGNITROGEN.txt",
         "DEGOTHER.ABIOTIC.txt",
         "DEGOXYDATIVE.STRESS.txt",
         "DEGSALT.txt",
         "DEGTEMPERATURE.txt",
         "DEGUV.txt")

matrix=cbind(rep(0,17341),Gene) #initialisation matrice

#Remplacer 0 par TRUE ou FAlSE pour chaque gene set
for(i in 1:length(GOSLIM)){
  datago=read.table(GOSLIM[i],header=TRUE,sep='\t')
  colgo=noquote(colnames(datago[,c(-1,-2,-3)]))
  test=match(Gene,colgo,nomatch =0)
  test[test!=0]<-"TRUE"
  test[test==0]<-"FALSE"
  matrix=cbind(matrix,test) #assemblage des vecteurs pour chaque stress
}


matrix=as.data.frame(matrix)
matrix=matrix[,-1] #enlever premi?re ligne de 0 d'initialisation
names(matrix)=c("Gene","Drought","Gamma","Heavy.metal","Nitrogen",
                "Other.abiotic","Oxydative","Salt","Temperature",
                "UV")
goslim=colnames(matrix)[2:10]

#Construction upset
(upset(matrix,goslim, name="Signature stress",min_degree=1)
  + ggtitle("Tous les g?nes (173441)"))
