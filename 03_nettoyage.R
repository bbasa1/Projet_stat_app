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
try(setnames(data_merged,'HHNBCH17',"Nb_enfants_entre_15_17_ans"), silent=TRUE)
try(setnames(data_merged,'HHNBCH24',"Nb_enfants_entre_18_24_ans"), silent=TRUE)

try(setnames(data_merged,'FTPTREAS',"Raisons_temps_partiel"), silent=TRUE)
# try(setnames(data_merged,'SEEKREAS',"Raisons_recherche_emploi"), silent=TRUE)
try(setnames(data_merged,'NOWKREAS',"Raisons_emploi_mais_pas_travail"), silent=TRUE)
try(setnames(data_merged,'LEAVREAS',"Raisons_démission"), silent=TRUE)
try(setnames(data_merged,'AVAIREAS',"Raisons_indisponibilité_travail"), silent=TRUE)


try(setnames(data_merged,'DEGURBA',"Dregre_urbanisation"), silent=TRUE)

try(setnames(data_merged,'SIGNISAL',"Absence_et_salaire_2006"), silent=TRUE)
try(setnames(data_merged,'TEMPREAS',"raison_cdd"), silent=TRUE)
try(setnames(data_merged,'WSTAT1Y',"sit_pro_avant_enq"), silent=TRUE)
try(setnames(data_merged,'STAPRO1Y',"statu_pro_avant_enq"), silent=TRUE)
try(setnames(data_merged,'SEEKDUR',"temp_recherche_emp"), silent=TRUE)
try(setnames(data_merged,'HHCHILDR',"dom_enf"), silent=TRUE)
try(setnames(data_merged,'HHNBPERS',"nb_pers_men"), silent=TRUE)
try(setnames(data_merged,'HHNB0014',"nb_enf_m15"), silent=TRUE)
try(setnames(data_merged,'HATYEAR',"annee_fin_etude"), silent=TRUE)
try(setnames(data_merged,'LOOKREAS',"raison_changer_job"), silent=TRUE)
try(setnames(data_merged,'REGIONW',"region_travail"), silent=TRUE)
try(setnames(data_merged,'MARSTAT',"statu_marital"), silent=TRUE)
try(setnames(data_merged,'SIZEFIRM',"taille_ent"), silent=TRUE)
try(setnames(data_merged,'NATIONAL',"nationalit"), silent=TRUE)
try(setnames(data_merged,'HHPARTNR',"couple_cohab"), silent=TRUE)
try(setnames(data_merged,'SUPVISOR',"travail_respon"), silent=TRUE)
try(setnames(data_merged,'TEMPAGCY',"travail_interim"), silent=TRUE)
try(setnames(data_merged,'SHIFTWK',"travail_3_8"), silent=TRUE) 
try(setnames(data_merged,'EVENWK',"travail_soiree"), silent=TRUE)
try(setnames(data_merged,'NIGHTWK',"travail_nuit"), silent=TRUE)
try(setnames(data_merged,'SATWK',"travail_samedi"), silent=TRUE)
try(setnames(data_merged,'SUNWK',"travail_dimanche"), silent=TRUE)
try(setnames(data_merged,'EXIST2J',"exist_autre_emploi"), silent=TRUE)
try(setnames(data_merged,'HHWKSTAT',"statu_emp_adulte_men"), silent=TRUE)
try(setnames(data_merged,'HHAGEYG',"age_enf_plus_jeune"), silent=TRUE)
try(setnames(data_merged,'HHPRIV',"menage_ordinaire"), silent=TRUE)
try(setnames(data_merged,'MAINSTAT',"statut_travail"), silent=TRUE)
try(setnames(data_merged,'HHCOMP',"compo_men_v1"), silent=TRUE)

######### Recoder les variables avec des modalités NA et non concerné ######################
# on a choisi de recoder les na ou les "hors sujets" systhématiquement en 9999 (si ce n'était pas déjà le cas)
# sauf dans le cas du nombre d'enfant : on met plutot 0 pour simplifier les calculs après 

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
try(data_merged <- data_merged[Nb_enfants_moins_2_ans == "99", Nb_enfants_moins_2_ans  := "00"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_moins_2_ans ), Nb_enfants_moins_2_ans  := "00"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_3_5_ans  := Nb_enfants_entre_3_5_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_3_5_ans == "99", Nb_enfants_entre_3_5_ans  := "0"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_3_5_ans ), Nb_enfants_entre_3_5_ans  := "0"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_6_8_ans  := Nb_enfants_entre_6_8_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_6_8_ans == "99", Nb_enfants_entre_6_8_ans  := "00"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_6_8_ans ), Nb_enfants_entre_6_8_ans  := "00"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_9_11_ans  := Nb_enfants_entre_9_11_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_9_11_ans == "99", Nb_enfants_entre_9_11_ans  := "00"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_9_11_ans ), Nb_enfants_entre_9_11_ans  := "00"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_11_14_ans  := Nb_enfants_entre_11_14_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_11_14_ans == "99", Nb_enfants_entre_11_14_ans  := "00"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_11_14_ans ), Nb_enfants_entre_11_14_ans  := "00"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_15_17_ans  := Nb_enfants_entre_15_17_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_15_17_ans == "99", Nb_enfants_entre_15_17_ans  := "00"], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_15_17_ans == "9999", Nb_enfants_entre_15_17_ans  := "00"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_15_17_ans ), Nb_enfants_entre_15_17_ans  := "00"], silent=TRUE)

try(data_merged <- data_merged[, Nb_enfants_entre_18_24_ans  := Nb_enfants_entre_18_24_ans], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_18_24_ans == "99", Nb_enfants_entre_18_24_ans  := "00"], silent=TRUE)
try(data_merged <- data_merged[Nb_enfants_entre_18_24_ans == "9999", Nb_enfants_entre_18_24_ans  := "00"], silent=TRUE)
try(data_merged <- data_merged[is.na(Nb_enfants_entre_18_24_ans ), Nb_enfants_entre_18_24_ans  := "00"], silent=TRUE)

try(data_merged <- data_merged[, Domaine_education  := Domaine_education], silent=TRUE)
try(data_merged <- data_merged[Domaine_education == "99", Domaine_education  := "9999"], silent=TRUE)
try(data_merged <- data_merged[Domaine_education == "999", Domaine_education  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Domaine_education ), Domaine_education  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Raisons_emploi_mais_pas_travail  := Raisons_emploi_mais_pas_travail], silent=TRUE)
try(data_merged <- data_merged[Raisons_emploi_mais_pas_travail == "99", Raisons_emploi_mais_pas_travail  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Raisons_emploi_mais_pas_travail ), Raisons_emploi_mais_pas_travail  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Raisons_démission  := Raisons_démission], silent=TRUE)
try(data_merged <- data_merged[Raisons_démission == "99", Raisons_démission  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Raisons_démission ), Raisons_démission  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Raisons_indisponibilité_travail  := Raisons_indisponibilité_travail], silent=TRUE)
try(data_merged <- data_merged[Raisons_indisponibilité_travail == "9", Raisons_indisponibilité_travail  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Raisons_indisponibilité_travail ), Raisons_indisponibilité_travail  := "9999"], silent=TRUE)

# try(data_merged <- data_merged[, Raisons_recherche_emploi  := Raisons_recherche_emploi], silent=TRUE)
# try(data_merged <- data_merged[Raisons_recherche_emploi == "99", Raisons_recherche_emploi  := "9999"], silent=TRUE)
# try(data_merged <- data_merged[is.na(Raisons_recherche_emploi ), Raisons_recherche_emploi  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, Absence_et_salaire_2006  := Absence_et_salaire_2006], silent=TRUE)
try(data_merged <- data_merged[Absence_et_salaire_2006 == "9", Absence_et_salaire_2006  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(Absence_et_salaire_2006), Absence_et_salaire_2006  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, raison_cdd  := raison_cdd], silent=TRUE)
try(data_merged <- data_merged[raison_cdd == "9", raison_cdd  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(raison_cdd), raison_cdd  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, sit_pro_avant_enq  := sit_pro_avant_enq], silent=TRUE)
try(data_merged <- data_merged[sit_pro_avant_enq == "9", sit_pro_avant_enq  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(sit_pro_avant_enq), sit_pro_avant_enq  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, statu_pro_avant_enq  := statu_pro_avant_enq], silent=TRUE)
try(data_merged <- data_merged[statu_pro_avant_enq == "9", statu_pro_avant_enq  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(statu_pro_avant_enq), statu_pro_avant_enq  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, temp_recherche_emp  := temp_recherche_emp], silent=TRUE)
try(data_merged <- data_merged[temp_recherche_emp == "9", temp_recherche_emp  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(temp_recherche_emp), temp_recherche_emp  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, dom_enf  := dom_enf], silent=TRUE)
try(data_merged <- data_merged[dom_enf == "9", dom_enf  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(dom_enf), dom_enf  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, nb_pers_men  := nb_pers_men], silent=TRUE)
try(data_merged <- data_merged[nb_pers_men == "99", nb_pers_men  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(nb_pers_men), nb_pers_men  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, nb_enf_m15  := nb_enf_m15], silent=TRUE)
try(data_merged <- data_merged[nb_enf_m15 == "99", nb_enf_m15  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(nb_enf_m15), nb_enf_m15  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, raison_changer_job  := raison_changer_job], silent=TRUE)
try(data_merged <- data_merged[raison_changer_job == "9", raison_changer_job  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(raison_changer_job), raison_changer_job  := "9999"], silent=TRUE)

# Pour la variable REGIONW je ne sais pas comment la retraiter 

try(data_merged <- data_merged[, taille_ent  := taille_ent], silent=TRUE)
try(data_merged <- data_merged[taille_ent == "99", taille_ent  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(taille_ent), taille_ent  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, couple_cohab  := couple_cohab], silent=TRUE)
try(data_merged <- data_merged[couple_cohab == "9", couple_cohab  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(couple_cohab), couple_cohab  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, travail_respon  := travail_respon], silent=TRUE)
try(data_merged <- data_merged[travail_respon == "9", travail_respon  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(travail_respon), travail_respon  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, travail_interim  := travail_interim], silent=TRUE)
try(data_merged <- data_merged[travail_interim == "9", travail_interim  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(travail_interim), travail_interim  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, travail_3_8  := travail_3_8], silent=TRUE)
try(data_merged <- data_merged[travail_3_8 == "9", travail_3_8  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(travail_3_8), travail_3_8  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, travail_soiree  := travail_soiree], silent=TRUE)
try(data_merged <- data_merged[travail_soiree == "9", travail_soiree  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(travail_soiree), travail_soiree  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, travail_nuit  := travail_nuit], silent=TRUE)
try(data_merged <- data_merged[travail_nuit == "9", travail_nuit  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(travail_nuit), travail_nuit  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, travail_samedi  := travail_samedi], silent=TRUE)
try(data_merged <- data_merged[travail_samedi == "9", travail_samedi  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(travail_samedi), travail_samedi  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, travail_dimanche  := travail_dimanche], silent=TRUE)
try(data_merged <- data_merged[travail_dimanche == "9", travail_dimanche  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(travail_dimanche), travail_dimanche  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, exist_autre_emploi  := exist_autre_emploi], silent=TRUE)
try(data_merged <- data_merged[exist_autre_emploi == "9", exist_autre_emploi  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(exist_autre_emploi), exist_autre_emploi  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, statu_emp_adulte_men  := statu_emp_adulte_men], silent=TRUE)
try(data_merged <- data_merged[statu_emp_adulte_men == "9", statu_emp_adulte_men  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(statu_emp_adulte_men), statu_emp_adulte_men  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, age_enf_plus_jeune  := age_enf_plus_jeune], silent=TRUE)
try(data_merged <- data_merged[age_enf_plus_jeune == "99", age_enf_plus_jeune  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(age_enf_plus_jeune), age_enf_plus_jeune  := "9999"], silent=TRUE)

try(data_merged <- data_merged[, statut_travail  := statut_travail], silent=TRUE)
try(data_merged <- data_merged[statut_travail == 9 , statut_travail  := 9999], silent=TRUE)
try(data_merged <- data_merged[is.na(statut_travail), statut_travail  := 9999], silent=TRUE)

try(data_merged <- data_merged[, compo_men_v1  := compo_men_v1], silent=TRUE)
try(data_merged <- data_merged[compo_men_v1 == "99" , compo_men_v1  := "9999"], silent=TRUE)
try(data_merged <- data_merged[is.na(compo_men_v1), compo_men_v1  := "9999"], silent=TRUE)

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
    mutate(Temps_partiel_clean = ifelse(Temps_partiel ==9, 0, Temps_partiel_clean)) %>% # Création de TP égale à 1 si temps plein, 0 si temps partiel
    mutate(ETP = ifelse(Temps_partiel_clean ==1, 1, 0)) %>%
    mutate(heures_clean = ifelse(Volume_travail_habituel ==99 | Volume_travail_habituel ==00, 0, Volume_travail_habituel)) %>% # création de heures clean, variable nettoyée du nombre d'heures travaillées habituellement
    group_by(Annee_enquete, Temps_partiel_clean) %>%
    mutate(mediane_h = median(heures_clean, na.rm = TRUE)) %>%
    group_by(Annee_enquete) %>%
    mutate(mediane_h = max(mediane_h, na.rm = TRUE)) # création de la médiane des heures travaillées par les individus à plein temps pour chaque année
  
  # summary(df_merged$EQTP)
  
  df_merged <- df_merged %>%
    mutate(EQTP = Volume_travail_habituel/mediane_h) %>% # création du coefficient d'équivalent temps plein (linéaire: variable continue)
    mutate(EQTP = ifelse(Statut_emploi_1_emploi==1, EQTP, 0)) %>%
    mutate(EQTP = ifelse(EQTP>1, 1, EQTP))%>%
    mutate(EQTP = ifelse(is.na(heures_clean), 0 , EQTP))
  
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

################################################################################
#              6 . Creation de nouvelles variables       =======================
################################################################################
# Passage en df pour les calculs

df_merged<- as.data.frame(data_merged)

#### relative à la famille : 

# Couple : célibataire, veuf/divorsé/séparé (et non remis en couple), marié, en couple cohab, en couple décohab 
table(df_merged$statu_marital, df_merged$couple_cohab)
# dans l'idéal mais en réalité difficile de comprendre la variable "couple" donc on laisse tomber pour l'instant

# Enfants : 
# Présence d'enfant de moins de trois ans 
df_merged$enf_m3ans <- 0 
data_merged <- data_merged[, enf_m3ans := 0] 
data_merged <- data_merged[Nb_enfants_moins_2_ans == "01", enf_m3ans := 1] 
data_merged <- data_merged[Nb_enfants_moins_2_ans == "02", enf_m3ans := 1]
data_merged <- data_merged[Nb_enfants_moins_2_ans == "03", enf_m3ans := 1]
data_merged <- data_merged[Nb_enfants_moins_2_ans == "04", enf_m3ans := 1]

# Présence d'enfant de moins de six ans
data_merged <- data_merged[, enf_m6ans := 0] 
data_merged <- data_merged[Nb_enfants_entre_3_5_ans == "01", enf_m6ans := 1] 
data_merged <- data_merged[Nb_enfants_entre_3_5_ans == "02", enf_m6ans := 1]
data_merged <- data_merged[Nb_enfants_entre_3_5_ans == "03", enf_m6ans := 1]
data_merged <- data_merged[Nb_enfants_entre_3_5_ans == "04", enf_m6ans := 1]

# Présence d'au moins un enfant
data_merged <- data_merged[, enf := 1] 
data_merged <- data_merged[age_enf_plus_jeune == "00", enf_m6ans := 0] 
data_merged <- data_merged[age_enf_plus_jeune == "9999", enf_m6ans := 0]

# Nombre d'enfants de moins de 24 ans dans le ménage
data_merged <- data_merged[, nb_enf_tot:= as.numeric(Nb_enfants_entre_18_24_ans)+as.numeric(Nb_enfants_entre_15_17_ans)+as.numeric(Nb_enfants_entre_11_14_ans)+as.numeric(Nb_enfants_entre_9_11_ans)+as.numeric(Nb_enfants_entre_6_8_ans)+as.numeric(Nb_enfants_moins_2_ans)+as.numeric(Nb_enfants_entre_3_5_ans)] 

# Nombre d'enfant avec 4 modalités : 0, 1, 2 ou plus de trois 
data_merged <- data_merged[, nb_enf := "3 et plus"] 
data_merged <- data_merged[nb_enf_tot == 0, nb_enf := "0"] 
data_merged <- data_merged[nb_enf_tot == 1, nb_enf := "1"]
data_merged <- data_merged[nb_enf_tot == 2, nb_enf := "2"]

# Test famille monop, ménage complexe en soustrayant enfant tot moins nombre de personne : 
data_merged <- data_merged[, nb_adulte_tot:= as.numeric(nb_pers_men) - nb_enf_tot] 
# Pas de nombre négatifs donc on peut travailler sur ca pour avoir une petite variable compo du ménage 

data_merged <- data_merged[, compo_men := "9999"] 
data_merged <- data_merged[nb_adulte_tot == 1 & nb_enf_tot >=1 , compo_men := "fam_monop"] 
data_merged <- data_merged[nb_adulte_tot == 1 & nb_enf_tot == 0, compo_men := "celibataire"]
data_merged <- data_merged[couple_cohab == 1 & nb_enf_tot == 0, compo_men := "couple"]
data_merged <- data_merged[couple_cohab == 1 & nb_enf_tot >= 1, compo_men := "couple_enf"]
data_merged <- data_merged[couple_cohab == 1 & nb_adulte_tot>=3, compo_men := "men_complexe"]
data_merged <- data_merged[couple_cohab == 2 & nb_adulte_tot>=2, compo_men := "men_complexe"]
# sans pondéré il me semble y avoir beaucoup de ménage complexe, on pourra comparer avec la variable de l'enquête 
# ou se débrouiller en croisant les deux 
# On pourrait aussi afiner avec la variable sur la présence d'enfant à l'exterieur mais je pense plus tot utiliser l'indicatrice directement 

# Sur l'emploi occupé en lien avec la famille (creation d'indicatrice): 
# A temps partiel pour s'occuper des enfants ou de sa famille
data_merged <- data_merged[, raisons_tp_enf_fam := 0] 
data_merged <- data_merged[Raisons_temps_partiel == 3, raisons_tp_enf_fam := 1] 
data_merged <- data_merged[Raisons_temps_partiel == 4, raisons_tp_enf_fam := 1]

# A un emploi mais ne travaille pas car en maternité ou en congé parental ou pour d'autres raisons personnelles ou familiales 
data_merged <- data_merged[, raisons_emp_no_trav_enf_fam := 0] 
data_merged <- data_merged[Raisons_emploi_mais_pas_travail == "05", raisons_emp_no_trav_enf_fam := 1] 
data_merged <- data_merged[Raisons_emploi_mais_pas_travail == "06", raisons_emp_no_trav_enf_fam := 1]
data_merged <- data_merged[Raisons_emploi_mais_pas_travail == "09", raisons_emp_no_trav_enf_fam := 1]

# A du démissioner à cause des enfants ou pour raison familiale, y compris grossesse
data_merged <- data_merged[, raison_dem_enf_fam := 0] 
data_merged <- data_merged[Raisons_démission == "02", raison_dem_enf_fam := 1] 
data_merged <- data_merged[Raisons_démission == "03", raison_dem_enf_fam := 1]

# Ne peut pas travailler à cause des enfants ou pour grossesse
data_merged <- data_merged[, raison_no_trav_enf_fam := 0] 
data_merged <- data_merged[Raisons_indisponibilité_travail == 4, raison_no_trav_enf_fam := 1] 

# Sur l'emploi occuper plus largement 
# A temps partiel car ne trouve pas un temps plein
data_merged <- data_merged[, raisons_tp_abs_plein := 0] 
data_merged <- data_merged[Raisons_temps_partiel == 5, raisons_tp_abs_plein := 1] 

# En CDD car ne trouve pas un emploi "pemranent"
data_merged <- data_merged[, raisons_cdd_trouve_ps_cdi:= 0] 
data_merged <- data_merged[raison_cdd == 2, raisons_cdd_trouve_ps_cdi := 1]

# Se déclare comme "au foyer"
data_merged <- data_merged[, sit_pro_foyer:= 0] 
data_merged <- data_merged[statut_travail == 7, sit_pro_foyer := 1]

# A été "au foyer"
data_merged <- data_merged[, sit_pro_avant_enq_foyer:= 0] 
data_merged <- data_merged[sit_pro_avant_enq == 7, sit_pro_avant_enq_foyer := 1]

# Depuis quand est ce que la personne est entrée sur le marché du travail totale (ie date enquête moins celle de fin d'étude)
data_merged <- data_merged[, dure_marche_trav_tot:= as.numeric(Annee_enquete) - as.numeric(annee_fin_etude)] 
data_merged <- data_merged[dure_marche_trav_tot <= 0, dure_marche_trav_tot := 0] 
# A voir si les cas bizarre sortie des études depuis très très longtemps ne sont pas des points abérents : filtre sur l'âge
# Avec la fin de l'année des études on pourrait calculer aussi le temps d'arriver des enfants etc
