library(here)

#Création répertoire subset
dir.create(file.path(here("data"), "subsets"))


#Liste des go slim et noms des fichiers liés
GOSLIM=c("circadian rhythm",
         "flower development",
         "growth",
         "photosynthesis",
         "response to abiotic stimulus",
         "response to biotic stimulus",
         "response to endogenous stimulus",
         "response to external stimulus",
         "response to light stimulus",
         "response to stress")

names_output=c("GOSLIM_circadian_rythm.txt",
               "GOSLIM_flower.txt",
               "GOSLIM_growth.txt",
               "GOSLIM_photo.txt",
               "GOSLIM_abiotic.txt",
               "GOSLIM_biotic.txt",
               "GOSLIM_endogenous.txt",
               "GOSLIM_external.txt",
               "GOSLIM_light.txt",
               "GOSLIM_stress.txt")

size = 50 #taille random set


#------------------------------------------------------------------------------#
                # Cr?ation des fichiers utilis? pour les .Rmd
#------------------------------------------------------------------------------#

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
            #Table
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

#------------------------------------------------------------------------------#
#Table par GO SLIM
#------------------------------------------------------------------------------#

for(i in 1:length(GOSLIM)){
  slim=unique(data3[which(data3[,9]==GOSLIM[i]),1])
  test=match(slim,col_names)
  table_short=table[,c(1,2,3,test[-which(is.na(test))])]
  write.table(table_short,file=here("data","subsets",names_output[i]),sep="\t",row.names=FALSE,quote=FALSE)
}

# random set
random=sample(col_names[c(-1,-2)],size,replace=FALSE,prob=NULL)
test=match(random,col_names)
table_random=table[,c(1,2,3,test)]
write.table(table_random,file=here("data","subsets","random.txt"),sep="\t",row.names=FALSE,quote=FALSE)


#------------------------------------------------------------------------------#
                        #Table apr?s Analyse diff?rentielle
#------------------------------------------------------------------------------#

#Table avec les genes exprim?s diff?rentiellement entre les stress seulement,
#En enlevant les Genes diff?rentiellement exprim?s propre aux stress les plus 
#important : Necrotrophic (biotic), UV (abiotic)
DEG_listes=c("liste_DEG_withoutUV.txt",
             "liste_DEG_withoutNECRO.txt",
             "DROUGHT_list.txt",
             "GAMMA_list.txt",
             "HEAVY.METAL_list.txt",
             "NITROGEN_list.txt",
             "OTHER.ABIOTIC_list.txt",
             "OXYDATIVE.STRESS_list.txt",
             "SALT_list.txt",
             "TEMPERATURE_list.txt",
             "UV_list.txt")

DEG_output=c("DEG_withoutUV.txt",
             "DEGwithoutNECRO.txt",
             "DEGDROUGHT.txt",
             "DEGGAMMA.txt",
             "DEGHEAVY.METAL.txt",
             "DEGNITROGEN.txt",
             "DEGOTHER.ABIOTIC.txt",
             "DEGOXYDATIVE.STRESS.txt",
             "DEGSALT.txt",
             "DEGTEMPERATURE.txt",
             "DEGUV.txt")


for(j in 1:length(DEG_listes)){
  liste=read.table(here("data","subsets",DEG_listes[j]),sep="\t")
  liste=as.vector(liste)
  liste=liste[,1]
  liste=liste[-1]
  test=match(liste,col_names)
  table_DEG=table[,c(1,2,3,test)]
  write.table(table_DEG,file=here("data","subsets",DEG_output[j]),sep="\t",row.names=FALSE,quote=FALSE)
}