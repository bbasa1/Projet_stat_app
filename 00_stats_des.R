################################################################################
################### PROGRAMMES POUR LE STATP ################################
################################################################################

# Ce chapeau contient l ensemble des programmes du statp

################################################################################
 #                      PREAMBULE               ===============================
################################################################################


################################################################################
#            A. PARAMETRES              -------------------------------
################################################################################
# repgen <- "C:/Users/Benjamin/Desktop/Ensae/Projet_statapp"#BB
repgen <- "C:/Users/Lenovo/Desktop/statapp22"#LP
# repgen <- "/Users/charlottecombier/Desktop/ENSAE/Projet_statapp"


liste_annees <- 1998:2018
pays <- "ES"

nom_fichier_html <- paste("Taux_activite", pays, sep = "_")

creer_base <- FALSE
mettre_coeffs_nan_a_zero <- TRUE


repo_prgm <- paste(repgen, "programmes/Projet_stat_app" , sep = "/")

repo_sorties <- paste(repgen, "sorties" , sep = "/")

repo_data <- paste(repgen, "Data" , sep = "/")

repo_inter <- paste(repgen, "bases_intermediaires" , sep = "/")

rep_html <- paste(repgen, "pages_html" , sep="/")

liste_variables <- c('QHHNUM', #Identifiant ménage
                     # 'COEFFY', #Yearly weighting factor,
                     # 'COEFFH', #Yearly weighting factor of the sample for household characteristics
                     'COEFF',
                     'COUNTRY',
                     'SEX',
                     'YEAR',
                     # 'YEARBIR', #Année de naissance
                     'AGE',
                     'YSTARTWK', # Year in which person started working for this employer or as self-employed. 9999 not applicable
                     'ILOSTAT', # ILO working status. 1 = employed. 2 = Unemployed. 3 = inactive. 4 = Compulsory military service. 5 = persons < 15 years old
                     'WSTATOR', # Labor status during the reference week (for aged >15 years). 1 = worked at least 1 hours. 2 =  Vacances/service militaire/... 3 = licencicé. 4 = Service militaire ou civique. 5 = Autre.
                     'WANTWORK', # Willingness to work for person not seeking employment. 1 = but would nevertheless like to have work. 2 = does not want to have work. 9 = not applicable
                     'WISHMORE', # Wish to work usually more than the current number of hours. 0 = No. 1 = Yes
                     'AVAILBLE', # Availability to start working within two weeks if work were found now. 1 = Could start to work immediately. 2 = could not start
                     'SEEKWORK', # Seeking employment during previous four weeks. 1 = Person has already found a job which will start within a period of at most 3 months. 2 = Person has already found a job which will start in more than 3 months. 3 = Person is not seeking employment and has not found
                     # any job to start late. 4 = Person is seeking employment
                     # 'SEEKREAS', # Reasons for not searching an employment because. 1 = awaiting recall to work (persons on lay-off). 2 = of own illness or disability. 3 = looking after children or incapacitated adults (from 2006). 4 = of other personal or family responsibilities. 5 = of education or training. 6 = of retirement. 7 = of belief that no work is available. 8 = of other reasons
                     'DEGURBA', # Degree of urbanisation. 1 = Densely. 2 = intermediate. 3 = rural
                     'STAPRO', #Professional status. 1 = Self-employed with employees. 2 = Self-employed without employees. 3 = Employee. 4 = Family worker. 
                     'FTPT', # 1 = Full-time. 2 = Part-time job.
                     'ISCO3D',
                     'TEMP', # 1 = CDI. 2 = CDD
                     'TEMPDUR', # Total duration of temporary job or work contract of limited duration. 1 = Less than one month. 2 =1 to 3 months. 3 = 4 to 6 months. 4 = 7 to 12 months = 17. 5 = 13 to 18 months. 6 = 19 to 24 months. 7 = 25 to 36 months. 8 = More than 3 years
                     'FTPTREAS', # Reasons for the part-time job 1 = Person is undergoing school education or training. 2 = Of own illness or disability. 3 =Looking after children or incapacitated adults. 4 = Other family or personal reasons (from 2006). 5 = Person could not find a full-time job. 6 = Other
                     'HWWISH', # Number of hours that the person would like to work in total
                     'HWUSUAL', # Number of hours per week usually worked in the main job
                     'HWACTUAL', # Number of hours actually worked during the reference week in the main job
                     'HWACTUA2', # Number of hours actually worked during the reference week in the second job
                     'INCDECIL', # Monthly (take home) pay from main job
                     'NEEDCARE', # Person is not searching for a job or is working part time because. 1 = Suitable care services for children are not available or affordable. 2 = Suitable care services for ill, disabled, elderly are not available or affordable. 3 = Suitable care services for both children and ill, disabled and elderly are not available or affordable.. 4 = Care facilities do not influence decision for working part time or not searching for a job
                     'HATLEV1D', # Level of education. L = low. M = Medium. H = High
                     'HATFIELD', #Field of education. Different codes before and after 2003
                     'HHNBCH2', # Number of children [0,2] years in the household
                     'HHNBCH5', # Number of children  [3,5] years in the household
                     'HHNBCH8', # Number of children [6,8] years in the household
                     'HHNBCH11', # Number of children [9,11] years in the household
                     'HHNBCH14', # Number of children [12,14] years in the household
                     'HHNBCH17', # Number of children [15,17] years in the household
                     'HHNBCH24', # Number of children [18,24] years in the household
                     'NOWKREAS', # Reasons for not working while having a job (includes maternity and parentality leaves)
                     'LEAVREAS', # Reasons for leaving last job
                     'AVAIREAS', # Reasons for not being available within the two next weeks to come
                     'SIGNISAL', # Continuing receipt of the wage or salary (from 2006) 
                     # 'EMPSTAT', # Etre en emploi (variable filtre)
                     'TEMPREAS', # Raison pour être en CDD
                     'WSTAT1Y', # Situation pro un an avant l’enquête (emploi, chômage, …)
                     'STAPRO1Y', # Situation pro un an avant l'enquête (salarié, auto-entrepreneur, …)
                     'SEEKDUR', # Temps passé en recherche d’emploi
                     'HHCHILDR', # est ce qu'il y a des enfants dans le foyer ou est ce qu'ils sont dans un autre foyer'
                     'HHNBPERS', #  nombre total de personnes dans le ménages
                     'HHNB0014', # Number of children in the household (aged less than 15 years) 
                     'HATYEAR', # année ou on a fini ses études
                     'LOOKREAS', # raisons pour lesquels on veut trouver un autre job
                     'REGIONW', # région du travail (peut être faire des analyses en fonction de la ruralité etc?)
                     'MARSTAT', # statut marital
                     # 'ISCO4D', # numéro isco mais agrégé a priori 
                     'SIZEFIRM', # Pour compter en fnt de la taille de la boîte.
                     'NATIONAL', # Nationalité
                     'HHPARTNR', # est ce que le partenaire cohabite 
                     'SUPVISOR', # manageur ?
                     'TEMPAGCY', # indicateur du fait d'être "en agence d'intérim"
                     'SHIFTWK', # Shift work 
                     'EVENWK', # Evening work 
                     'NIGHTWK', # Night work 
                     'SATWK', # Saturday work 
                     'SUNWK', # Sunday work 
                     'EXIST2J', # existence de plusieurs emplois
                     'HHWKSTAT', #  Working status of adults living in the same household 
                     'HHAGEYG', # Age of the youngest child in the household (aged less than 25 years) 
                     'HHPRIV' # Classification of individuals (private household members) - voir si on devreait pas filtré que sur les ménages ordinaires 

)

age_min <- 20
age_max <- 59

################################################################################
#            B. PACKAGES              -------------------------------
################################################################################

source(paste(repo_prgm , "01_packages.R" , sep = "/"))


################################################################################
#            I. CREATION OU IMPOERT DE LA BASE   ===============================
################################################################################
source(paste(repo_prgm , "02_creation_base.R" , sep = "/"))

# Soit on créé la table, soit on l'importe...
if(creer_base){
  data_merged <- fnt_creation_base_stats_des()
}else{
  nom_base <- paste(repo_data, "/data_intermediaire/base_", pays, ".Rdata", sep = "")
  load(file = nom_base)
}



################################################################################
#            II. NETTOYAGE, PREPARATION                        ===============================
################################################################################

source(paste(repo_prgm , "03_nettoyage.R" , sep = "/"))
# 100 * nrow(data_merged[is.na(COEFF), ])/nrow(data_merged)

data_merged <- calcul_EQTP(data_merged)



################################################################################
#            III. CALCULS TAUX D'EMPLOIS ET ACTIVITE PAR ÂGE ET SEXE  ===============================
################################################################################

#            III.A Préparation               ------------------

# On récupère les fonctions
source(paste(repo_prgm , "04_calculs_tables.R" , sep = "/"))

# On initialise une liste de graphes vides
list_graph <- list()
longueur_liste <- 0

# On calcule les taux d'activités et d'emplois par âge et sexe
liste_var <- c("Age_tranche", "Sexe_1H_2F")
calculs_age <- calcul_taux_emplois_activite(liste_var_groupby = liste_var, data_loc = data_merged)
# Sauf erreur il faut multiplir le taux d'emploi en etp par 100 (la population aussi ?): 
calculs_age$tx_emploi_etp <- calculs_age$tx_emploi_etp*100 
calculs_age$population_emplois_etp <- calculs_age$population_emplois_etp*100 
calculs_age

#           III.B CONSTRUCTION GRAPHIQUES               ------------------
source(paste(repo_prgm , "05_sorties_graphiques.R" , sep = "/"))


# Phase de nettoyage
calculs_age <- nettoyage_tranche_age(calculs_age, age_min, age_max)
calculs_age <- nettoyage_sexe(calculs_age)
calculs_age
# calculs_age <- as.data.table(calculs_age)


# Puis de tracé
titre <- paste("Taux d'activité par âge et par sexe,\n moyenne entre", toString(liste_annees[1]), "et", toString(tail(liste_annees, n=1)), "\n (", dico_pays[pays], ")")
titre_save <- paste(pays, "Taux_activite_age_sexe.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Age_tranche"
sortby_x <- "Indice_ages"
y <- "tx_activite"
fill <- "Sexe"
xlabel <-"Tranche d'âge"
ylabel <-"Taux d'activité"

graph <- trace_barplot(calculs_age, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save)
list_graph[[longueur_liste + 1]] <- graph # Il faut faire ça pour stacker les ggplot et ensuite les sauvegarder
longueur_liste <- longueur_liste + 1



# Second tracé 
titre <- paste("Taux d'emploi par âge et par sexe,\n moyenne entre", toString(liste_annees[1]), "et", toString(tail(liste_annees, n=1)), "\n (", dico_pays[pays], ")")
titre_save <- paste(pays, "Taux_emploi_age_sexe.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Age_tranche"
sortby_x <- "Indice_ages"
y <- "tx_emploi"
fill <- "Sexe"
xlabel <-"Tranche d'âge"
ylabel <-"Taux d'emploi"

graph <- trace_barplot(calculs_age, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save)
list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1



# Troisième
titre <- paste("Taux d'emploi ETP par âge et par sexe,\n moyenne entre", toString(liste_annees[1]), "et", toString(tail(liste_annees, n=1)), "\n (", dico_pays[pays], ")")
titre_save <- paste(pays, "Taux_emploi_etp_age_sexe.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Age_tranche"
sortby_x <- "Indice_ages"
y <- "tx_emploi_etp"
fill <- "Sexe"
xlabel <-"Tranche d'âge"
ylabel <-"Taux d'emploi"

graph <- trace_barplot(calculs_age, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save)
list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1

# Attention, il faut reprendre le calcul des ETP, il y a un problème a priori (les parts sont trop faibles)
# j'ai multiplié par 100 mais apparement ce n'est pas le pb : poids en continue qui baisse la valeurs ? 
# il faut regarder la distribution des heures obtenues + des poids + contrôler l'indicateur (est ce qu'on a le bon numérateur et le bon dénominateur)
head(data_merged$Poids_final,20)
head(data_merged$COEFF,20)
head(data_merged$EQTP,20)
# A priori en regardant rapidement je ne vois pas de problème sur l'indicateur 
# MAIS LES POIDS_FINAUX ME PARAISSENT TRES FAIBLES : a mon avis il y a un problème a ce niveau
# Je pense qu'il faut reprendre la variable EQTP (peut être un problème d'échelle) 

################################################################################
#            IV. CALCULS TAUX D'EMPLOIS ET ACTIVITE PAR ÂGE, SEXE & ANNEE D'ENQUETE  ===============================
################################################################################

#            IV.A Préparation               ------------------


# On calcule les taux d'activités et d'emplois par âge et sexe
liste_var <- c("Age_tranche", "Sexe_1H_2F", "Annee_enquete")
calculs_annee <- calcul_taux_emplois_activite(liste_var_groupby = liste_var, data_loc = data_merged)

#            IV.B CONSTRUCTION GRAPHIQUES               ------------------
calculs_annee
# Phase de nettoyage
calculs_annee <- nettoyage_tranche_age(calculs_annee, age_min, age_max)
calculs_annee <- nettoyage_sexe(calculs_annee)


# Puis de tracé
titre <- paste("Taux d'activité par âge, sexe et année d'enquête", "\n (", dico_pays[pays], ")")
titre_save <- paste(pays, "Taux_activite_age_sexe_annee_enqu.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "tx_activite"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Taux d'activité"
facet <- "Age_tranche"
ordre_facet <- c()


graph <- trace_barplot_avec_facet(calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet, ordre_facet)
list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1




# Second tracé 
titre <- paste("Taux d'emploi par âge, sexe et année d'enquête", "\n (", dico_pays[pays], ")")
titre_save <- paste(pays, "Taux_emploi_age_sexe_annee_enqu.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "tx_emploi"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Taux d'emploi"
facet <- "Age_tranche"
ordre_facet <- c()


graph <- trace_barplot_avec_facet(calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet, ordre_facet)
list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1


# Troisième tracé 
titre <- paste("Taux d'emploi ETP par âge, sexe et année d'enquête", "\n (", dico_pays[pays], ")")
titre_save <- paste(pays, "Taux_emploi_etp_age_sexe_annee_enqu.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "tx_emploi_etp"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Taux d'emploi"
facet <- "Age_tranche"
ordre_facet <- c()


graph <- trace_barplot_avec_facet(calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet, ordre_facet)
list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1

################################################################################
#            VI. QUID DU NIVEAU D'EDUCATION ?  ===============================
################################################################################

# On calcule les taux d'activités et d'emplois par âge et sexe
liste_var <- c("Niveau_education", "Sexe_1H_2F", "Annee_enquete")

# sous_data_merged <- data_merged[Age_tranche %in% c(22, 27, 32, 37, 42, 47, 52, 57)]
sous_data_merged <- data_merged[Age_tranche - 2 >= age_min, ]
sous_data_merged <- sous_data_merged[Age_tranche + 2 <= age_max, ]

calculs_annee <- calcul_taux_emplois_activite(liste_var_groupby = liste_var, data_loc = sous_data_merged)
# Phase de nettoyage
calculs_annee <- nettoyage_niveau_education(calculs_annee)
calculs_annee <- nettoyage_sexe(calculs_annee)
sous_calculs_annee <- calculs_annee[Niveau_education %in% c("Bas","Moyen", "Elevé")]
sous_calculs_annee <- ff_interaction(sous_calculs_annee, Niveau_education, Sexe)


# Puis de tracé
titre <- paste("Taux d'activité par niveau d'éducation,\n sexe et année d'enquête (entre", age_min, "et", age_max, "ans)", "\n (", dico_pays[pays], ")", sep = " ")
titre_save <- paste(pays, "Taux_activite_educ_sexe_annee_enqu.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "tx_activite"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Taux d'activité"
facet <- "Niveau_education"
ligne <- "Niveau_education_Sexe"
ordre_facet <- c("Bas", "Moyen", "Elevé")

graph <- trace_barplot_avec_facet(sous_calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet, ordre_facet)
list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1



titre <- paste("Taux d'emploi par niveau d'éducation,\n sexe et année d'enquête (entre", age_min, "et", age_max, "ans)", "\n (", dico_pays[pays], ")", sep = " ")
titre_save <- paste(pays, "Taux_emploi_educ_sexe_annee_enqu.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "tx_emploi"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Taux d'emploi"
facet <- "Niveau_education"
ligne <- "Niveau_education_Sexe"
ordre_facet <- c("Bas", "Moyen", "Elevé")

graph <- trace_barplot_avec_facet(sous_calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet, ordre_facet)
list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1




titre <- paste("Taux d'emploi ETP par niveau d'éducation,\n sexe et année d'enquête (entre", age_min, "et", age_max, "ans)", "\n (", dico_pays[pays], ")", sep = " ")
titre_save <- paste(pays, "Taux_emploi_etp_educ_sexe_annee_enqu.pdf", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "tx_emploi_etp"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Taux d'emploi"
facet <- "Niveau_education"
ligne <- "Niveau_education_Sexe"
ordre_facet <- c("Bas", "Moyen", "Elevé")

graph <- trace_barplot_avec_facet(sous_calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet, ordre_facet)
list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1

################################################################################
#      On passe en version graphique à lignes ----------------------------------
################################################################################
# 
# 
# # On calcule les taux d'activités et d'emplois par âge et sexe
# liste_var <- c("Niveau_education", "Sexe_1H_2F", "Annee_enquete")
# 
# sous_data_merged <- data_merged[Age_tranche - 2 >= age_min, ]
# sous_data_merged <- sous_data_merged[Age_tranche + 2 <= age_max, ]
# 
# calculs_annee <- calcul_taux_emplois_activite(liste_var_groupby = liste_var, data_loc = sous_data_merged)
# # Phase de nettoyage
# calculs_annee <- nettoyage_niveau_education(calculs_annee)
# calculs_annee <- nettoyage_sexe(calculs_annee)
# sous_calculs_annee <- calculs_annee[Niveau_education %in% c("Bas","Moyen", "Elevé")]
# sous_calculs_annee <- ff_interaction(sous_calculs_annee, Niveau_education, Sexe)
# 
# 
# # Puis de tracé
# titre <- paste("Taux d'activité par niveau d'éducation,\n sexe et année d'enquête (entre", age_min, "et", age_max, "ans)", sep = " ")
# titre_save <- paste(pays, "Taux_activite_educ_sexe_annee_enqu.pdf", sep ='_')
# titre_save <- paste(repo_sorties, titre_save, sep ='/')
# x <-"Annee_enquete"
# sortby_x <- "Annee_enquete"
# y <- "tx_activite"
# fill <- "Sexe"
# xlabel <-"Année d'enquête"
# ylabel <-"Taux d'activité"
# ligne <- "Niveau_education_Sexe"
# 
# graph <- trace_point_lines(sous_calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, ligne)
# list_graph[[longueur_liste + 1]] <- graph
# longueur_liste <- longueur_liste + 1
# 
# 
# 
# titre <- paste("Taux d'emploi par niveau d'éducation,\n sexe et année d'enquête (entre", age_min, "et", age_max, "ans)", sep = " ")
# titre_save <- paste(repo_sorties, "Taux_emploi_educ_sexe_annee_enqu.pdf", sep ='/')
# x <-"Annee_enquete"
# sortby_x <- "Annee_enquete"
# y <- "tx_emploi"
# fill <- "Sexe"
# xlabel <-"Année d'enquête"
# ylabel <-"Taux d'emploi"
# ligne <- "Niveau_education_Sexe"
# 
# graph <- trace_point_lines(sous_calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, ligne)
# list_graph[[longueur_liste + 1]] <- graph
# longueur_liste <- longueur_liste + 1
# 
# 
# titre <- paste("Taux d'emploi ETP par niveau d'éducation,\n sexe et année d'enquête (entre", age_min, "et", age_max, "ans)", sep = " ")
# titre_save <- paste(repo_sorties, "Taux_emploi_educ_sexe_annee_enqu.pdf", sep ='/')
# x <-"Annee_enquete"
# sortby_x <- "Annee_enquete"
# y <- "tx_emploi_etp"
# fill <- "Sexe"
# xlabel <-"Année d'enquête"
# ylabel <-"Taux d'emploi"
# ligne <- "Niveau_education_Sexe"
# 
# graph <- trace_point_lines(sous_calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, ligne)
# list_graph[[longueur_liste + 1]] <- graph
# longueur_liste <- longueur_liste + 1
# 

################################################################################
#            V. SORTIES HTML  ===============================
################################################################################


source(paste(repo_prgm,"06_page_html.R",sep="/") , 
       encoding = "UTF-8" )




################################################################################
#         VII. Brouillon à mettre en forme ========================
################################################################################
# 
# liste_var <- c("Decile_salaire", "Niveau_education", "Sexe_1H_2F", "COEFF", "Identifiant_menage")
# 
# pop_en_emploi <- data_merged[(Statut_emploi_1_emploi == 1) & Decile_salaire != '99',]
# pop_en_emploi <- pop_en_emploi[,..liste_var]
# nrow(pop_en_emploi)
# 
# 
# sapply(pop_en_emploi, class) # Check classes of data table columns
# pop_en_emploi <- pop_en_emploi[ , Decile_salaire := as.numeric(Decile_salaire)]
# 
# pop_en_emploi
# sous_pop <- pop_en_emploi[, .("Decile_mean" = mean(Decile_salaire, na.rm = TRUE),
#                               "Decile_med" = median(Decile_salaire, na.rm = TRUE)),
#               by = .(Niveau_education, Sexe_1H_2F)]
# 
# sous_pop[, Niveau_education_chiffre := factor(
#   fcase(
#     Niveau_education == "L", -1,
#     Niveau_education == "M", 0,
#     Niveau_education == "H", 1
#   )
# )
# ]
# 
# sous_pop[, Sexe_1H_2F := factor(
#   fcase(
#     Sexe_1H_2F == 1, "Hommes",
#     Sexe_1H_2F == 2, "Femmes"
#     )
# )
# ]
# 
# 
# sous_pop
# sous_pop_melted <- melt(sous_pop, measure.vars = c("Decile_med", "Decile_mean"),
#                         variable.name = "Mesure") 
# 
# sapply(sous_pop_melted, class) # Check classes of data table columns
# sous_pop_melted <- sous_pop_melted[ , value := as.numeric(value)]
# sous_pop_melted <- sous_pop_melted[ , Niveau_education_chiffre := as.numeric(Niveau_education_chiffre)]
# sous_pop_melted <- sous_pop_melted[ , Sexe_1H_2F := as.factor(Sexe_1H_2F )]
# 
# setnames(sous_pop_melted,'Sexe_1H_2F',"Sexe")
# sous_pop_melted[, Mesure := factor(
#   fcase(
#     Mesure == "Decile_mean", "Décile de salaire moyen",
#     Mesure == "Decile_med", "Décile de salaire médian"
#   )
# )
# ]
# 
# 
# sous_pop_melted
# 
# 
# p <- ggplot(data = sous_pop_melted, aes(x = reorder(Niveau_education, Niveau_education_chiffre), y = value, fill = Sexe)) +
#   geom_bar(stat="identity", position=position_dodge()) + 
#   labs(title= 'Salaires en fonction du sexe et du niveau d\'études',
#        x= 'Niveau d\'études',
#        y= 'Décile de salaire') + 
#   scale_y_continuous(limits = c(0, 10), labels = function(y) format(y, scientific = FALSE)) + 
#   scale_fill_discrete() +
#   scale_color_viridis() +
#   theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1)) +
#   facet_wrap(~Mesure)
# 
# p

################################################################################
#            VIII. Analyse de la situation familiale  ==========================
################################################################################
# Pensez a regarder le taux de chômage aussi avant - pour que ce soit plus facilement lisible qu'en croisant taux d'activité et taux d'emploi
# Henri avait filtré les gens qui sont encore en études (initiales) - est ce qu'on fait pareil ? 
# Est ce que l'on se recentre sur les ménages ordinaire ? 

# Comme on est sur des données pondérées que l'on ne veut pas retraiter à la main on va passer par le package survey 
# Utile aussi pour faire des regressions pondérées 

#On prépare les données avec le plan d'échantillonage : 
dw <- svydesign(ids = ~1, data = sous_data_merged, weights = ~ sous_data_merged$COEFF)

# Faire les stats de base : avoir la part de femmes et hommes par âge en pondéré, le nombre de famille avec enfants
# Le nombre de famille monop, les familles avec des enfants en bas âge

# Est ce que le taux d'activité, d'emploi et d'emploi ETP des femmes et des hommes varient selon le statut martital ?
# Tester en couple, en couple cohabitant et mariés si possible 

# Est ce que le taux d'activité, d'emploi et d'emploi ETP des femmes et des hommes varient selon le nombre d'enfant à charge ?
# Trier sur les mineurs, à charge (au domicile) et le nombre 1,2 et 3 
# Tester aussi selon l'âge des enfants : nombre de moins de trois ans, nombre de moins de 6 ans (et autre - voir tester les majeurs avec nombre de plus de 18 ans)

# si déterminant regarder l'évolution du nombre d'enfant en moyenne sur toute la population, sur les moins diplomés et chez les plus diplomés 
# si possible créer une variable csp du couple / diplome du couple et une variable couple biactif ou non 

# Faire une analyse plus spécifique du temps partiel (attention ca peut aussi entrer dans la partie suivante) : 
# avec le fait d'être en couple marié/cohabitant, d'avoir des enfants, dont en bas âges, voir si on a une variable congé parental 
# voir si on a les raisons de ce temps partiel, regarder si ces personnes souhaiteraient travailler plus ou chnager d'emploi et pourquoi 

################################################################################
#            IX. Analyse de l'évolution de la qualité de l'emploi  ============
################################################################################

#  idem comencer par les stats gloables pour avoir une vue d'ensemble 

# Comment varie la proportion de temps partiel dans le temps selon l'âge et le sexe ?
# Comment varie la proportion de CDI dans le temps selon l'âge et le sexe ? 
# idem autre type de contrat : CDD, intérim - voir comment cela change selon la législation par pays 
# existence de plusieurs emploi ?
# Faire les different croisements avec les variables de postes atypiques

# Si on voit une évolution marquante, regarder par qui elle est porté dans chaque sous-population : 
# les familles monoparentales, les familles avec jeunes enfants, au contraire les personnes seules, les moins diplomées etc.

# On peut aussi essayer d'explorer le type d'emploi par le secteur dans cette partie / voir si ca vaut le temps de travail : peut être ciblé que certains secteurs