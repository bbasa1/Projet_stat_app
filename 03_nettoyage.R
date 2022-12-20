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
