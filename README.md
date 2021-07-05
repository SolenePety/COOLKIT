 ## Code source stage M1 COOLKIT
 
 Ci-dessous est indiqué l'ordre d'exécution et la fonction de chaque script
   
 ### 1_Gene_Set
 
 * Input :
	 * **Gene_Swap_NO_NA.dat** :
			387 échantillons x 17341 gènes, avec informations SWAP_ID (identifiant unique échantillon).
	 * **SONATA_Ordres_ML.txt** :
			5 colonnes : stress, order, swap_id, swap_name, project_ID, 54 projets différents.
	 * **ATH_GO_GOSLIM.txt** :
			Colonnes d'intérêts : colonne 1 = gene ID (AT_....), colonne 9 = GO SLIM
									
 * Script : 
	 * **files_creation.R**
	 
 * Output :
	 * **table_data.txt** :
			Création table avec l'ensemble des informations utiles (colonne 1 = project_ID, colonne 2 = Stress, Colonne 3 = SWAP_ID, Autres = données expression).
	 * **[GO_SLIM].txt** :
			Table avec gènes impliqués dans GO SLIM + métadonnées décrite ci-dessus.
			
			
 ### 2_Analyse_differentielle
   
 ### 3_Autres Analyses