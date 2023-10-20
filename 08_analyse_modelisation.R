###### Calcul de la pureté des clusters 
#### Explications : 
# We assign a label to each cluster based on the most frequent class in it
# Then the purity becomes the number of correctly matched class and cluster labels divided by the number of total data points.
# Conclusion : Si pour une variable (par exemple l'âge) on a une pureté haute alors ça veut dire que nos clusters sont très homogènes en classes d'âge
# Attention : La pureté augmente avec le nb de clusters donc il faut faire gaffe aux biais d'interprétation...


###### Calcul de la NMI des clusters 
#### Explications : 
# Normalized mutual information (NMI) gives us the reduction in entropy of class labels when we are given the cluster labels.
# In a sense, NMI tells us how much the uncertainty about class labels decreases when we know the cluster labels.
# Pareil que pour la pureté : Une haute NMI indique que la variable permet de faire beaucoup décroitre l'entropie


fonction_calcul_scoring_kmeans <- function(data_loc, kmeans_loc){
  # Et là maintenant on regarde la pureté pour toutes les variables, pour pouvoir comparer !
  fonction_purity <- function(variable_purity){
    return(purity(data_loc[[variable_purity]], kmeans_loc$cluster)$pur)
  }
  
  liste_purities <- lapply(colnames(data_loc), fonction_purity) #Calcul des puretés
  
  
  fonction_NMI <- function(variable_NMI){
    return(NMI(data_loc[[variable_NMI]], kmeans_loc$cluster))
  }
  liste_NMI <- lapply(colnames(data_loc), fonction_NMI) #Calcul des NMI
  
  # On convertir en DF pour que ça soit plus lisible
  liste_pour_df <- list(col_name = colnames(data_loc),
                        NMI = liste_NMI,
                        purity = liste_purities)
  df_analyse_cluster <- as.data.frame(do.call(cbind, liste_pour_df))
  
  return(df_analyse_cluster)
}


############ Petit code en plus pour visualiser 


# # On peut visualiser la pureté des clusters pour une variable choisie 
# variable_purity <- 'Pays_IT'
# 
# table(sample[[variable_purity]], resKM$cluster)
# plot(table(sample[[variable_purity]], resKM$cluster),
#      main= paste("Confusion Matrix pour", variable_purity, sep = " "),
#      xlab=variable_purity, ylab="Cluster")
# 
# purity(sample[[variable_purity]], resKM$cluster)$pur
