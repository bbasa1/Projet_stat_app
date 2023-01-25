################################################################################
######### LE NETTOYAGE #####
################################################################################


######### Renaming des variables conservées ######################
setnames(data_merged,'QHHNUM',"Identifiant_menage")
setnames(data_merged,'COUNTRY',"Pays")
setnames(data_merged,'SEX',"Sexe_1H_2F")
setnames(data_merged,'YEAR',"Annee_enquete")
setnames(data_merged,'AGE',"Age_tranche")
setnames(data_merged,'YSTARTWK',"Debut_emploi_actuel")

setnames(data_merged,'ILOSTAT',"Statut_emploi_1_emploi")
setnames(data_merged,'WSTATOR',"Statut_semaine")
setnames(data_merged,'WANTWORK',"Souhaite_travailler")
setnames(data_merged,'WISHMORE',"Souhaite_davantage_travailler")
setnames(data_merged,'AVAILBLE',"Disponible_pour_travailler")
setnames(data_merged,'SEEKWORK',"Recherche_un_emploi")
setnames(data_merged,'SEEKREAS',"Raison_absence_recherche")
setnames(data_merged,'STAPRO',"Statut_dans_emploi")
setnames(data_merged,'FTPT',"Temps_partiel")

setnames(data_merged,'ISCO3D',"CSP")
setnames(data_merged,'TEMP',"Perennite_emploi")
setnames(data_merged,'TEMPDUR',"Duree_contrat")
setnames(data_merged,'HWWISH',"Volume_travail_souhaite")
setnames(data_merged,'HWUSUAL',"Volume_travail_habituel")
setnames(data_merged,'INCDECIL',"Decile_salaire")

setnames(data_merged,'HATLEV1D',"Niveau_education")
setnames(data_merged,'HATFIELD',"Domaine_education")

setnames(data_merged,'HHNBCH2',"Nb_enfants_moins_2_ans")
setnames(data_merged,'HHNBCH5',"Nb_enfants_entre_3_5_ans")
setnames(data_merged,'HHNBCH8',"Nb_enfants_entre_6_8_ans")
setnames(data_merged,'HHNBCH11',"Nb_enfants_entre_9_11_ans")
setnames(data_merged,'HHNBCH14',"Nb_enfants_entre_11_14_ans")

## Création de poids d'équivalent temps plein

# Passage en df pour les calculs

df_merged<- as.data.frame(data_merged)
df_merged <- df_merged %>%
  mutate(Temps_partiel_clean = ifelse(Temps_partiel ==2, 0, Temps_partiel)) %>% 
  mutate(Temps_partiel_clean = ifelse(Temps_partiel ==9, is.na(Temps_partiel_clean), Temps_partiel_clean)) %>% # Création de TP égale à 1 si temps plein, 0 si temps partiel
  mutate(ETP = ifelse(Temps_partiel_clean ==1, 1, 0)) %>% 
  mutate(heures_clean = ifelse(Volume_travail_habituel ==99 | Volume_travail_habituel ==00, NA_real_, Volume_travail_habituel)) %>% # création de heures clean, variable nettoyée du nombre d'heures travaillées habituellement
  group_by(Annee_enquete, Temps_partiel_clean) %>% 
  mutate(mediane_h = median(heures_clean, na.rm = TRUE)) %>% 
  group_by(Annee_enquete) %>% 
  mutate(mediane_h = max(mediane_h, na.rm = TRUE)) # création de la médiane des heures travaillées par les individus à plein temps pour chaque année

df_merged <- df_merged %>%
  mutate(EQTP = Volume_travail_habituel/mediane_h) %>% # création du coefficient d'équivalent temps plein (linéaire: variable continue)
  mutate(EQTP = ifelse(EQTP>1, 1, EQTP))%>%
  mutate(EQTP = ifelse(is.na(heures_clean), NA_real_, EQTP))

summary(df_merged$EQTP)

df_merged <- df_merged %>%
  mutate(Poids_final = EQTP*COEFF) # création du poids final égal au coeff initial de l'enquête x le coeff d'ETP

summary(df_merged$Poids_final)

df_merged <- df_merged %>%
  select(-ETP) # suppression de la variable ETP, conservation des autres variables


data_merged<- as.data.table(df_merged)
