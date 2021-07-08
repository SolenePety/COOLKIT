 ## Code source stage M1 COOLKIT  
 
Les scripts du stage peuvent être découpés en trois catégories, par ordre d'exécution :
   
 ### 0. Formatage des données
    
* **GEM2Net.table.R** : 
	permet d'enrichir le tableau de données d'expression de GEM2Net (*Gene_Swap_NO_NA.dat*) avec les métadonnées de *SONATA_Ordres_ML.txt*. Permet production de *GEM2Net_data.txt* (17341 colonnes = gènes, + 3 colonnes métadonnées (SWAP_ID, project ID, stress) et 387 lignes = échantillons).
 
 ### 1. Création des Gene Sets (GO SLIM et analyse différentielle)
    
* **A. Analyse_diff.Rmd** : 
	analyse différentielle, package limma, à partir *GEM2Net_table.R*. Production liste des gènes DEG par stress pour les 9 stress abiotiques.
    
* **B. subsets_GOSLIM_diff.R** : 
	* à partir *Gene_Swap_NO_NA.dat*, *SONATA_Ordres_ML.txt* et *ATH_GO_GOSLIM.txt*, construction des Gene Sets GO SLIM, 10 GO SLIM plus un random set (variables début de script : GOSLIM = termes dans ATH_GO_GOSLIM, names_output = noms sortis des fichiers et size = taille random set), 
		
	* à partir listes des gènes, construction des Gene Sets signature de stress pour les 9 stress abiotiques. (fichiers .txt commençant par DEG...)
 
 ### 2. Analyses des données
 
 #### A. Analyse exploratoire
     
* **ACP_kmean.Rmd** :
	Pour chaque Gene Set GO SLIM, échantillons abiotiques, génère ACP (label : project ID, coloration : stress) et kmean (screeplot clusters + ACP (label : project ID, coloration : cluster))
        
* **boxplot_samples.Rmd** :
	Pour chaque Gene Set GO SLIM, génère boxplot via *ggplot2* des données d'expressions pour les 9 stress abiotiques puis les 9 biotiques en regroupant par stress. 
	
* **prediction.Rmd** : 
	Essais fonctin predict() FactoMineR sur les données ACP pour Gene Set rythme circadien. 

* **report_(a)biotic.Rmd** :
		Pour 9 stress (a)biotiques, upset plot général des Gene Set GO SLIM. Pour chaque Gene Set :
		* ACP (individus, inertie, contribution, distribution top 5 contributeurs),
		* BCA (globale, par stress)

* **result_deg_uv_necro.Rmd** : 
		Même sorties que *report_(a)biotic.Rmd* mais pour les deux fichiers avec les gènes DEG spécifiquement pour UV (stress abiotiques) ou Necrotrophic Bacteria (stress biotiques) retirés.
		
		
* **tests_abiotic.Rmd** :
	Script brouillon, première exploration. Problématique des valeurs extrêmes. Génère notamment :
		* L'ACP des individus de l'ensemble des données scaled, avec ou sans label.
		* L'ACP des individus des données scaled rythme circadien,
		* Le screeplot de l'ACP sur les 17341 gènes,
		* Les effectifs des stress biotiques et abiotiques,
		* Des boxplots (comparaison scaled/non scaled, couleurs pour des valeurs extrêmes, des stress surprenant, des lignes remarquables sur ACP)
	
* **upset_signature.R** :
	Prends en entrée les fichiers signatures de stress et génère upset plot correspondant.
	
     
     #### B. Classifications
     
     * **LDA_multisamples.Rmd** :
     
Analyse discriminante linéaire, à partir *table_data.txt*, génère 10 sets d'échantillons stratifiés aléatoire. Calculs pour chaque gene set <200 gènes (6 fichiers) LDA pour les 10 sets. Les sorties sont pour chaque gene set :
	* matrice probabilités moyennées sur 10, 
    * stacked barplot des probabilités pour chaque stress,
    * comparaison probabilité d'attribution correcte ACP vs données d'expression,
    * comparaison probabilité d'attribution correcte One-vs-all vs Multisamples
	
En figures bilan, nous avons :
    * Les heatmap de confiance de prédiction et proportions d'échantillons bien classées,
    * L'upset plot des fichiers d'entrées
    * Les stacked barplot pour chaque stress
        		
     * **LDA_multisamples_ACP.Rmd**, **LDA_oneversusall.Rmd**, **LDA_onevesusall_PCA.Rmd** :
Ces scripts génèrent reprennent les mêmes sorties globalement que *LDA_multisamples.Rmd* sans comparaison des méthodes. Ce sont les scripts propres à chaque méthode.
        	
    * **PLS-DA.Rmd** :	
Mêmes sorties que pour la LDA pour deux méthodes de calculs de distance PLS-DA.
     
#### C. PLIER

    * **PLIER.Rmd** :
Application de la stratégie PLIER. Se découpe en plusieurs étapes.
		* **Récupération Pathways** :
Plusieurs fichiers : *ara_pathways.20210325.txt* (AraCyc), les GO SLIM, package KEGGAPI. Sortie graphique indice de Jaccard (Heatmap, histogramme distribution)
		* **Modèle** :
Le chunk du calcul du modèle est commenté. Les résultats sont stockés dans *load(plierResult)*. Il en ressort :
        	*la matrice U pour LV significatives, 
        	* le summary PLIER LV significatives, 
        	* Les ACP LV significatives vs not significatives, 
        	* Les boxplots d'expression de chaque LV sig pour stress abiotiques,
        	* ANOVA (pas significative)
        	* **MultiPLIER** :
        		GEOquery pour récupérer données photosynthèse. Transformation matrice expression pour intégrer noms gènes. Nouvelle matrice B (LV/Pathways x Samples). Génère Heatmap nouvelle matrice pour LV sig (*Warning : LV sig rentrées à la main*) et plot line correspondant.
