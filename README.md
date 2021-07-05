 ## Code source stage M1 COOLKIT
 
 Ci-dessous est indiqué l'ordre d'exécution et la fonction de chaque script
   
 ### 1_Gene_Set
 
 * **Input** :
	 * **Gene_Swap_NO_NA.dat** :
			387 échantillons x 17341 gènes, avec informations SWAP_ID (identifiant unique échantillon).
	 * **SONATA_Ordres_ML.txt** :
			5 colonnes : stress, order, swap_id, swap_name, project_ID, 54 projets différents.
	 * **ATH_GO_GOSLIM.txt** :
			Colonnes d'intérêts : colonne 1 = gene ID (AT_....), colonne 9 = GO SLIM
									
 * **Script** : 
	 * **files_creation.R**
	 
 * **Output** :
	 * **table_data.txt** :
			Création table avec l'ensemble des informations utiles (colonne 1 = project_ID, colonne 2 = Stress, Colonne 3 = SWAP_ID, Autres = données expression).
	 * **[GO_SLIM].txt** :
			Table avec gènes impliqués dans GO SLIM + métadonnées décrite ci-dessus.
			
			
 ### 2_Analyse_differentielle
 
 * **Analyse_diff.Rmd** : 
	Analyse différentielle package limma, p-value=0.05, spération stress biotiques/abiotiques
	* **Input** :
		* **table_data.txt**
	* **Output** :
		* **liste_DEG_without[UV,NECRO].txt** :
			Liste des gènes DEGs séparés par tab sauf ceux différentiellement exprimés pour les UV ou Necrotrophic Bacteria.
		* **[stress]_list.txt** :
			Liste des gènes DEGs séparés par tab spécifiques à un stress, génération de 9 listes pour les 9 stress abiotiques.
			
 * **files_creation_DEG.R** :
	Création des fichiers utilisés pour les .Rmd à partir des listes générées.
	***Reprendre script, pas besoin de reprendre les mêmes input que files_creation, simplement table_data.txt pour les colnames***
	* **Input** :
		 * **Gene_Swap_NO_NA.dat** :
				387 échantillons x 17341 gènes, avec informations SWAP_ID (identifiant unique échantillon).
		 * **SONATA_Ordres_ML.txt** :
				5 colonnes : stress, order, swap_id, swap_name, project_ID, 54 projets différents.
		 * **ATH_GO_GOSLIM.txt** :
				Colonnes d'intérêts : colonne 1 = gene ID (AT_....), colonne 9 = GO SLIM
		 * **Listes des signaures** :
				match avec les colnames et liste des gènes.
	* **Output** :
		 * **table_DEG[stress]** :
				Table des 387 échantillons et gènes signatures du stress, 9 tables pour les 9 stress abiotiques.
			
 * **upset_signature.R** :
	Prends en entrée les fichiers signatures de stress et génère upset plot correspondant.
	
	
 ### 3_Autres Analyses

Pas particulièrement d'ordre d'exécution important pour cette partie. Les scripts prennent en entrée les différents fichiers .txt générés dans les parties précédentes via des listes en débuts de chaque script. *table_data.txt* est aussi impliqué dans la plupart des scripts.

 * **abiotic.Rmd** :
	Script brouillon, première exploration. Problématique des valeurs extrêmes. Génère notamment :
		* L'ACP des individus de l'ensemble des données scaled, avec ou sans label.
		* L'ACP des individus des données scaled rythme circadien,
		* Le screeplot de l'ACP sur les 17341 gènes,
		* Les effectifs des stress biotiques et abiotiques,
		* Des boxplots (comparaison scaled/non scaled, couleurs pour des valeurs extrêmes, des stress surprenant, des lignes remarquables sur ACP)
		
 * **ACP_kmean.Rmd** :
	Pour chaque Gene Set GO SLIM, échantillons abiotiques, génère ACP (label : project ID, coloration : stress) et kmean (screeplot clusters + ACP (label : project ID, coloration : cluster))
	
 * **boxplot_samples.Rmd** :
	Pour chaque Gene Set GO SLIM, génère boxplot via *ggplot2* des données d'expressions pour les 9 stress abiotiques puis les 9 biotiques en regroupant par stress. 
	
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
		

 * **prediction.Rmd** : 
		Essais fonctin predict() FactoMineR sur les données ACP pour Gene Set rythme circadien.
		
 * **report_(a)biotic.Rmd** :
		Pour 9 stress (a)biotiques, upset plot général des Gene Set GO SLIM. Pour chaque Gene Set :
			* ACP (individus, inertie, contribution, distribution top 5 contributeurs),
			* BCA (globale, par stress)
			
 * **result_deg_uv_necro.Rmd** : 
		Même sorties que *report_(a)biotic.Rmd* mais pour les deux fichiers avec les gènes DEG spécifiquement pour UV (stress abiotiques) ou Necrotrophic Bacteria (stress biotiques) retirés.