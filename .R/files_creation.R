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
write.table(table,file="table_data.txt",sep="\t",row.names=FALSE,quote=FALSE)

#------------------------------------------------------------------------------#
                            #Table par GO SLIM
#------------------------------------------------------------------------------#

# circadian rhythm => 57
cir_rythm=unique(data3[which(data3[,9]=="circadian rhythm"),1])
test=match(cir_rythm,col_names)
table_cir_rythm=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_cir_rythm,file="circadian_rythm.txt",sep="\t",row.names=FALSE,quote=FALSE)

# flower development => 186
flower=unique(data3[which(data3[,9]=="flower development"),1])
test=match(flower,col_names)
table_flower=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_flower,file="flower.txt",sep="\t",row.names=FALSE,quote=FALSE)

# growth => 222
growth=unique(data3[which(data3[,9]=="growth"),1])
test=match(growth,col_names)
table_growth=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_growth,file="growth.txt",sep="\t",row.names=FALSE,quote=FALSE)

# photosynthesis => 75
photo=unique(data3[which(data3[,9]=="photosynthesis"),1])
test=match(photo,col_names)
table_photo=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_photo,file="photo.txt",sep="\t",row.names=FALSE,quote=FALSE)

# response to abiotic stimulus => 661
abiotic=unique(data3[which(data3[,9]=="response to abiotic stimulus"),1])
test=match(abiotic,col_names)
table_abiotic=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_abiotic,file="abiotic.txt",sep="\t",row.names=FALSE,quote=FALSE)

# response to biotic stimulus => 420
biotic=unique(data3[which(data3[,9]=="response to biotic stimulus"),1])
test=match(biotic,col_names)
table_biotic=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_biotic,file="biotic.txt",sep="\t",row.names=FALSE,quote=FALSE)

# response to endogenous stimulus => 523
endogenous=unique(data3[which(data3[,9]=="response to endogenous stimulus"),1])
test=match(endogenous,col_names)
table_endogenous=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_endogenous,file="endogenous.txt",sep="\t",row.names=FALSE,quote=FALSE)

# response to external stimulus => 552
external=unique(data3[which(data3[,9]=="response to external stimulus"),1])
test=match(external,col_names)
table_external=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_external,file="external.txt",sep="\t",row.names=FALSE,quote=FALSE)

# response to light stimulus => 292
light=unique(data3[which(data3[,9]=="response to light stimulus"),1])
test=match(light,col_names)
table_light=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_light,file="light.txt",sep="\t",row.names=FALSE,quote=FALSE)

# response to stress => 1177
stress=unique(data3[which(data3[,9]=="response to stress"),1])
test=match(stress,col_names)
table_stress=table[,c(1,2,3,test[-which(is.na(test))])]
write.table(table_stress,file="stress.txt",sep="\t",row.names=FALSE,quote=FALSE)

# random set -> 50
random=sample(col_names[c(-1,-2)],50,replace=FALSE,prob=NULL)
test=match(random,col_names)
table_random=table[,c(1,2,3,test)]
write.table(table_random,file="random.txt",sep="\t",row.names=FALSE,quote=FALSE)
