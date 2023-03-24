################################################################################
########### FONCTIONS ################################
################################################################################

calcul_taux_emplois_activite <- function(liste_var_groupby, data_loc){
  
  dots <- lapply(liste_var_groupby, as.symbol) #Penser à bien convertir pour ne pas avoir de problèmes...
  df_groupby <- data_loc %>% 
    group_by(.dots = dots) %>% 
    summarize( population = sum(COEFF),
               population_active = sum( COEFF * (Statut_emploi_1_emploi %in% c("1","2"))),
               population_emplois = sum( COEFF * (Statut_emploi_1_emploi==1)),
               population_emplois_etp =sum(Poids_final * (Statut_emploi_1_emploi==1)) ) %>% 
    dplyr::mutate(tx_activite = round(100 * population_active/population , 3),
                  tx_emploi = round(100 * population_emplois/population , 3),
                  tx_emploi_etp = round(100 * population_emplois_etp/population , 3), 
                  population = round(population / 1000 , 2),
                  population_active = round(population_active / 1000 , 2),
                  population_emplois = round(population_emplois / 1000 , 2),
                  population_emplois_etp = round(population_emplois_etp / 1000 , 2))
  
  df_groupby <- as.data.table(df_groupby)
  
  
  return(df_groupby)
}






nettoyage_tranche_age <- function(data_loc, age_min, age_max){
  ### Cette fonction renome les tranches d'âges pour faire des graphiques
  
  data_loc <- data_loc[ , Age_tranche := as.integer(Age_tranche)]
  data_loc[, Indice_ages := Age_tranche] #Pour pouvoir ordonner facilement les barres entre elles
  
  data_loc <- data_loc[Age_tranche - 2 >= age_min, ]
  data_loc <- data_loc[Age_tranche + 2 <= age_max, ]
  
  data_loc[, Age_tranche:= factor(
    fcase(
      Age_tranche == 2, "0-4 ans",
      Age_tranche == 7, "5-9 ans",
      Age_tranche == 12, "10-14 ans",
      Age_tranche == 17, "15-19 ans",
      Age_tranche == 22, "20-24 ans",
      Age_tranche == 27, "25-29 ans",
      Age_tranche == 32, "30-34 ans",
      Age_tranche == 37, "35-39 ans",
      Age_tranche == 42, "40-44 ans",
      Age_tranche == 47, "45-49 ans",
      Age_tranche == 52, "50-54 ans",
      Age_tranche == 57, "55-59 ans",
      Age_tranche == 62, "60-64 ans",
      Age_tranche == 67, "65-69 ans",
      Age_tranche == 72, "70-74 ans",
      Age_tranche == 77, "75-79 ans",
      Age_tranche == 82, "80-84 ans",
      Age_tranche == 87, "85-89 ans",
      Age_tranche == 92, "90-94 ans",
      Age_tranche == 97, "95-99 ans"
      
    )
  )
  ]
  return(data_loc)
}



nettoyage_sexe <- function(data_loc){
  ### Cette fonction renome les sexes pour faire des graphiques
  
  # data_loc <- data_loc[ , Sexe_1H_2F := as.character(Sexe_1H_2F)]
  data_loc[, Sexe_1H_2F:= factor(
    fcase(
      Sexe_1H_2F == 1, "Hommes",
      Sexe_1H_2F == 2, "Femmes"
    )
  )
  ]
  setnames(data_loc,'Sexe_1H_2F',"Sexe")
  
  return(data_loc)
}



nettoyage_niveau_education <- function(data_loc){
  ### Cette fonction renome les niveaux d'éducation pour faire des graphiques
  
  data_loc <- data_loc[ , Niveau_education := as.character(Niveau_education)]

  data_loc[, Indice_educ := factor( #Pour pouvoir ordonner facilement les barres entre elles
    fcase(
      Niveau_education == "L", 0,
      Niveau_education == "M", 1,
      Niveau_education == "H", 2,
      Niveau_education == 9 , -1
      
    )
  )
  ]
  
  data_loc[, Niveau_education := factor(
    fcase(
      Niveau_education == "L", "Bas",
      Niveau_education == "M", "Moyen",
      Niveau_education == "H", "Elevé",
      Niveau_education == 9 , "Âge <= 15 ans"
      
    )
  )
  ]
  
  return(data_loc)
}


