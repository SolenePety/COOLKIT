library(here)

#Création répertoire subset
dir.create(file.path(here("data"), "subsets"))


#------------------------------------------------------------------------------#
                  # Création des fichiers utilis? pour les .Rmd
#------------------------------------------------------------------------------#

#R?pertoire contenant l'ensemble des Gene Set, .dat et informations .txt utiles


#------------------------------------------------------------------------------#
                            # Chargement des donn?es
#------------------------------------------------------------------------------#

#Donn?es GEM2Net : 387 ?chantillons correspondant ? 387 exp?riences en condition 
#de stress avec des param?tres diff?rents
data=read.table(here("data","GEM2Net","Gene_Swap_NO_NA.dat"),header=TRUE,sep="\t",)

#Tableau information :
#5 colonnes : stress, order, swap_id, swap_name, project_ID
#54 projets diff?rents
data2=read.table(here("data","GEM2Net","SONATA_Ordres_ML.txt"),header=TRUE,sep="\t")

#Donn?es Go SLIM : 
#Colonnes d'int?r?ts : colonne 1 = gene ID (AT_....), colonne 9 = GO SLIM
data3=read.table(here("data","Annotations","ATH_GO_GOSLIM.txt"),header=TRUE,sep="\t",skip=4,fill=TRUE)


#------------------------------------------------------------------------------#
              #Cr?ation table avec l'ensemble des informations utiles
#------------------------------------------------------------------------------#
#Colonne 1 = Project_ID
#Colonne 2 = Stress
#Colonne 3 = Swap_ID
#Autres = G?nes, donn?es puces (17341 colonnes)
#col_names = ensemble des g?nes pr?sent dans donn?es GEM2Net

ID=data[,1]
vec=c()
vec2=c()
for(i in 1:387){
  vec[i]=data2[which(data2[,3]==ID[i]),1]
  vec2[i]=data2[which(data2[,3]==ID[i]),5]
}
table=cbind(vec2,vec,data)
col_names=colnames(table)
write.table(table,file=here("data","GEM2Net","GEM2Net_data.txt"),sep="\t",row.names=FALSE,quote=FALSE)
