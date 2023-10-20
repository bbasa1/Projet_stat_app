################################################################################
##### Toutes les filtrations sur les lignes préalables, puis copie de la base ##
################################################################################


### On commence par filtrer sur l'âge
data_merged <- data_merged[Age_tranche - 2 >= age_min, ]
data_merged <- data_merged[Age_tranche + 2 <= age_max, ]

### Puis sur le sexe
data_merged <- data_merged[Sexe_1H_2F == 2]

### Puis sur la sortie d'étude
data_merged <- data_merged[YEAR > HATYEAR, ]

### Puis sur la non retraite ???

### Maintenant qu'on a terminé de filtrer sur les lignes on peut faire une copie de la base
data_merged_copy <- copy(data_merged) ###### IMPORTANT penser à faire un copie avant de faire le clustering, pour pouvoir étudier les résultats après


################################################################################
########### On vérifie que toutes les colonnes ont bien été spécifiées #########
################################################################################

liste_cols_tot <- c(liste_cols_dummies, liste_cols_cont, liste_cols_to_delete)
if (!(all(colnames(data_merged) %in% liste_cols_tot))){
  print("Voici les colonnes qui n'ont pas été spécifiées :")
  print(colnames(data_merged)[!(colnames(data_merged) %in% liste_cols_tot)])
  
  if(planter_si_non_specifie){
    stop("Le traitement de toutes les colonnes présentes dans la table n'a pas été spécifié")
  }else{
    print("Elles sont supprimées")
    liste_cols <- colnames(data_merged)[!(colnames(data_merged) %in% liste_cols_tot)]
    data_merged[, eval(liste_cols) :=NULL] 
    
  }
}

data_merged_non_encoded <- copy(data_merged) ### Pour l'ACM

################################################################################
########### Encodage des colonnes (dummies, etc...) ############################
################################################################################

# On encode les variables catégorielles en dummies, en n'oubliant pas de supprimer les colonnes initiales
for (colonne in liste_cols_dummies){
  rs = split(seq(nrow(data_merged)), data_merged[, ..colonne])
  # data_merged[, names(paste(colonne, rs, sep = "_")) := 0 ]
  for (n in names(rs)) set(data_merged, i = rs[[n]], j = paste(colonne, n, sep = "_"), v = 1)
}


# On rajoute une modalité pour les variables continues : Le NA ou le 9999, et on passe bien en numeric les colonnes
for (colonne in liste_cols_cont){
  print(colonne)
  data_merged[colonne == 99, paste(colonne, "9999", sep = "_") := 1]
  # data_merged[ , eval(colonne) := as.numeric(colonne)] #### A VERIFIER
  # transform(data_merged,colonne = as.numeric(colonne)) 
}

try(data_merged[ , Nb_enfants_moins_2_ans := as.numeric(Nb_enfants_moins_2_ans )]) ###### A DISCUTER POURQUOI CA MARCHE PAS SUR CETTE VARIABLE ????
try(data_merged[ , Nb_enfants_entre_3_5_ans := as.numeric(Nb_enfants_entre_3_5_ans )]) ###### A DISCUTER POURQUOI CA MARCHE PAS SUR CETTE VARIABLE ????
try(data_merged[ , Age_tranche := as.numeric(Age_tranche )]) ###### A DISCUTER POURQUOI CA MARCHE PAS SUR CETTE VARIABLE ????

# try(data_merged_non_encoded[ , Nb_enfants_moins_2_ans := as.numeric(Nb_enfants_moins_2_ans )]) ###### A DISCUTER POURQUOI CA MARCHE PAS SUR CETTE VARIABLE ????
# try(data_merged_non_encoded[ , Nb_enfants_entre_3_5_ans := as.numeric(Nb_enfants_entre_3_5_ans )]) ###### A DISCUTER POURQUOI CA MARCHE PAS SUR CETTE VARIABLE ????
# try(data_merged_non_encoded[ , Age_tranche := as.numeric(Age_tranche )]) ###### A DISCUTER POURQUOI CA MARCHE PAS SUR CETTE VARIABLE ????


################################################################################
########## Supression des colonnes en trop #####################################
################################################################################

### On vire maintenant les colonnes à supprimer, et les colonnes qu'on a passé en dummies
data_merged[, eval(liste_cols_dummies) :=NULL]
data_merged[, eval(liste_cols_to_delete) :=NULL] 


# On supprime les modalités de références (on prend val manquante pour modalité de référence)
liste_cols_delete <- paste(liste_cols_dummies, "9999", sep = "_")
data_merged[, eval(liste_cols_delete) :=NULL]  # remove columns


################################################################################
############### Dernières manipulations ########################################
################################################################################

# On met les NAN à 0 pour laisser la table normalisée
data_merged[is.na(data_merged)] <- 0


# Pour la PCA il ne faut pas le NOM des variables sup, mais leur INDICE...
liste_indices_sup <- c()
for (nom_col in liste_var_sup){
  numero_col <- which(colnames(data_merged) == nom_col)
  liste_indices_sup <- c(liste_indices_sup,numero_col)
}



