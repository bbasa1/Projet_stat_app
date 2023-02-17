################################################################################
######### LE NETTOYAGE #####
################################################################################

################################################################################
#         1 . Mise en forme des variables d'intérêt ========================
################################################################################

######### Renaming des variables conservées ######################
try(setnames(data_merged,'QHHNUM',"Identifiant_menage"), silent=TRUE)
try(setnames(data_merged,'COUNTRY',"Pays"), silent=TRUE)
try(setnames(data_merged,'SEX',"Sexe_1H_2F"), silent=TRUE)
try(setnames(data_merged,'YEAR',"Annee_enquete"), silent=TRUE)
try(setnames(data_merged,'AGE',"Age_tranche"), silent=TRUE)
try(setnames(data_merged,'YSTARTWK',"Debut_emploi_actuel"), silent=TRUE)

try(setnames(data_merged,'ILOSTAT',"Statut_emploi_1_emploi"), silent=TRUE)
try(setnames(data_merged,'WSTATOR',"Statut_semaine"), silent=TRUE)
try(setnames(data_merged,'WANTWORK',"Souhaite_travailler"), silent=TRUE)
try(setnames(data_merged,'WISHMORE',"Souhaite_davantage_travailler"), silent=TRUE)
try(setnames(data_merged,'AVAILBLE',"Disponible_pour_travailler"), silent=TRUE)
try(setnames(data_merged,'SEEKWORK',"Recherche_un_emploi"), silent=TRUE)
# try(setnames(data_merged,'SEEKREAS',"Raison_absence_recherche"), silent=TRUE)
try(setnames(data_merged,'STAPRO',"Statut_dans_emploi"), silent=TRUE)
try(setnames(data_merged,'FTPT',"Temps_partiel"), silent=TRUE)

try(setnames(data_merged,'ISCO3D',"CSP"), silent=TRUE)
try(setnames(data_merged,'TEMP',"Perennite_emploi"), silent=TRUE)
try(setnames(data_merged,'TEMPDUR',"Duree_contrat"), silent=TRUE)
try(setnames(data_merged,'HWWISH',"Volume_travail_souhaite"), silent=TRUE)
try(setnames(data_merged,'HWUSUAL',"Volume_travail_habituel"), silent=TRUE)
try(setnames(data_merged,'INCDECIL',"Decile_salaire"), silent=TRUE)

try(setnames(data_merged,'HATLEV1D',"Niveau_education"), silent=TRUE)
try(setnames(data_merged,'HATFIELD',"Domaine_education"), silent=TRUE)

try(setnames(data_merged,'HHNBCH2',"Nb_enfants_moins_2_ans"), silent=TRUE)
try(setnames(data_merged,'HHNBCH5',"Nb_enfants_entre_3_5_ans"), silent=TRUE)
try(setnames(data_merged,'HHNBCH8',"Nb_enfants_entre_6_8_ans"), silent=TRUE)
try(setnames(data_merged,'HHNBCH11',"Nb_enfants_entre_9_11_ans"), silent=TRUE)
try(setnames(data_merged,'HHNBCH14',"Nb_enfants_entre_11_14_ans"), silent=TRUE)

try(setnames(data_merged,'FTPTREAS',"Raisons_temps_partiel"), silent=TRUE)
# try(setnames(data_merged,'SEEKREAS',"Raisons_recherche_emploi"), silent=TRUE)
# try(setnames(data_merged,'NOWKREAS',"Raisons_emploi_mais_pas_travail"), silent=TRUE)
# try(setnames(data_merged,'LEAVREAS',"Raisons_démission"), silent=TRUE)
# try(setnames(data_merged,'AVAIREAS',"Raisons_indisponibilité_travail"), silent=TRUE)


######### Recoder les variables avec des modalités NA et non concerné ######################

try(data_merged <- data_merged[, Souhaite_travailler  := Souhaite_travailler], silent=TRUE)
try(data_merged <- data_merged[Souhaite_travailler == 9, Souhaite_travailler  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Souhaite_travailler ), Souhaite_travailler  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Souhaite_davantage_travailler  := Souhaite_davantage_travailler], silent=TRUE)
try(data_merged <- data_merged[Souhaite_davantage_travailler == 9, Souhaite_davantage_travailler  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Souhaite_davantage_travailler ), Souhaite_davantage_travailler  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Disponible_pour_travailler  := Disponible_pour_travailler], silent=TRUE)
try(data_merged <- data_merged[Disponible_pour_travailler == 9, Disponible_pour_travailler  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Disponible_pour_travailler ), Disponible_pour_travailler  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Recherche_un_emploi  := Recherche_un_emploi], silent=TRUE)
try(data_merged <- data_merged[Recherche_un_emploi == 9, Recherche_un_emploi  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Recherche_un_emploi ), Recherche_un_emploi  := 9999], silent=TRUE)

# try(data_merged <- data_merged[, Raison_absence_recherche  := Raison_absence_recherche], silent=TRUE)
# try(data_merged <- data_merged[Raison_absence_recherche == 9, Raison_absence_recherche  := 9999], silent=TRUE)
# try(data_merged <- data_merged[is.na(Raison_absence_recherche ), Raison_absence_recherche  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Statut_dans_emploi  := Statut_dans_emploi], silent=TRUE)
try(data_merged <- data_merged[Statut_dans_emploi == 9, Statut_dans_emploi  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Statut_dans_emploi ), Statut_dans_emploi  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Temps_partiel  := Temps_partiel], silent=TRUE)
try(data_merged <- data_merged[Temps_partiel == 9, Temps_partiel  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Temps_partiel ), Temps_partiel  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Perennite_emploi  := Perennite_emploi], silent=TRUE)
try(data_merged <- data_merged[Perennite_emploi == 9, Perennite_emploi  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Perennite_emploi ), Perennite_emploi  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Duree_contrat  := Duree_contrat], silent=TRUE)
try(data_merged <- data_merged[Duree_contrat == 9, Duree_contrat  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Duree_contrat ), Duree_contrat  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Raisons_temps_partiel  := Raisons_temps_partiel], silent=TRUE)
try(data_merged <- data_merged[Raisons_temps_partiel == 9, Raisons_temps_partiel  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Raisons_temps_partiel ), Raisons_temps_partiel  := 9999], silent=TRUE)

try(data_merged <- data_merged[, NEEDCARE  := NEEDCARE], silent=TRUE)
try(data_merged <- data_merged[NEEDCARE == 9, NEEDCARE  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(NEEDCARE ), NEEDCARE  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Niveau_education  := Niveau_education], silent=TRUE)
try(data_merged <- data_merged[Niveau_education == "9", Niveau_education  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Niveau_education ), Niveau_education  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Volume_travail_souhaite  := Volume_travail_souhaite], silent=TRUE)
try(data_merged <- data_merged[Volume_travail_souhaite == 99, Volume_travail_souhaite  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Volume_travail_souhaite ), Volume_travail_souhaite  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Volume_travail_habituel  := Volume_travail_habituel], silent=TRUE)
try(data_merged <- data_merged[Volume_travail_habituel == 99, Volume_travail_habituel  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(Volume_travail_habituel ), Volume_travail_habituel  := 9999], silent=TRUE)

try(data_merged <- data_merged[, HWACTUAL  := HWACTUAL], silent=TRUE)
try(data_merged <- data_merged[HWACTUAL == 99, HWACTUAL  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(HWACTUAL ), HWACTUAL  := 9999], silent=TRUE)

try(data_merged <- data_merged[, HWACTUA2  := HWACTUA2], silent=TRUE)
try(data_merged <- data_merged[HWACTUA2 == 99, HWACTUA2  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(HWACTUA2 ), HWACTUA2  := 9999], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_moins_2_ans  := Nb_enfants_moins_2_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_moins_2_ans == "99", Nb_enfants_moins_2_ans  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_moins_2_ans ), Nb_enfants_moins_2_ans  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_3_5_ans  := Nb_enfants_entre_3_5_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_3_5_ans == "99", Nb_enfants_entre_3_5_ans  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_3_5_ans ), Nb_enfants_entre_3_5_ans  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_6_8_ans  := Nb_enfants_entre_6_8_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_6_8_ans == "99", Nb_enfants_entre_6_8_ans  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_6_8_ans ), Nb_enfants_entre_6_8_ans  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_9_11_ans  := Nb_enfants_entre_9_11_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_9_11_ans == "99", Nb_enfants_entre_9_11_ans  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_9_11_ans ), Nb_enfants_entre_9_11_ans  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_11_14_ans  := Nb_enfants_entre_11_14_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_11_14_ans == "99", Nb_enfants_entre_11_14_ans  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_11_14_ans ), Nb_enfants_entre_11_14_ans  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Domaine_education  := Domaine_education], silent=TRUE)
try(data_merged <- data_merged[Domaine_education == "999", Domaine_education  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Domaine_education ), Domaine_education  := "9999"], silent=TRUE)

# try(data_merged <- data_merged[, Raisons_emploi_mais_pas_travail  := Raisons_emploi_mais_pas_travail], silent=TRUE)
# try(data_merged <- data_merged[Raisons_emploi_mais_pas_travail == "99", Raisons_emploi_mais_pas_travail  := "9999"], silent=TRUE)
# try(data_merged <- data_merged[is.na(Raisons_emploi_mais_pas_travail ), Raisons_emploi_mais_pas_travail  := "9999"], silent=TRUE)
# 
# try(data_merged <- data_merged[, Raisons_démission  := Raisons_démission], silent=TRUE)
# try(data_merged <- data_merged[Raisons_démission == "99", Raisons_démission  := "9999"], silent=TRUE)
# try(data_merged <- data_merged[is.na(Raisons_démission ), Raisons_démission  := "9999"], silent=TRUE)
# 
# try(data_merged <- data_merged[, Raisons_indisponibilité_travail  := Raisons_indisponibilité_travail], silent=TRUE)
# try(data_merged <- data_merged[Raisons_indisponibilité_travail == "99", Raisons_indisponibilité_travail  := "9999"], silent=TRUE)
# try(data_merged <- data_merged[is.na(Raisons_indisponibilité_travail ), Raisons_indisponibilité_travail  := "9999"], silent=TRUE)
# 
# try(data_merged <- data_merged[, Raisons_recherche_emploi  := Raisons_recherche_emploi], silent=TRUE)
# try(data_merged <- data_merged[Raisons_recherche_emploi == "99", Raisons_recherche_emploi  := "9999"], silent=TRUE)
# try(data_merged <- data_merged[is.na(Raisons_recherche_emploi ), Raisons_recherche_emploi  := "9999"], silent=TRUE)


################################################################################
#         2 . Petite analyse des "valeurs manquantes" ========================
################################################################################
#A retravailler éventuellement : pour l'instant commentée

######### Petite analyse des "valeurs manquantes" ######################
# 
# table(data_merged$Age_tranche)
# # Remarque : on devrait peut être élargir la distribution de l'âge ? On avait déja discuté des bornes ?
# sous_data_merged <- data_merged[Age_tranche %in% c(22, 27, 32, 37, 42, 47, 52, 57)]
# summary(sous_data_merged$Age_tranche)
# #On va travailler sur la table restreinte 
# summary(sous_data_merged)
# # summary(data_merged)
# # Il y a 34 variables, 3765952 lignes. 
# # Certaines variables ne présentent aucune valeur manquante 
# 
# names(sous_data_merged)
# # COEFF : on constate qu'un certain nombre de lignes ont poids nul (2269796)
# summary(sous_data_merged$COEFF)
# sous_data_merged[COEFF > 0, id oeff := 1]
# summary(sous_data_merged$id oeff)
# 
# # PAYS : Aucun problème dans le cas de la France 
# table(sous_data_merged$Pays)
# summary(sous_data_merged$Pays)
# 
# # Sexe_1H_2F : Aucun problème
# table(sous_data_merged$Sexe_1H_2F)
# summary(sous_data_merged$Sexe_1H_2F)
# 
# # Annee_enquete : Aucun problème
# table(sous_data_merged$Annee_enquete)
# summary(sous_data_merged$Annee_enquete)
# 
# # Age_tranche : Aucun problème
# table(sous_data_merged$Age_tranche)
# summary(sous_data_merged$Age_tranche)
# 
# # Debut_emploi_actuel : il y a 16218 NA en plus des valeurs abérentes (il faudtrait retraiter ou même supprimer les cas < 1952 a minima)
# # Filter EMPSTAT = 1 - probablement la source des NA, il faudra l'ajouter à la base 
# summary(sous_data_merged$Debut_emploi_actuel)
# table(sous_data_merged$Debut_emploi_actuel)
# # les NA sont ils des 999 mal classés ?  Ou des filtrés ?
# sous_data_merged[is.na(Debut_emploi_actuel)== "TRUE", id_na_Debut_emploi_actuel := 1]
# table(sous_data_merged$id_na_Debut_emploi_actuel,sous_data_merged$Statut_emploi_1_emploi)
# # a priori ces individus sont tous en emploi
# table(sous_data_merged$id_na_Debut_emploi_actuel,sous_data_merged$Sexe_1H_2F)# pas de diff a priori
# table(sous_data_merged$id_na_Debut_emploi_actuel,sous_data_merged$Age_tranche)# plus nombre chez les jeunes mais il faudrait voir en proportion
# table(sous_data_merged$id_na_Debut_emploi_actuel,sous_data_merged$Annee_enquete)# ca concerne plutot les enquêtes recentes à partir de 2013 
# table(sous_data_merged$id_na_Debut_emploi_actuel,sous_data_merged$Statut_semaine)# la majroité travaillait effectivement 
# 
# # Statut_emploi_1_emploi : Aucun problème
# summary(sous_data_merged$Statut_emploi_1_emploi)
# table(sous_data_merged$Statut_emploi_1_emploi)
# 
# # Statut_semaine : Aucun problème
# table(sous_data_merged$Statut_semaine)
# summary(sous_data_merged$Statut_semaine)
# table(sous_data_merged$Statut_emploi_1_emploi,sous_data_merged$Statut_semaine)
# 
# # Souhaite_travailler : on a 10059 NA et 3092228 9
# # Filter SEEKWORK = 5
# table(sous_data_merged$Souhaite_travailler)
# summary(sous_data_merged$Souhaite_travailler)
# # les NA sont ils des 999 mal classés ? Ou des filtrés ?
# sous_data_merged[is.na(Souhaite_travailler)== "TRUE", id_na_Souhaite_travailler:= 1]
# table(sous_data_merged$id_na_Souhaite_travailler)
# table(sous_data_merged$id_na_Souhaite_travailler,sous_data_merged$Statut_emploi_1_emploi)
# table(sous_data_merged$id_na_Souhaite_travailler,sous_data_merged$Recherche_un_emploi)# les NA proviennent du Filtre 
# 
# # Souhaite_davantage_travailler : on a 181034 NA et 10053169
# # Filtre : (SEEKWORK = 1, 2, 3, 4) OR (WANTWORK = 1) OR (WISHMORE = 2)
# table(sous_data_merged$Souhaite_davantage_travailler)
# summary(sous_data_merged$Souhaite_davantage_travailler)
# # les NA sont ils des 999 mal classés ? Ou des filtrés ?
# sous_data_merged[is.na(Souhaite_davantage_travailler)== "TRUE", id_na_Souhaite_davantage_travailler:= 1]
# table(sous_data_merged$id_na_Souhaite_davantage_travailler)
# table(sous_data_merged$id_na_Souhaite_davantage_travailler,sous_data_merged$Recherche_un_emploi)# filtre : elles ne recherchent pas un emploi donc elles ne souhaient pas travailler
# table(sous_data_merged$id_na_Souhaite_davantage_travailler,sous_data_merged$Souhaite_travailler)# les NA proviennent du Filtre 
# 
# # Disponible_pour_travailler : Aucun problème
# table(sous_data_merged$Disponible_pour_travailler)
# summary(sous_data_merged$Disponible_pour_travailler)
# 
# # Recherche_un_emploi : Aucun problème
# table(sous_data_merged$Recherche_un_emploi)
# summary(sous_data_merged$Recherche_un_emploi)
# 
# # Raison_absence_recherche : 339016 NA
# #  filtre : WANTWORK = 1 / Recherche_un_emploi
# table(sous_data_merged$Raison_absence_recherche)
# summary(sous_data_merged$Raison_absence_recherche)
# # les NA sont ils des 999 mal classés ? Ou des filtrés ?
# sous_data_merged[is.na(Raison_absence_recherche)== "TRUE", id_na_Raison_absence_recherche:= 1]
# table(sous_data_merged$id_na_Raison_absence_recherche)
# table(sous_data_merged$id_na_Raison_absence_recherche,sous_data_merged$Souhaite_travailler)# filtre : elles ne recherchent pas un emploi donc elles ne souhaient pas travailler
# table(sous_data_merged$id_na_Raison_absence_recherche,sous_data_merged$Recherche_un_emploi)# filtre : elles ne recherchent pas un emploi donc elles ne souhaient pas travailler
# 
# 
# # DEGURBA : Aucun problème
# table(sous_data_merged$DEGURBA)
# summary(sous_data_merged$DEGURBA)
# 
# # Statut_dans_emploi : 733 NA
# #  filtre : EMPSTAT = 1
# table(sous_data_merged$Statut_dans_emploi)
# summary(sous_data_merged$Statut_dans_emploi)
# 
# # Temps_partiel : 50 NA
# #  filtre : EMPSTAT = 1
# table(sous_data_merged$Temps_partiel)
# summary(sous_data_merged$Temps_partiel)
# 
# # CSP : Aucun problème
# table(sous_data_merged$CSP)
# summary(sous_data_merged$CSP)
# 
# # Perennite_emploi: 1559 NA 
# # filter : STAPRO = 3
# table(sous_data_merged$Perennite_emploi)
# summary(sous_data_merged$Perennite_emploi)
# # les NA sont ils des 999 mal classés ? Ou des filtrés ?
# sous_data_merged[is.na(Perennite_emploi)== "TRUE", id_na_Perennite_emploi:= 1]
# table(sous_data_merged$id_na_Perennite_emploi)
# table(sous_data_merged$id_na_Perennite_emploi,sous_data_merged$Statut_dans_emploi)# filtre 
# 
# # Duree_contrat : 47910 NA
# # Filter : TEMP = 2
# table(sous_data_merged$Duree_contrat)
# summary(sous_data_merged$Duree_contrat)
# # les NA sont ils des 999 mal classés ? Ou des filtrés ?
# sous_data_merged[is.na(Duree_contrat)== "TRUE", id_na_Duree_contrat:= 1]
# table(sous_data_merged$id_na_Duree_contrat)
# table(sous_data_merged$id_na_Duree_contrat,sous_data_merged$Perennite_emploi)# filtre 
# 
# # FTPTREAS : 21831 NA 
# # Filter : FTPT = 2
# table(sous_data_merged$FTPTREAS)
# summary(sous_data_merged$FTPTREAS)
# # les NA sont ils des 999 mal classés ? Ou des filtrés ?
# sous_data_merged[is.na(FTPTREAS)== "TRUE", id_na_FTPTREAS:= 1]
# table(sous_data_merged$id_na_FTPTREAS)
# table(sous_data_merged$id_na_FTPTREAS,sous_data_merged$Temps_partiel)# filtre 
# 
# 
# # Volume_travail_souhaite : 670461 NA
# # filter : EMPSTAT = 1
# table(sous_data_merged$Volume_travail_souhaite)
# summary(sous_data_merged$Volume_travail_souhaite)
# 
# # Volume_travail_habituel : 30143 NA 
# # filter : EMPSTAT = 1
# table(sous_data_merged$Volume_travail_habituel)
# summary(sous_data_merged$Volume_travail_habituel)
# 
# # HWACTUAL : 4443 NA 
# # Filter : EMPSTAT = 1
# table(sous_data_merged$HWACTUAL)
# summary(sous_data_merged$HWACTUAL)
# 
# # HWACTUA2: 12667 NA
# # Filter : EXIST2J=2 
# table(sous_data_merged$HWACTUA2)
# summary(sous_data_merged$HWACTUA2)
# 
# # Decile_salaire : Aucun problème
# table(sous_data_merged$Decile_salaire)
# summary(sous_data_merged$Decile_salaire)
# 
# # Niveau_education : Aucun problème
# table(sous_data_merged$Niveau_education)
# summary(sous_data_merged$Niveau_education)
# 
# # Domaine_education : Aucun problème
# table(sous_data_merged$Domaine_education)
# summary(sous_data_merged$Domaine_education)
# 
# # Nb_enfants_moins_2_ans : Aucun problème
# table(sous_data_merged$Nb_enfants_moins_2_ans)
# summary(sous_data_merged$Nb_enfants_moins_2_ans)
# 
# # Nb_enfants_entre_3_5_ans : Aucun problème
# table(sous_data_merged$Nb_enfants_entre_3_5_ans)
# summary(sous_data_merged$Nb_enfants_entre_3_5_ans)
# 
# # Nb_enfants_entre_6_8_ans : Aucun problème
# table(sous_data_merged$Nb_enfants_entre_6_8_ans)
# summary(sous_data_merged$Nb_enfants_entre_6_8_ans)
# 
# # Nb_enfants_entre_9_11_ans : Aucun problème
# table(sous_data_merged$Nb_enfants_entre_9_11_ans)
# summary(sous_data_merged$Nb_enfants_entre_9_11_ans)
# 
# # Nb_enfants_entre_11_14_ans : Aucun problème
# table(sous_data_merged$Nb_enfants_entre_11_14_ans)
# summary(sous_data_merged$Nb_enfants_entre_11_14_ans)

################################################################################
#         4 . Equivalent temps plein  ========================
################################################################################

calcul_EQTP <- function(data_merged_loc){
  
  ## Création de poids d'équivalent temps plein
  
  # Passage en df pour les calculs
  
  df_merged<- as.data.frame(data_merged_loc)
  
  # 100*table(df_merged$Volume_travail_habituel)/nrow(df_merged)
  # 100*table(df_merged$Statut_semaine)/nrow(df_merged)
  # 100*table(df_merged$Statut_emploi_1_emploi)/nrow(df_merged)
  
  
  df_merged <- df_merged %>%
    mutate(Temps_partiel_clean = ifelse(Temps_partiel ==2, 0, Temps_partiel)) %>%
    mutate(Temps_partiel_clean = ifelse(Temps_partiel ==9, is.na(Temps_partiel_clean), Temps_partiel_clean)) %>% # Création de TP égale à 1 si temps plein, 0 si temps partiel
    mutate(ETP = ifelse(Temps_partiel_clean ==1, 1, 0)) %>%
    mutate(heures_clean = ifelse(Volume_travail_habituel ==99 | Volume_travail_habituel ==00, NA_real_, Volume_travail_habituel)) %>% # création de heures clean, variable nettoyée du nombre d'heures travaillées habituellement
    group_by(Annee_enquete, Temps_partiel_clean) %>%
    mutate(mediane_h = median(heures_clean, na.rm = TRUE)) %>%
    group_by(Annee_enquete) %>%
    mutate(mediane_h = max(mediane_h, na.rm = TRUE)) # création de la médiane des heures travaillées par les individus à plein temps pour chaque année
  
  # summary(df_merged$EQTP)
  
  df_merged <- df_merged %>%
    mutate(EQTP = Volume_travail_habituel/mediane_h) %>% # création du coefficient d'équivalent temps plein (linéaire: variable continue)
    mutate(EQTP = ifelse(EQTP>1, 1, EQTP))%>%
    mutate(EQTP = ifelse(is.na(heures_clean), NA_real_, EQTP))
  
  #### Il y a des NAN dans EQTP ssi Volume_travail_habituel = NAN ssi Volume_travail_habituel == 99 ou 0
  
  # summary(df_merged$EQTP)
  
  
  df_merged <- df_merged %>%
    mutate(Poids_final = EQTP*COEFF) # création du poids final égal au coeff initial de l'enquête x le coeff d'ETP
  
  summary(df_merged$Poids_final)
  
  df_merged <- df_merged %>%
    select(-ETP) # suppression de la variable ETP, conservation des autres variables
  
  
  data_merged_loc<- as.data.table(df_merged)
  
  return(data_merged_loc)
}





################################################################################
#              5 . Exploration pbm NAN dans COEFF       ========================
################################################################################

# summary(data_merged$COEFF)
# 100*table(data_merged$COEFF)/nrow(data_merged)


# 100 * nrow(data_merged[is.na(COEFF), ])/nrow(data_merged) #Donne le % de NAN dans COEFF
# table(data_merged[is.na(COEFF), ]$Statut_emploi_1_emploi) #Donne le détail des NAN qui sont dans COEFF par statut d'emploi
# table(data_merged[is.na(COEFF), ]$Annee_enquete) #Idem par année d'enquête
# data_merged[is.na(COEFF), ]

# 100 * nrow(data_merged[is.na(COEFF), ])/nrow(data_merged)

# sous_data <- data_merged %>% 
#   group_by(Annee_enquete) %>% 
#   summarise(somme oeff = sum(COEFF, na.rm = TRUE))
# 
# titre <- paste("Somme des coefficients par année en", pays, sep = " ")
# 
# ggplot(data = sous_data, aes(x = Annee_enquete, y = somme oeff)) +
#   geom_point() +
#   labs(title = titre,
#        x = "Année d'enquête",
#        y = "Somme des coefficients") # Trace la somme des COEFFS par année, pour voir s'il y a un décrochage à cause des NAN




# 100 * nrow(data_merged[is.na(COEFF), ])/nrow(data_merged)
if(mettre_coeffs_nan_a_zero){data_merged <- data_merged[is.na(COEFF), COEFF := 0, ]}
# 100 * nrow(data_merged[is.na(COEFF), ])/nrow(data_merged)
