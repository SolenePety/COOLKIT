## Explication données
 
### Annotations
   
* **ara_pathways.20210325.txt** : 
    pathways Aracyc, ftp TAIR : lien
    
* **ATH_GO_GOSLIM.txt** : 
lien, TAIR, colonnes intérêts : colonne 1 = gene ID (AT_....), colonne 9 = GO SLIM
    
### GEM2Net
  
* **GEM2Net_data.txt** : table GEM2Net enrichie avec l'ensemble des informations utiles (colonne 1 = project_ID, colonne 2 = Stress, Colonne 3 = SWAP_ID, Autres = données expression). (générée avec GEM2Net.table.R)
    
* **Gene_Swap_NO_NA.dat** :	387 échantillons x 17341 gènes, avec informations SWAP_ID (identifiant unique échantillon).
 
* **SONATA_Ordres_ML.txt** :	5 colonnes : stress, order, swap_id, swap_name, project_ID, 54 projets différents.
    
### GSE22982
 
* **GEO_photo.txt** : matrice design pour jeu de données photosynthèse pour stratégie multiPLIER. ...
 
### Subsets (après exécution)
 
* **GOSLIM_[GO_SLIM].txt** :	Table avec gènes impliqués dans GO SLIM + métadonnées décrite ci-dessus.
			
* **liste_DEG_without[UV,NECRO].txt** :	Liste des gènes DEGs séparés par tab sauf ceux différentiellement exprimés pour les UV ou Necrotrophic Bacteria.
		
* **[stress]_list.txt** :	Liste des gènes DEGs séparés par tab spécifiques à un stress, génération de 9 listes pour les 9 stress abiotiques.
		
