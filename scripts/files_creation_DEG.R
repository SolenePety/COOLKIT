#------------------------------------------------------------------------------#
#Auteur : Solène Pety

#03/2021

#Stage INRAE - M1 COOLKIT - Estrées-Mons
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
                # Création des fichiers utilisé pour les .Rmd
#------------------------------------------------------------------------------#

#Répertoire contenant l'ensemble des Gene Set, .dat et informations .txt utiles
setwd("~/M1_BIMS/Stage/Rstudio/docs_txt/")

#------------------------------------------------------------------------------#
                            # Chargement des données
#------------------------------------------------------------------------------#

#Données GEM2Net : 387 échantillons correspondant à 387 expériences en condition 
#de stress avec des paramètres différents
data=read.table("Gene_Swap_NO_NA.dat",header=TRUE,sep="\t")

#Tableau information :
#5 colonnes : stress, order, swap_id, swap_name, project_ID
#54 projets différents
data2=read.table("SONATA_Ordres_ML.txt",header=TRUE,sep="\t")

#Données Go SLIM : 
#Colonnes d'intérêts : colonne 1 = gene ID (AT_....), colonne 9 = GO SLIM
data3=read.table("ATH_GO_GOSLIM.txt",header=TRUE,sep="\t",skip=4,fill=TRUE)

#------------------------------------------------------------------------------#
            #Création table avec l'ensemble des informations utiles
#------------------------------------------------------------------------------#
#Colonne 1 = Project_ID
#Colonne 2 = Stress
#Colonne 3 = Swap_ID
#Autres = Gènes, données puces (17341 colonnes)
#col_names = ensemble des gènes présent dans données GEM2Net

ID=data[,1]
vec=c()
vec2=c()
for(i in 1:387){
  vec[i]=data2[which(data2[,3]==ID[i]),1]
  vec2[i]=data2[which(data2[,3]==ID[i]),5]
}
table=cbind(vec2,vec,data)
col_names=colnames(table)

#------------------------------------------------------------------------------#
                        #Table après Analyse différentielle
#------------------------------------------------------------------------------#

#Table avec les genes exprimés différentiellement entre les stress seulement,
#En enlevant les Genes différentiellement exprimés propre aux stress les plus 
#important : Necrotrophic (biotic), UV (abiotic)

#DEG sans UV
liste1=read.table("liste_DEG_withoutUV.txt",sep="\t")
liste1=as.vector(liste1)
liste1=liste1[,1]
liste1=liste1[-1]
test=match(liste1,col_names)
table_DEGwithoutUV=table[,c(1,2,3,test)]
write.table(table_DEGwithoutUV,file="DEG_withoutUV.txt",sep="\t",row.names=FALSE,quote=FALSE)

#DEG sans Necro
liste2=read.table("liste_DEG_withoutNECRO.txt",sep="\t")
liste2=as.vector(liste2)
liste2=liste2[,1]
liste2=liste2[-1]
test=match(liste2,col_names)
table_DEGwithoutNECRO=table[,c(1,2,3,test)]
write.table(table_DEGwithoutNECRO,file="DEGwithoutNECRO.txt",sep="\t",row.names=FALSE,quote=FALSE)


#Utilisation des fichiers signatures de stress générés à l'aide de l'analyse 
#différentielle pour obtenir des Gene Set de tailles modérées et plus informatif,
#homogène que les Gene Set par GO SLIM.

liste=read.table("DROUGHT_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGDROUGHT=table[,c(1,2,3,test)]
write.table(table_DEGDROUGHT,file="DEGDROUGHT.txt",sep="\t",row.names=FALSE,quote=FALSE)

liste=read.table("GAMMA_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGGAMMA=table[,c(1,2,3,test)]
write.table(table_DEGGAMMA,file="DEGGAMMA.txt",sep="\t",row.names=FALSE,quote=FALSE)

liste=read.table("HEAVY.METAL_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGHEAVY.METAL=table[,c(1,2,3,test)]
write.table(table_DEGHEAVY.METAL,file="DEGHEAVY.METAL.txt",sep="\t",row.names=FALSE,quote=FALSE)

liste=read.table("NITROGEN_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGNITROGEN=table[,c(1,2,3,test)]
write.table(table_DEGNITROGEN,file="DEGNITROGEN.txt",sep="\t",row.names=FALSE,quote=FALSE)

liste=read.table("OTHER.ABIOTIC_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGOTHER.ABIOTIC=table[,c(1,2,3,test)]
write.table(table_DEGOTHER.ABIOTIC,file="DEGOTHER.ABIOTIC.txt",sep="\t",row.names=FALSE,quote=FALSE)

liste=read.table("OXYDATIVE.STRESS_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGOXYDATIVE.STRESS=table[,c(1,2,3,test)]
write.table(table_DEGOXYDATIVE.STRESS,file="DEGOXYDATIVE.STRESS.txt",sep="\t",row.names=FALSE,quote=FALSE)

liste=read.table("SALT_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGSALT=table[,c(1,2,3,test)]
write.table(table_DEGSALT,file="DEGSALT.txt",sep="\t",row.names=FALSE,quote=FALSE)

liste=read.table("TEMPERATURE_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGTEMPERATURE=table[,c(1,2,3,test)]
write.table(table_DEGTEMPERATURE,file="DEGTEMPERATURE.txt",sep="\t",row.names=FALSE,quote=FALSE)

liste=read.table("UV_list.txt",sep="\t")
liste=as.vector(liste)
liste=liste[,1]
liste=liste[-1]
test=match(liste,col_names)
table_DEGUV=table[,c(1,2,3,test)]
write.table(table_DEGUV,file="DEGUV.txt",sep="\t",row.names=FALSE,quote=FALSE)
