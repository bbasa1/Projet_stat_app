################################################################################
######################## PROGRAMMES POUR CREER LA BASE #########################
################################################################################

fnt_creation_base_stats_des <- function(){
  
  liste_pathes <- paste(repo_data, "/YearlyFiles_1998_2018/", pays, liste_annees,"_y.csv", sep = "")
  
  # Première importation
  data_merged <- read_csv(liste_pathes[1], 
                          locale = locale(encoding ="UTF-8"),
                          show_col_types = FALSE)
  data_merged <- as.data.table(data_merged)
  data_merged <- data_merged[,..liste_variables]
  
  
  
  liste_longeurs <- list(nrow(data_merged))
  
  
  # Boucle sur les années
  for (indice in seq_along(liste_pathes)[c(-1)]){
    # Pour situer dans la boucle :
    path <- liste_pathes[indice]
    annee <- liste_annees[indice]
    print(paste("Année =", annee,"|",nrow(data_merged), "lignes | path = ", path, sep = " "))
    
    # Importation
    data_loc <- read_csv(path,
                         locale = locale(encoding ="UTF-8"),
                         show_col_types = FALSE
    )
    data_loc <- as.data.table(data_loc)
    data_loc <- data_loc[,..liste_variables]
    
    
    # Concaténation
    data_merged <- rbindlist(list(data_merged,
                                  data_loc))
    
    
    liste_longeurs <- append(liste_longeurs,nrow(data_merged))
  }
  
  
  # Une copie de la liste. On ne sait jamais (et ça ne manche pas de pain !)
  liste_longeurs_list <- copy(liste_longeurs)
  
  
  
  ########## Sauvegarde de la base obtenue ################
  remove(data_loc)
  
  dir_base <- paste(repo_data, "/data_intermediaire", sep = "")
  
  
  if (file.exists(dir_base)){
    nom_base <- paste(repo_data, "/data_intermediaire/base_", pays, ".Rdata", sep = "")
  } else {
    dir.create(file.path(dir_base))
    nom_base <- paste(repo_data, "/data_intermediaire/base_", pays, ".Rdata", sep = "")
    
  }
  
  
  save(data_merged, file = nom_base)
  
  return(data_merged)
  
  }



fnt_creation_base_modelisation <- function(){
  
  liste_pathes <- paste(repo_data, "/YearlyFiles_1998_2018/", liste_pays, annee,"_y.csv", sep = "")
  
  # Première importation
  data_merged <- read_csv(liste_pathes[1], 
                          locale = locale(encoding ="UTF-8"),
                          show_col_types = FALSE)
  data_merged <- as.data.table(data_merged)
  data_merged <- data_merged[,..liste_variables]
  
  
  
  liste_longeurs <- list(nrow(data_merged))
  
  
  # Boucle sur les années
  for (indice in seq_along(liste_pathes)[c(-1)]){
    # Pour situer dans la boucle :
    path <- liste_pathes[indice]
    pays <- liste_pays[indice]
    print(paste("Pays =", pays,"|",nrow(data_merged), "lignes | path = ", path, sep = " "))
    
    # Importation
    data_loc <- read_csv(path,
                         locale = locale(encoding ="UTF-8"),
                         show_col_types = FALSE
    )
    data_loc <- as.data.table(data_loc)
    data_loc <- data_loc[,..liste_variables]
    
    
    # Concaténation
    data_merged <- rbindlist(list(data_merged,
                                  data_loc))
    
    
    liste_longeurs <- append(liste_longeurs,nrow(data_merged))
  }
  
  
  # Une copie de la liste. On ne sait jamais (et ça ne manche pas de pain !)
  liste_longeurs_list <- copy(liste_longeurs)
  
  
  
  ########## Sauvegarde de la base obtenue ################
  remove(data_loc)
  
  dir_base <- paste(repo_data, "/data_intermediaire", sep = "")
  
  
  if (file.exists(dir_base)){
    nom_base <- paste(repo_data, "/data_intermediaire/base_", annee, ".Rdata", sep = "")
  } else {
    dir.create(file.path(dir_base))
    nom_base <- paste(repo_data, "/data_intermediaire/base_", annee, ".Rdata", sep = "")
    
  }
  
  
  save(data_merged, file = nom_base)
  
  return(data_merged)
  
}




########## PLOTS des longueurs des data.table obtenus ###############

# 
# df_plot <- list(annee = liste_annees,
#                 population = liste_longeurs_list)
# 
# df_plot <- as.data.table(df_plot)
# df_plot <- df_plot[ , population := as.numeric(population)]
# df_plot <- df_plot[ , annee := as.character(annee)]
# 
# 
# 
# ggplot(data = df_plot) + 
#   geom_bar(aes(x = annee, y = population), stat="identity") + 
#   labs(title="Longueur de la table après concaténation jusqu'à l'année x",
#        x="Année",
#        y="Population") + 
#   scale_y_continuous(labels = function(y) format(y, scientific = FALSE))




