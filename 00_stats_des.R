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
repgen <- "C:/Users/Benjamin/Desktop/Ensae/Projet_statapp"#BB
# repgen <- "C:/Users/Lenovo/Desktop/statapp22"#LP
# repgen <- "/Users/charlottecombier/Desktop/ENSAE/Projet_statapp"


liste_annees <- 1998:2018
# Proposition periode : 
# 1998-2000
# 2001-2003
# 2004-2007
# 2008-2011
# 2012-2015
# 2016-2018 = référence ?
# Benjamin avait parlé de liste, on pourrait aussi pour la modélisation 
# créer une variable indicatrice par période ou à six modalités 
pays <- "FR"

nom_fichier_html <- paste("Taux_activite", pays, sep = "_")

creer_base <- TRUE
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
                     'ISCOPR3D',
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
                     'MAINSTAT', # Main status
                     'HHCOMP', # Composition du foyer = mais vraible a retraiter 
                     'HHLINK',# lien pers de réf
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
### Note Benja : Pour la France (au moins) il ne trouve pas HHPRIV, HHLINK, HATYEAR, MARSTAT

# On filtre sur la population d'intérêt :
data_merged <- data_merged[AGE - 2 >= age_min, ]
data_merged <- data_merged[AGE + 2 <= age_max, ]
data_merged <- data_merged[HHPRIV==1, ]
data_merged <- data_merged[HHLINK==1 | HHLINK==2, ]
# on filtre aussi sur les gens qui sont sorti d'études : ie l'année d'enquête est plus grande que l'année de fin d'études
# normalement les 9999 disparaissent et on a que 1555 cas de personnes qui finissent leurs études l'année d'enquête
# Ca me parait ok : table(data_merged$annee_fin_etude==data_merged$Annee_enquete )
data_merged <- data_merged[YEAR > HATYEAR, ]
# La version avec les variable renommées si besoin
# data_merged <- data_merged[Age_tranche - 2 >= age_min, ]
# data_merged <- data_merged[Age_tranche + 2 <= age_max, ]
# data_merged <- data_merged[menage_ordinaire==1, ]
# data_merged <- data_merged[lien_pers_ref==1 | lien_pers_ref==2, ]
# data_merged <- data_merged[Annee_enquete > annee_fin_etude, ]

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
# Non a priori problème 
# calculs_age$tx_emploi_etp <- calculs_age$tx_emploi_etp*100 
# calculs_age$population_emplois_etp <- calculs_age$population_emplois_etp*100 
# calculs_age

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


################################################################################
#           Un peu de salaires ?     ----------------------------------
################################################################################

#### Un premier graphe : Déciles de salaire moyen et médian

liste_var <- c("Decile_salaire", "Niveau_education", "Sexe_1H_2F","Poids_final", "COEFF", "Identifiant_menage")

pop_en_emploi <- data_merged[(Statut_emploi_1_emploi == 1) & Decile_salaire != '99',]
pop_en_emploi <- pop_en_emploi[,..liste_var]
nrow(pop_en_emploi)


sapply(pop_en_emploi, class) # Check classes of data table columns
pop_en_emploi <- pop_en_emploi[ , Decile_salaire := as.numeric(Decile_salaire)]

pop_en_emploi
sous_pop <- pop_en_emploi[, .("Decile_mean" = mean(Decile_salaire, na.rm = TRUE),
                              "Decile_med" = median(Decile_salaire, na.rm = TRUE)),
                          by = .(Niveau_education, Sexe_1H_2F)]

sous_pop[, Niveau_education_chiffre := factor(
  fcase(
    Niveau_education == "L", -1,
    Niveau_education == "M", 0,
    Niveau_education == "H", 1
  )
)
]

sous_pop[, Sexe_1H_2F := factor(
  fcase(
    Sexe_1H_2F == 1, "Hommes",
    Sexe_1H_2F == 2, "Femmes"
  )
)
]


sous_pop
sous_pop_melted <- melt(sous_pop, measure.vars = c("Decile_med", "Decile_mean"),
                        variable.name = "Mesure")

sapply(sous_pop_melted, class) # Check classes of data table columns
sous_pop_melted <- sous_pop_melted[ , value := as.numeric(value)]
sous_pop_melted <- sous_pop_melted[ , Niveau_education_chiffre := as.numeric(Niveau_education_chiffre)]
sous_pop_melted <- sous_pop_melted[ , Sexe_1H_2F := as.factor(Sexe_1H_2F )]

setnames(sous_pop_melted,'Sexe_1H_2F',"Sexe")
sous_pop_melted[, Mesure := factor(
  fcase(
    Mesure == "Decile_mean", "Décile de salaire moyen",
    Mesure == "Decile_med", "Décile de salaire médian"
  )
)
]

sous_pop_melted

### Le graphe n'est pas encore passé sous forme de fnt car les déciles sont entre 0 et 10 et pas 0 et 100... A voir si c'est intéressant de le faire ?
graph <- ggplot(data = sous_pop_melted, aes(x = reorder(Niveau_education, Niveau_education_chiffre), y = value, fill = Sexe)) +
  geom_bar(stat="identity", position=position_dodge()) +
  labs(title= 'Salaires en fonction du sexe et du niveau d\'études',
       x= 'Niveau d\'études',
       y= 'Décile de salaire') +
  scale_y_continuous(limits = c(0, 10), labels = function(y) format(y, scientific = FALSE)) +
  scale_fill_discrete() +
  scale_color_viridis() +
  facet_wrap(~Mesure)


list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1




##### Un second : effectifs par déciles de salaires###
liste_var <- c("Decile_salaire", "Annee_enquete", "Sexe_1H_2F","Poids_final", "COEFF", "Identifiant_menage")
pop_en_emploi <- data_merged[(Statut_emploi_1_emploi == 1) & Decile_salaire != '99',]
pop_en_emploi <- pop_en_emploi[,..liste_var]
nrow(pop_en_emploi)

sapply(pop_en_emploi, class) # Check classes of data table columns
pop_en_emploi <- pop_en_emploi[ , Decile_salaire := as.numeric(Decile_salaire)]

sous_pop <- pop_en_emploi[, .("Pop_totale_ETP" = sum(Poids_final, na.rm = TRUE),
                              "Pop_totale" = sum(COEFF, na.rm = TRUE)),
                          by = .(Sexe_1H_2F, Annee_enquete, Decile_salaire)]

sous_pop

# 
# sous_calculs_annee <- calcul_taux_emplois_activite(liste_var_groupby, data_merged)
# sous_calculs_annee <- nettoyage_tranche_age(sous_calculs_annee, age_min, age_max)
sous_calculs_annee <- nettoyage_sexe(sous_pop)
# sous_calculs_annee <- nettoyage_niveau_education(sous_calculs_annee)
sous_calculs_annee
sous_calculs_annee

### Pour compter les effectifs = On somme les COEFFS ETP
titre <- paste("Effectifs par déciles de salaires et par année d'enquête (entre", age_min, "et", age_max, "ans)", "\n (", dico_pays[pays], ")", sep = " ")
titre_save <- paste(pays, "deciles_salaires_annees", sep ='_')
titre_save <- paste(repo_sorties, titre_save, sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "Pop_totale_ETP"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Effectifs"
facet <- "Decile_salaire"
# ordre_facet <- c("Bas", "Moyen", "Elevé")

sous_calculs_annee

graph <- ggplot(data = sous_calculs_annee, aes(x = reorder(.data[[x]], .data[[sortby_x]]), y = .data[[y]], fill = .data[[fill]])) +
  geom_bar(stat="identity", position=position_dodge()) + 
  labs(title=titre,
       x= xlabel,
       y= ylabel) + 
  scale_y_continuous(labels = function(y) format(y, scientific = FALSE)) + 
  scale_fill_discrete() +
  scale_color_viridis() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1)) +
  facet_grid(~.data[[facet]])



list_graph[[longueur_liste + 1]] <- graph
longueur_liste <- longueur_liste + 1




################################################################################
#            V. SORTIES HTML  ===============================
################################################################################


source(paste(repo_prgm,"06_page_html.R",sep="/") , 
       encoding = "UTF-8" )




################################################################################
#         VII. Brouillon à mettre en forme ========================
################################################################################



################################################################################
#            VIII. Analyse de la situation familiale  ==========================
################################################################################
# Pensez a regarder le taux de chômage aussi avant - pour que ce soit plus facilement lisible qu'en croisant taux d'activité et taux d'emploi
# Henri avait filtré les gens qui sont encore en études (initiales) - est ce qu'on fait pareil ? 
# Est ce que l'on se recentre sur les ménages ordinaire ? Je le ferais
# je vais selectioner aussi que les personnes principales ou conjointes du principal dans le foyer
# 
# # On filtre sur la population d'intérêt :
# sous_data_merged <- data_merged[Age_tranche - 2 >= age_min, ]
# sous_data_merged <- sous_data_merged[Age_tranche + 2 <= age_max, ]
# sous_data_merged <- sous_data_merged[menage_ordinaire==1, ]
# sous_data_merged <- sous_data_merged[lien_pers_ref==1 | lien_pers_ref==2, ]
# Comme j'avais commencé à travailler sur le sous data merged et que ca ferait channger tout le code je duplique la base
sous_data_merged <- data_merged

# Comme on est sur des données pondérées que l'on ne veut pas retraiter à la main on va passer par le package survey 
# on aurait pu essayé de créer une fonction qui puisse s'adapter a plusieurs variables mais compliqué car encodage différent
# Utile aussi pour faire des regressions pondérées 
# On prépare les données avec le plan d'échantillonage : 
dw_tot <- svydesign(ids = ~1, data = sous_data_merged, weights = ~ sous_data_merged$COEFF)
# Je pense qu'il faudrait en faire un par année même si c'est pas optimal, à rediscuter 
# 15/03 : finalement après discussion on va analyser les évolution sur 6 périodes
# Il suffit de refaire tourner ce code sur l'ensemble des périodes + pour chaque période

# On va créer des bases spécifiques F et H pour travailler plus facilement sur les différents croisements
# Femmes
sous_data_merged_fem <- sous_data_merged[Sexe_1H_2F==2, ]
dw_fem <- svydesign(ids = ~1, data = sous_data_merged_fem, weights = ~ sous_data_merged_fem$COEFF)
# Hommes 
sous_data_merged_hom<- sous_data_merged[Sexe_1H_2F==1, ]
dw_hom <- svydesign(ids = ~1, data = sous_data_merged_hom, weights = ~ sous_data_merged_hom$COEFF)

# Idem en emploi
sous_data_merged_emp <- sous_data_merged[i_emploi==1, ]
dw_emp <- svydesign(ids = ~1, data = sous_data_merged_emp, weights = ~ sous_data_merged_emp$COEFF)
# Idem temps partiel
sous_data_merged_tp <- sous_data_merged[Temps_partiel_clean==0, ]
dw_tp <- svydesign(ids = ~1, data = sous_data_merged_tp, weights = ~ sous_data_merged_tp$COEFF)
# Idem sans emploi
sous_data_merged_sans_emp <- sous_data_merged[i_emploi==0, ]
dw_sans_emp <- svydesign(ids = ~1, data = sous_data_merged_sans_emp, weights = ~ sous_data_merged_sans_emp$COEFF)
# Femmes et sans emploi : 
sous_data_merged_sans_emp_fem <- sous_data_merged[i_emploi==0 & Sexe_1H_2F==2, ]
dw_sans_emp_fem <- svydesign(ids = ~1, data = sous_data_merged_sans_emp_fem, weights = ~ sous_data_merged_sans_emp_fem$COEFF)

# Femme en emploi
sous_data_merged_emp_fem <- sous_data_merged_fem[i_emploi==1, ]
dw_emp_fem <- svydesign(ids = ~1, data = sous_data_merged_emp_fem, weights = ~ sous_data_merged_emp_fem$COEFF)
# Homme en emploi 
sous_data_merged_emp_hom <- sous_data_merged_hom[i_emploi==1, ]
dw_emp_hom <- svydesign(ids = ~1, data = sous_data_merged_emp_hom, weights = ~ sous_data_merged_emp_hom$COEFF)

# Femme sans emploi
sous_data_merged_sans_emp_fem <- sous_data_merged_fem[i_emploi==0, ]
dw_sans_emp_fem <- svydesign(ids = ~1, data = sous_data_merged_sans_emp_fem, weights = ~ sous_data_merged_sans_emp_fem$COEFF)
# Homme sans emploi 
sous_data_merged_sans_emp_hom <- sous_data_merged_hom[i_emploi==0, ]
dw_sans_emp_hom <- svydesign(ids = ~1, data = sous_data_merged_sans_emp_hom, weights = ~ sous_data_merged_sans_emp_hom$COEFF)

# Faire les stats de base : 

# avoir la part de femmes et hommes par âge en pondéré, 
tab_FH_age <- svytable(~ Age_tranche+Sexe_1H_2F, dw_tot)
# tab_FH_age
lprop(tab_FH_age)
# par année d'enquête
tab_FH_enquete <- svytable(~ Annee_enquete +Sexe_1H_2F, dw_tot)
lprop(tab_FH_enquete)
# => peut être intéressant pour appréhender l'effet démographie : est ce que l'on a pas des gros désq : a priori non 

# le nombre de famille avec enfants
tab_fam_enf_age <- svytable(~ Age_tranche+enf, dw_tot)
lprop(tab_fam_enf_age)
# par année d'enquête
tab_fam_enf_enquete <- svytable(~ Annee_enquete +enf, dw_tot)
lprop(tab_fam_enf_enquete)
# L'idée ici c'est de voir si y a une baisse des naissances / du nombre de familles avec enfant : oui 
# ce qui peut avoir un impact sur le marché du travail. 
# Avec l'âge on voit aussi les tranches concernés par les enfants, il faudrait croiser les trois aussi (age /année)
# par sexe : rien de bizarre, proche (on aurait quand même pu avoir les fam monop en creux - difficile a quantifier)
tab_FH_enf_enquete <- svytable(~ Sexe_1H_2F +enf, dw_tot)
lprop(tab_FH_enf_enquete)

# Le nombre de famille monop en particulier: comme pour la composition familiale on a de gros écarts avec d'autres sources
# Variable a reprendre si on veut s'en servir (on devrait être à 9% des familles avec enfants) pour info : https://www.insee.fr/fr/statistiques/6047775?sommaire=6047805#tableau-figure2
# tab_monop_age <- svytable(~ Age_tranche+fam_monop, dw_tot)
# lprop(tab_monop_age)
# # par année d'enquête
# tab_monop_enquete <- svytable(~ Annee_enquete +fam_monop, dw_tot)
# lprop(tab_monop_enquete)
# # la répartition par type en général : beaucoup de ménage complexe, je ne sais pas si j'exploite bien la variable
# a priori non vu les données de l'ocde...
# tab_compomen_age <- svytable(~ Age_tranche+compo_men, dw_tot)
# lprop(tab_compomen_age)
# # par année d'enquête
# tab_compomen_enquete <- svytable(~ Annee_enquete +compo_men, dw_tot)
# lprop(tab_compomen_enquete)

# les familles avec des enfants en bas âge : on sait que c'est ca qui penalise le plus notamment du fait des MDG
# moins de 3 ans 
tab_enf_m3_age <- svytable(~ Age_tranche+enf_m3ans, dw_tot)
lprop(tab_enf_m3_age)
# Majoritairement concerné autours de 32 ans mais pas negligeable de 20 à 40 ans 
# par année d'enquête
tab_enf_m3_enquete <- svytable(~ Annee_enquete +enf_m3ans, dw_tot)
lprop(tab_enf_m3_enquete)
# on constate une légère diminution mais peut être pas signifiatifs (moins visible que pour l'enfant en général)
# moins de 6 ans 
tab_enf_m6_age <- svytable(~ Age_tranche+enf_m6ans, dw_tot)
lprop(tab_enf_m6_age)
# par année d'enquête
tab_enf_m6_enquete <- svytable(~ Annee_enquete +enf_m6ans, dw_tot)
lprop(tab_enf_m6_enquete)
# Conclu proche des moins de 3 ans avec un déclage sur l'âge

# Famille avec enfant selon le nombre d'enfant
# par âge :
tab_fam_nb_enf_age <- svytable(~ Age_tranche+nb_enf, dw_tot)
lprop(tab_fam_nb_enf_age)
# Coté tardif des naissances dans les familles avec au moins un enfant
# par année d'enquête
tab_fam_nb_enf_enquete <- svytable(~ Annee_enquete +nb_enf, dw_tot)
lprop(tab_fam_nb_enf_enquete)
# On voit une stabilité pour 0 et 1 enfant mais attention ca diminue quand même pas mal pour les familles de deux et plus 


# Statut marital : 2 mariés, 1 celibataire, 0 veuf/divorcé/séparé
# par âge :
tab_stat_mar_age <- svytable(~ Age_tranche+statu_marital, dw_tot)
lprop(tab_stat_mar_age)
# par année d'enquête
tab_stat_mar_enquete <- svytable(~ Annee_enquete +statu_marital, dw_tot)
lprop(tab_stat_mar_enquete)
# On constate une importante diminution du mariage et une certaine hausse du célibat dans les enquêtes sur l'ensemble (peut jouer sur le marché du travail, à croiser avec le sexe dans l'idéal)
# par sexe : equivalence sur le mariage, mais moins de femmes celibataires et plus veuves
tab_FH_stat_mar_enquete <- svytable(~ Sexe_1H_2F +statu_marital, dw_tot)
lprop(tab_FH_stat_mar_enquete)

# (Mesurer à partir de 2006) Proportion de personnes qui se déclarent comme "au foyer" (ie comme s'occupant du foyer) au moments de l'enquête
# par âge : pas si importante ua moment des enfants, plus fréquent chz les plus âgés (effet génération?)
tab_foyer_age <- svytable(~ Age_tranche+sit_pro_foyer, dw_tot)
lprop(tab_foyer_age)
# par année d'enquête : en forte diminution depuis de 15% à un peu moins de 7%
tab_foyer_enquete <- svytable(~ Annee_enquete +sit_pro_foyer, dw_tot)
lprop(tab_foyer_enquete)
# par sexe : Moins de 10% de la pop mais 12 fois plus de femmes que d'homme
tab_FH_foyer <- svytable(~ Sexe_1H_2F +sit_pro_foyer, dw_tot)
lprop(tab_FH_foyer)
# idemn mais avant l'enquête (on a des mesures avant 2006)
# par âge : idem avec un effet encore plus marqué, ie plus fort chez les plus âgées
tab_foyer_avant_age <- svytable(~ Age_tranche+sit_pro_avant_enq_foyer, dw_tot)
lprop(tab_foyer_avant_age)
# par année d'enquête : on voit la forte baisse de 24% en 1999, soit une femme sur 4 à 7% en 2018, moins d'une sur 10
tab_foyer_avant_enquete <- svytable(~ Annee_enquete +sit_pro_avant_enq_foyer, dw_tot)
lprop(tab_foyer_avant_enquete)
# par sexe : quasiment aucun homme, 23% des femmes :donc plus d'une femme sur 5 s'est retrouvée au foyer 
tab_FH_foyer_avant_enquete <- svytable(~ Sexe_1H_2F +sit_pro_avant_enq_foyer, dw_tot)
lprop(tab_FH_foyer_avant_enquete)

# Le diplôme et le secteur d'étude (voir si les variables paraissent assez pertinentes pour être conservées ensuite)
# Le "diplôme"
# par âge : on retrouve bien deux effets âge et période : trop jeune pas encore diplômé, trop vieu pas encore de hausse du nombre d'année d'étude visible
tab_dip_age <- svytable(~ Age_tranche+Niveau_education, dw_tot)
lprop(tab_dip_age)
# par année d'enquête : on voit bien l'augmentation du nombre de diplômés
tab_dip_enquete <- svytable(~ Annee_enquete +Niveau_education, dw_tot)
lprop(tab_dip_enquete)
# par sexe : répartition sensiblement identique, ce qui dans le cas de la france serait un peu étonnant 
tab_FH_dip <- svytable(~ Sexe_1H_2F +Niveau_education, dw_tot)
lprop(tab_FH_dip)
# Pas sure que la variable soit très pertiennente (cf la discussion avec Henri), mais on a pas mieux pour l'instant ?
# Le "secteur d'étude"
# par âge : on retrouve bien deux effets âge et période : trop jeune pas encore diplômé, trop vieu pas encore de hausse du nombre d'année d'étude visible
tab_sect_etu_age <- svytable(~ Age_tranche+Domaine_education, dw_tot)
lprop(tab_sect_etu_age)
# Beaucoup trop de non réponse, on ne peut pas la garder (en tout cas pour l'Espagne)
# La CSP peut palier ce pb, voir partie suivante 

# Penser à analyser pour chaque période 

# Est ce que le fait d'être en d'activité, d'emploi et d'emploi ETP des femmes et des hommes varient selon le statut martital ?
# Tester en couple, en couple cohabitant et mariés si possible : on a pas encore toutes les variables, on teste juste mariés
# Femmes
# En emploi : 
tab_fem_stat_mar_emploi <- svytable(~ statu_marital+i_emploi, dw_fem)
lprop(tab_fem_stat_mar_emploi)
# Actif : 
tab_fem_stat_mar_actif <- svytable(~ statu_marital +i_actif, dw_fem)
lprop(tab_fem_stat_mar_actif)
# Hommes
tab_hom_stat_mar_emploi <- svytable(~ statu_marital+i_emploi, dw_hom)
lprop(tab_hom_stat_mar_emploi)
# Actif : 
tab_hom_stat_mar_actif <- svytable(~ statu_marital +i_actif, dw_hom)
lprop(tab_hom_stat_mar_actif)
# Les hommes mariés sont près de deux fois plus nombreux a avoir un emploi (32 points d'écart)
# on voit que ca évolue en sens inverse, hommes mariés plus souvent actif et enmploi que celibataire (encore plus séparé)
# inversement les femmes sont plus souvent actives et en emploi célibataire ou divorcée que mariés 
# Pour les femmes l'écart actif / emploi se creusent alors qu'il se réduit pour les hommes (différence rapport à la l'inactivité et au chômage ?)
# Il faudrait ensuite refaire les même graphique que plus haut mais en filtrant sur les modalités mariés ou non 

# Est ce que le taux d'activité, d'emploi et d'emploi ETP des femmes et des hommes varient selon le nombre d'enfant à charge ?
# Trier sur les mineurs, à charge (au domicile) et le nombre 1,2 et 3 : je ne suis pas sure d'avoir bien la distinction a charge
# On commence par le nombre :
# Femmes
# En emploi : 
tab_fem_nb_enf_emploi <- svytable(~ nb_enf+i_emploi, dw_fem)
lprop(tab_fem_nb_enf_emploi)
# Actif : 
tab_fem_nb_enf_actif <- svytable(~ nb_enf +i_actif, dw_fem)
lprop(tab_fem_nb_enf_actif)
# Hommes
tab_hom_nb_enf_emploi <- svytable(~ nb_enf+i_emploi, dw_hom)
lprop(tab_hom_nb_enf_emploi)
# Actif : 
tab_hom_nb_enf_actif <- svytable(~ nb_enf +i_actif, dw_hom)
lprop(tab_hom_nb_enf_actif)
# Pour les femmes c'est globalement linéaire, mais surtout tres proches pour celles sans enfants ou avec moins de 3 : il y a un gros saut à 3 enfants et plus
# Inversement chez les hommes c'est croissant, sauf le taux d'emploi (chômage car pas activité) qui baisse au troisième et plus
# Tester aussi selon l'âge des enfants : nombre de moins de trois ans, nombre de moins de 6 ans (et autre - voir tester les majeurs avec nombre de plus de 18 ans)
# Moins de 3 ans 
# Femmes
# En emploi : 
tab_fem_enf_3ans_emploi <- svytable(~ enf_m3ans+i_emploi, dw_fem)
lprop(tab_fem_enf_3ans_emploi)
# Actif : 
tab_fem_enf_3ans_actif <- svytable(~ enf_m3ans +i_actif, dw_fem)
lprop(tab_fem_enf_3ans_actif)
# Hommes
tab_hom_enf_3ans_emploi <- svytable(~ enf_m3ans+i_emploi, dw_hom)
lprop(tab_hom_enf_3ans_emploi)
# Actif : 
tab_hom_enf_3ans_actif <- svytable(~ enf_m3ans +i_actif, dw_hom)
lprop(tab_hom_enf_3ans_actif)
# On retroue un ecrat important entre les hommes et les femmes deja évoqué 
# la différence avec sans enfant et plus marquée chez les hommes: plus souvent actif/emploi, a l'inverse des femmes
# la présence d'un enfant de moins de 3 ans et lié moins négativement que celle d''en avoir plusieurs (croisé moins de 3 et moins de 6 ?)
# moins de 6 ans 
# Femmes
# En emploi : 
tab_fem_enf_6ans_emploi <- svytable(~ enf_m6ans+i_emploi, dw_fem)
lprop(tab_fem_enf_6ans_emploi)
# Actif : 
tab_fem_enf_6ans_actif <- svytable(~ enf_m6ans +i_actif, dw_fem)
lprop(tab_fem_enf_6ans_actif)
# Hommes
tab_hom_enf_6ans_emploi <- svytable(~ enf_m6ans+i_emploi, dw_hom)
lprop(tab_hom_enf_6ans_emploi)
# Actif : 
tab_hom_enf_6ans_actif <- svytable(~ enf_m6ans +i_actif, dw_hom)
lprop(tab_hom_enf_6ans_actif)
# les conclusions sur les moins de 6 sont un peu moins marquées / pas plus intéressante dans ce pays : croisé les deux ?
# si déterminant regarder l'évolution du nombre d'enfant en moyenne sur toute la population, sur les moins diplomés et chez les plus diplomés 
# A priori compliqué : si possible créer une variable csp du couple / diplome du couple et une variable couple biactif ou non 
# Finalement le plus intéressant ca serait la CSP mais c'est plutot la partie suivante (voir donc ci-après) 

# Faire une analyse plus spécifique du temps partiel (attention ca peut aussi entrer dans la partie suivante) : 
# avec le fait d'être en couple marié/cohabitant, d'avoir des enfants, dont en bas âges, voir si on a une variable congé parental 
# voir si on a les raisons de ce temps partiel, regarder si ces personnes souhaiteraient travailler plus ou chnager d'emploi et pourquoi 
# Temps partiel selon le sexe:
tab_tp_sexe <- svytable(~ Sexe_1H_2F +Temps_partiel_clean, dw_tot)
lprop(tab_tp_sexe)
# Temps partiel selon le sexe uniquement sur le tp:
tab_tp_sexe <- svytable(~ Temps_partiel_clean + Sexe_1H_2F, dw_tp)
lprop(tab_tp_sexe)
# Temps partiel raison 
tab_sexe_tp <- svytable(~ Sexe_1H_2F +Raisons_temps_partiel, dw_tp)
lprop(tab_sexe_tp)
# A temps partiel pour raison familiale selon le nb d'enfants : pas vraiment de différences entre 2 et 3
tab_nb_enf_tp_enf <- svytable(~ nb_enf +raisons_tp_enf_fam, dw_tp)
lprop(tab_nb_enf_tp_enf)
# A temps partiel pour raison familiale mois de 3 : très fréquent lorsque au moins un enfant a moins de trois ans
tab_enf_m3ans_tp_enf <- svytable(~ enf_m3ans +raisons_tp_enf_fam, dw_tp)
lprop(tab_enf_m3ans_tp_enf)
# A temps partiel pour raison familiale mois de 6 : un peu moins fréquent que pour les moins de 3 (mais toujours pareil a voir si c'est significatifs)
tab_enf_m6ans_tp_enf <- svytable(~ enf_m6ans +raisons_tp_enf_fam, dw_tp)
lprop(tab_enf_m6ans_tp_enf)
# A temps partiel pour raison familiale selon le sexe : plus féminin, relativement proche des chiffres francais 
tab_sexe_tp_enf <- svytable(~ Sexe_1H_2F +raisons_tp_enf_fam, dw_tp)
lprop(tab_sexe_tp_enf)
# On va croiser a tp et enfants: l'cart 0/ au moins  est important, on voit aussi qu'il estplus large pour 2 que pour 1 ou 3
tab_tp_nbenf_fem <- svytable(~ Temps_partiel_clean +nb_enf, dw_fem)
lprop(tab_tp_nbenf_fem)
# A tp et moins de 3: Pour 6 comme 3 pas si différent, petit écart mais pas si massif, on voit que pour les moins de trois c'est proche à tp ou en arret
tab_tp_enf_m3ans_fem <- svytable(~ Temps_partiel_clean +enf_m3ans, dw_fem)
lprop(tab_tp_enf_m3ans_fem)
# A tp et moins de 6
tab_tp_enf_m6ans_fem <- svytable(~ Temps_partiel_clean +enf_m6ans, dw_fem)
lprop(tab_tp_enf_m6ans_fem)
# A tp et mariée : pas si det
tab_tp_marie_fem <- svytable(~ Temps_partiel_clean +statu_marital, dw_fem)
lprop(tab_tp_marie_fem)
# Pour les variables précédentes il faudra passé à regarder l'évolution par période
# Ne travaille pas pour raison familiales (congé maternité / parental) : proportion faible dans l'enquete mais plus fréquent femme (voir les intervalle de confiance toutefois pas sur qu ece soit significatif)
tab_sexe_emp_no_trav_enf <- svytable(~ Sexe_1H_2F +raisons_emp_no_trav_enf_fam, dw_tot)
lprop(tab_sexe_emp_no_trav_enf)
# Pour avoir le chiffre sur le total mais je pense que c'est plus intéressant à interpréter sur juste les sans emploi
# A du démissioner à cause des enfants ou famille 
tab_sexe_dem_enf_fam <- svytable(~ Sexe_1H_2F +raison_dem_enf_fam, dw_tot)
lprop(tab_sexe_dem_enf_fam)
# Ne travaille pas a cause des enfants ou famille
tab_sexe_no_trav_enf_fam<- svytable(~ Sexe_1H_2F +raison_no_trav_enf_fam, dw_tot)
lprop(tab_sexe_no_trav_enf_fam)
# Uniquement chez les personnes sans emploi 
# A du démissioner à cause des enfants ou famille : 5% des femmes quand même et surtout quasi aucun homme 
tab_sexe_dem_enf_fam_se <- svytable(~ Sexe_1H_2F +raison_dem_enf_fam, dw_sans_emp)
lprop(tab_sexe_dem_enf_fam_se)
# Ne travaille pas a cause des enfants ou famille : idem quasi aucun homme 
tab_sexe_no_trav_enf_fam_se<- svytable(~ Sexe_1H_2F +raison_no_trav_enf_fam, dw_sans_emp)
lprop(tab_sexe_no_trav_enf_fam_se)
# Sachant que c'est majoritairement des femmes, on va regarder les évolutions et donc par années d'enquête : 
tab_enq_tp_sexe <- svytable(~ Annee_enquete +Sexe_1H_2F, dw_tp)
lprop(tab_enq_tp_sexe)
# Il ya quand même des modification de la structure (un peu plus d'homme qu'avant mais ca reste minim sur le total des en emploi)
# A temps partiel pour raison familiale : etonnant car pic entre 200- et 2011 - beaucoup d'ecart, un politique emploi/fam ?
tab_enq_tp_enf <- svytable(~ Annee_enquete +raisons_tp_enf_fam, dw_tp)
lprop(tab_enq_tp_enf)
# Ne travaille pas pour raison familiales (congé maternité / parental) : proportion faible dans l'enquete mais plus fréquent femme (voir les intervalle de confiance toutefois pas sur qu ece soit significatif)
tab_enq_emp_no_trav_enf <- svytable(~ Annee_enquete +raisons_emp_no_trav_enf_fam, dw_tot)
lprop(tab_enq_emp_no_trav_enf)
# Pour avoir le chiffre sur le total mais je pense que c'est plus intéressant à interpréter sur juste les sans emploi
# A du démissioner à cause des enfants ou famille : etonnat car on a des variations relativement importantes, notament autours de 2006/2007 = piste de la pol publique
tab_enq_dem_enf_fam <- svytable(~ Annee_enquete +raison_dem_enf_fam, dw_tot)
lprop(tab_enq_dem_enf_fam)
# Ne travaille pas a cause des enfants ou famille: plus fréquent a priori avant 2000 mais relativement stable depuis
tab_enq_no_trav_enf_fam<- svytable(~ Annee_enquete +raison_no_trav_enf_fam, dw_tot)
lprop(tab_enq_no_trav_enf_fam)
# Uniquement chez les personnes sans emploi 
# A du démissioner à cause des enfants ou famille : Toujours ce pic proche de 8% en 2006-2007, des phases très basses autours de 2014 (attention probablement une erreur en 2005)
tab_enq_dem_enf_fam_se <- svytable(~ Annee_enquete +raison_dem_enf_fam, dw_sans_emp)
lprop(tab_enq_dem_enf_fam_se)
# Ne travaille pas a cause des enfants ou famille : commentaire proche ensemble pop 
tab_enq_no_trav_enf_fam_se<- svytable(~ Annee_enquete +raison_no_trav_enf_fam, dw_sans_emp)
lprop(tab_enq_no_trav_enf_fam_se)
# Les femmes sans emploi : les chiffres augmentent mais les commentaires ne changent pas
# A du démissioner à cause des enfants ou famille 
tab_enq_dem_enf_fam_se_fem <- svytable(~ Annee_enquete +raison_dem_enf_fam, dw_sans_emp_fem)
lprop(tab_enq_dem_enf_fam_se_fem)
# Ne travaille pas a cause des enfants ou famille  
tab_enq_no_trav_enf_fam_se_fem<- svytable(~ Annee_enquete +raison_no_trav_enf_fam, dw_sans_emp_fem)
lprop(tab_enq_no_trav_enf_fam_se_fem)

# Faire une analyse congé parental : regardé selon le fait d'avoir ou non des enfants de moins de trois ans + le nombre 
# Ne travaille pas pour raison familiales (congé maternité / parental) : proportion faible dans l'enquete mais plus fréquent femme (voir les intervalle de confiance toutefois pas sur qu ece soit significatif)
# par nombre d'enfant : les 0,2 sans enfants c'est peut être des déces, ca nuance les autres valeurs peut exploitable a mon avis
tab_nb_enf_emp_no_trav_enf <- svytable(~ nb_enf +raisons_emp_no_trav_enf_fam, dw_tot)
lprop(tab_nb_enf_emp_no_trav_enf)
# Avce un enfant de moins de 3 : on voit un peu plus le congé mat/pat je pense
tab_enf_m3ans_emp_no_trav_enf <- svytable(~ enf_m3ans +raisons_emp_no_trav_enf_fam, dw_tot)
lprop(tab_enf_m3ans_emp_no_trav_enf)
# Sur les femmes : encore plus important 
tab_enf_m3ans_emp_no_trav_enf_fem <- svytable(~ enf_m3ans +raisons_emp_no_trav_enf_fam, dw_fem)
lprop(tab_enf_m3ans_emp_no_trav_enf_fem)
# Sur les hommes : quasi nul
tab_enf_m3ans_emp_no_trav_enf_hom <- svytable(~ enf_m3ans +raisons_emp_no_trav_enf_fam, dw_hom)
lprop(tab_enf_m3ans_emp_no_trav_enf_hom)
# avec un enfant de moins de 6 : on rejoint les chiffres sur le nombre d'enfant - peu massif a étudié 
tab_enf_m6ans_emp_no_trav_enf <- svytable(~ enf_m6ans +raisons_emp_no_trav_enf_fam, dw_tot)
lprop(tab_enf_m6ans_emp_no_trav_enf)
# On choisit de se centrer que sur les femmes puisque ca semble être un pb largement féminin 
# Raison de démission pour enfant ou raison familiale 
# par nombre d'enfant : 8% 2 enf 7,5 % trois enfant (peut êtr eparcxe que 2 c'est un cap)
tab_nb_enf_dem_enf_fam_se_fem <- svytable(~ nb_enf +raison_dem_enf_fam, dw_sans_emp_fem)
lprop(tab_nb_enf_dem_enf_fam_se_fem)
# Avec un enfant de moins de 3 : 15% c'est beaucoup !
tab_enf_m3ans_dem_enf_fam_se_fem <- svytable(~ enf_m3ans +raison_dem_enf_fam, dw_sans_emp_fem)
lprop(tab_enf_m3ans_dem_enf_fam_se_fem)
# Avec un enfant de moins de 6 : 12% pas neg non plus, ca veut dire que c'est pas mal centré sur les enfants en bas âge mais pas que les tout petit
tab_enf_m6ans_dem_enf_fam_se_fem <- svytable(~ enf_m6ans +raison_dem_enf_fam, dw_sans_emp_fem)
lprop(tab_enf_m6ans_dem_enf_fam_se_fem)
# Ne travaille pas a cause des enfants ou famille : 
# par nombre d'enfant : croissant mais pas tant d'écart que ca 
tab_nb_enf_no_trav_enf_fam_se_fem<- svytable(~ nb_enf +raison_no_trav_enf_fam, dw_sans_emp_fem)
lprop(tab_nb_enf_no_trav_enf_fam_se_fem)
# Avec un enfant de moins de 3 : plus important pour les petits 
tab_enf_m3ans_no_trav_enf_fam_se_fem<- svytable(~ enf_m3ans +raison_no_trav_enf_fam, dw_sans_emp_fem)
lprop(tab_enf_m3ans_no_trav_enf_fam_se_fem)
# Avec un enfant de moins de 6 : un peu moins important que les moins de 3 mais plus que pour les enf au global
tab_enf_m6ans_no_trav_enf_fam_se_fem<- svytable(~ enf_m6ans +raison_no_trav_enf_fam, dw_sans_emp_fem)
lprop(tab_enf_m6ans_no_trav_enf_fam_se_fem)
# Proportion absence et salaire : on va regarder pour les femmes sans emploi et par enquete car la var n'est pas dispo tout le temps
tab_enq_alloc_absence_se_fem<- svytable(~ Annee_enquete +Absence_et_salaire_2006, dw_sans_emp_fem)
lprop(tab_enq_alloc_absence_se_fem)
# A mon avis beacoup de non réponse, ca me semble peu exploitable...
######################################################################################################################################
#            IX. Analyse de l'évolution de la qualité de l'emploi et de la position sur le marché du travail             ============
######################################################################################################################################

### Proposer un indicateur de précarité ? Et de pénibilité ?

#  idem commencer par les stats gloables pour avoir une vue d'ensemble 
# Le statut dans l'emploi : 
# par âge : entrepreuneur plus âgés
tab_stat_emp_age <- svytable(~ Age_tranche+Statut_dans_emploi, dw_emp)
lprop(tab_stat_emp_age)
# par année d'enquête : petote hausse salariat vs entrepreuneur 
tab_stat_emp_enquete <- svytable(~ Annee_enquete +Statut_dans_emploi, dw_emp)
lprop(tab_stat_emp_enquete)
# par sexe : Inégalité de genre (entrepreuneur vs travailleurs assitant fam)
tab_FH_stat_emp <- svytable(~ Sexe_1H_2F +Statut_dans_emploi, dw_emp)
lprop(tab_FH_stat_emp)
# souhaite travailler : attention à la non réponse, vérifier les filtres 
# Comme pour les autres sans emploi souvent filtré sur SEEKWORK ce qui créer de la non réponse (voir si on veut reponderer pour l'utiliser ou si on distingue comme ca un troisième groupe)
# par âge : stable mais femmes plus nombreuses 
tab_souhait_emp_age <- svytable(~ Age_tranche+Souhaite_travailler, dw_sans_emp)
lprop(tab_souhait_emp_age)
tab_souhait_emp_age_fem <- svytable(~ Age_tranche+Souhaite_travailler, dw_sans_emp_fem)
lprop(tab_souhait_emp_age_fem)
# par année d'enquête :  plutot diminution /stabilisation avec le décalage de points pour les femmes
tab_souhait_emp_enquete <- svytable(~ Annee_enquete +Souhaite_travailler, dw_sans_emp)
lprop(tab_souhait_emp_enquete)
tab_souhait_emp_enquete_fem <- svytable(~ Annee_enquete +Souhaite_travailler, dw_sans_emp_fem)
lprop(tab_souhait_emp_enquete_fem)
# par sexe : gros écart (attention année) donc on va analyse juste du point des femmes aussi
tab_FH_souhait_emp <- svytable(~ Sexe_1H_2F +Souhaite_travailler, dw_sans_emp)
lprop(tab_FH_souhait_emp)
# dispo pour travailler  
# par âge : décroissance avec l'âge 
tab_dispo_emp_age <- svytable(~ Age_tranche+Disponible_pour_travailler, dw_sans_emp)
lprop(tab_dispo_emp_age)
tab_dispo_emp_age_fem <- svytable(~ Age_tranche+Disponible_pour_travailler, dw_sans_emp_fem)
lprop(tab_dispo_emp_age_fem)
# par année d'enquête : forte croissance, politique de l'emploi ? Différence F/H
tab_dispo_emp_enquete <- svytable(~ Annee_enquete +Disponible_pour_travailler, dw_sans_emp)
lprop(tab_dispo_emp_enquete)
tab_dispo_emp_enquete_fem <- svytable(~ Annee_enquete +Disponible_pour_travailler, dw_sans_emp_fem)
lprop(tab_dispo_emp_enquete_fem)
# par sexe : petit écart, je ne sais pas si c'est significatf (surtout vu les NA verif les filtres)
tab_FH_dispo_emp <- svytable(~ Sexe_1H_2F +Disponible_pour_travailler, dw_sans_emp)
lprop(tab_FH_dispo_emp)

# On peut regarder la variable CSP : la variable initiale est trés détaillé on a regourper a deux niveaux voir netoyage
# La on utilise le niveau ? 1
# Position sociale via la "CSP" attention c'est pas la même chose que la csp française 
# Attention pour l'interprétation, cette variable n'est pas dispo tout les ans (peut être créer une variable ref ?)
# + elle n'est pas dispo pour les gens qui ne sont pas en emploi, dans ce cas on a mis la csp dispo pour "l'ancien job"
# par âge : parmi ceux qui sont en emploi petit effet âge des évolutions de carrière (pas trop génération je pense vu que le marché un stable)
tab_csp_age <- svytable(~ Age_tranche+CSP_tot_1, dw_tot)
lprop(tab_csp_age)
# par année d'enquête : Pour les années dispos, le marché du travail parait relativement stable
tab_csp_enquete <- svytable(~ Annee_enquete +CSP_tot_1, dw_tot)
lprop(tab_csp_enquete)
# par sexe : effet genre important, peut être la variable a privilégié pour notre analyse du coup
tab_FH_csp <- svytable(~ Sexe_1H_2F +CSP_tot_1, dw_tot)
lprop(tab_FH_csp)
# Diplome et nombre d'enfant même si on y  croit pas trop 
# Femmes 
tab_fem_enf_dip <- svytable(~ nb_enf+Niveau_education, dw_fem)
lprop(tab_fem_enf_dip)
# Hommes
tab_hom_enf_dip <- svytable(~ nb_enf+Niveau_education, dw_hom)
lprop(tab_hom_enf_dip)
# Pas de conclusion / analyse qui me semble ressortir : pas trop de variation F/H ni DIP/NB
# CSP et Nombre d'enfants
# Femmes 
tab_fem_enf_csp <- svytable(~ nb_enf+CSP_tot_1, dw_fem)
lprop(tab_fem_enf_csp)
# Hommes
tab_hom_enf_csp <- svytable(~ nb_enf+CSP_tot_1, dw_hom)
lprop(tab_hom_enf_csp)
# Plus intéresssante sur la CSP, on retrouve les variation F/H mais aussi celle seont le nombre d'enfant
# attention à l'effet âge, mais certaine évolution sont assez forte pour que ce ne soit pas que ca qui les expliques
# On voit chez les top manageurs, une progression constante pour les hommes puis un saut un peu plus grand a trois enfants (age mais aussi famille ?)
# Tandis que chez les femmes c'est relativement constant (progression légère)
# en revanche au troisième enfant ya des csp qui s'éfondre ce que l'on ne voit pas chez les H (type greffier = affiner la traduction)

# Comment varie la proportion de temps partiel dans le temps selon l'âge et le sexe ?
# On a deja analysé les dimension fam précédement (y compris sexe) : trés femini, ca vaut le coup de regarder que chez les femmes aussi
# On va garder un focus femme
# par âge : 
tab_tp_age <- svytable(~ Age_tranche+Temps_partiel_clean, dw_tot)
lprop(tab_tp_age)
tab_tp_age_emp <- svytable(~ Age_tranche+Temps_partiel_clean, dw_emp)
lprop(tab_tp_age_emp)
tab_tp_age_fem <- svytable(~ Age_tranche+Temps_partiel_clean, dw_fem)
lprop(tab_tp_age_fem)
tab_tp_age_fem_emp <- svytable(~ Age_tranche+Temps_partiel_clean, dw_emp_fem)
lprop(tab_tp_age_fem_emp)
# par année d'enquête : on constate bien la hausse au fil des enquêtes
tab_tp_enquete <- svytable(~ Annee_enquete +Temps_partiel_clean, dw_tot)
lprop(tab_tp_enquete)
tab_tp_enquete_emp <- svytable(~ Annee_enquete+Temps_partiel_clean, dw_emp)
lprop(tab_tp_enquete_emp)
tab_tp_enquete_fem <- svytable(~ Annee_enquete +Temps_partiel_clean, dw_fem)
lprop(tab_tp_enquete_fem)
tab_tp_enquete_fem_emp <- svytable(~ Annee_enquete +Temps_partiel_clean, dw_emp_fem)
lprop(tab_tp_enquete_fem_emp)

# Comment varie la proportion de CDI dans le temps selon l'âge et le sexe ? 
# par âge : Moins de cdi autour de 3à-40 mais les femmes ca semble etre moins le cas après 
tab_cdi_age <- svytable(~ Age_tranche+Perennite_emploi, dw_tot)
lprop(tab_cdi_age)
tab_cdi_age_emp <- svytable(~ Age_tranche+Perennite_emploi, dw_emp)
lprop(tab_cdi_age_emp)
tab_cdi_age_fem <- svytable(~ Age_tranche+Perennite_emploi, dw_fem)
lprop(tab_cdi_age_fem)
tab_cdi_age_fem_emp <- svytable(~ Age_tranche+Perennite_emploi, dw_emp_fem)
lprop(tab_cdi_age_fem_emp)
# par année d'enquête : on constate bien la hausse au fil des enquêtes
tab_cdi_enquete <- svytable(~ Annee_enquete +Perennite_emploi, dw_tot)
lprop(tab_cdi_enquete)
tab_cdi_enquete_emp <- svytable(~ Annee_enquete+Perennite_emploi, dw_emp)
lprop(tab_cdi_enquete_emp)
tab_cdi_enquete_fem <- svytable(~ Annee_enquete +Perennite_emploi, dw_fem)
lprop(tab_cdi_enquete_fem)
tab_cdi_enquete_fem_emp <- svytable(~ Annee_enquete +Perennite_emploi, dw_emp_fem)
lprop(tab_cdi_enquete_fem_emp)
# par sexe : la non réponse me parait étonnante et un peu elevé, mauvais signe ?
tab_cdi_fh <- svytable(~ Sexe_1H_2F +Perennite_emploi, dw_emp)
lprop(tab_cdi_fh)

# Avoir un poste de manageur :commence en 2005, a nouveau beaucoup de non réponse, ca fait un peu peur
# Peut être réflkechir sur ces pb est ce que c'est un filtre ?
# par âge : 
tab_manag_age_emp <- svytable(~ Age_tranche+travail_respon, dw_emp)
lprop(tab_manag_age_emp)
tab_manag_age_fem_emp <- svytable(~ Age_tranche+travail_respon, dw_emp_fem)
lprop(tab_manag_age_fem_emp)
# par année d'enquête : assez stable
tab_manag_enquete_emp <- svytable(~ Annee_enquete+travail_respon, dw_emp)
lprop(tab_manag_enquete_emp)
tab_manag_enquete_fem_emp <- svytable(~ Annee_enquete +travail_respon, dw_emp_fem)
lprop(tab_manag_enquete_fem_emp)
# par sexe :  un cpetit écart femmes / hommes
tab_manag_fh <- svytable(~ Sexe_1H_2F +travail_respon, dw_emp)
lprop(tab_manag_fh)

# idem autre type de contrat : CDD, intérim - voir comment cela change selon la législation par pays 
# Travail en intérim : beaucoup de non réponse, pas sure que ce soit pertinent de la prendre en fait
# par âge : touche plus les jeunes, différences légère pour les femmes 
tab_interim_age_emp <- svytable(~ Age_tranche+travail_interim, dw_emp)
lprop(tab_interim_age_emp)
tab_interim_age_fem_emp <- svytable(~ Age_tranche+travail_interim, dw_emp_fem)
lprop(tab_interim_age_fem_emp)
# par année d'enquête : pas dispo avant 2005, plus important avant 2008 puis baisse et stabilisation 
tab_interim_enquete_emp <- svytable(~ Annee_enquete+travail_interim, dw_emp)
lprop(tab_interim_enquete_emp)
tab_interim_enquete_fem_emp <- svytable(~ Annee_enquete +travail_interim, dw_emp_fem)
lprop(tab_interim_enquete_fem_emp)
# par sexe : pas trop d'écart 
tab_interim_fh <- svytable(~ Sexe_1H_2F +travail_interim, dw_emp)
lprop(tab_interim_fh)

# Travail en 3/8 : beaucoup de non réponse, pas dispo pour toutes les années 
# par âge : touche un peu plus les jeunes
tab_3_8_age_emp <- svytable(~ Age_tranche+travail_3_8, dw_emp)
lprop(tab_3_8_age_emp)
tab_3_8_age_fem_emp <- svytable(~ Age_tranche+travail_3_8, dw_emp_fem)
lprop(tab_3_8_age_fem_emp)
# par année d'enquête : relativement stable même si petite hausse 2018 
tab_3_8_enquete_emp <- svytable(~ Annee_enquete+travail_3_8, dw_emp)
lprop(tab_3_8_enquete_emp)
tab_3_8_enquete_fem_emp <- svytable(~ Annee_enquete +travail_3_8, dw_emp_fem)
lprop(tab_3_8_enquete_fem_emp)
# par sexe : pas trop d'écart 
tab_3_8_fh <- svytable(~ Sexe_1H_2F +travail_3_8, dw_emp)
lprop(tab_3_8_fh)

# Travail en weekend : attention il manque des années 
# age : diminue un peu avec l'age 
tab_weekend_age_emp <- svytable(~ Age_tranche+trav_weekend, dw_emp)
lprop(tab_weekend_age_emp)
tab_weekend_age_fem_emp <- svytable(~ Age_tranche+trav_weekend, dw_emp_fem)
lprop(tab_weekend_age_fem_emp)
# par année d'enquête : relativement stable 
tab_weekend_enquete_emp <- svytable(~ Annee_enquete+trav_weekend, dw_emp)
lprop(tab_weekend_enquete_emp)
tab_weekend_enquete_fem_emp <- svytable(~ Annee_enquete +trav_weekend, dw_emp_fem)
lprop(tab_weekend_enquete_fem_emp)
# par sexe : pas trop d'écart 
tab_weekend_fh <- svytable(~ Sexe_1H_2F +trav_weekend, dw_emp)
lprop(tab_weekend_fh)

# Travail en soirée ou la nuit : attention il manque des années 
# par âge : plutot stable alors que pour les femmes on voit que ca diminue un peu avec l'âge 
tab_soir_nuit_age_emp <- svytable(~ Age_tranche+trav_soir_nuit, dw_emp)
lprop(tab_soir_nuit_age_emp)
tab_soir_nuit_age_fem_emp <- svytable(~ Age_tranche+trav_soir_nuit, dw_emp_fem)
lprop(tab_soir_nuit_age_fem_emp)
# par année d'enquête :  très stable 
tab_soir_nuit_enquete_emp <- svytable(~ Annee_enquete+trav_soir_nuit, dw_emp)
lprop(tab_soir_nuit_enquete_emp)
tab_soir_nuit_enquete_fem_emp <- svytable(~ Annee_enquete +trav_soir_nuit, dw_emp_fem)
lprop(tab_soir_nuit_enquete_fem_emp)
# par sexe : différence FH : plus fréquent H
tab_soir_nuit_fh <- svytable(~ Sexe_1H_2F +trav_soir_nuit, dw_emp)
lprop(tab_soir_nuit_fh)

# existence de plusieurs emploi ?
# par âge : peu de cumul, un peu plu sfréquent ches les jeunes mais pas sur qu ece soit signifi
tab_autre_emp_age_emp <- svytable(~ Age_tranche+exist_autre_emploi, dw_emp)
lprop(tab_autre_emp_age_emp)
tab_autre_emp_age_fem_emp <- svytable(~ Age_tranche+exist_autre_emploi, dw_emp_fem)
lprop(tab_autre_emp_age_fem_emp)
# par année d'enquête :petite evol, et moins fréquent chz les femmes au début des années 2000
tab_autre_emp_enquete_emp <- svytable(~ Annee_enquete+exist_autre_emploi, dw_emp)
lprop(tab_autre_emp_enquete_emp)
tab_autre_emp_enquete_fem_emp <- svytable(~ Annee_enquete +exist_autre_emploi, dw_emp_fem)
lprop(tab_autre_emp_enquete_fem_emp)
# par sexe : pas trop d'écart 
tab_autre_emp_fh <- svytable(~ Sexe_1H_2F +exist_autre_emploi, dw_emp)
lprop(tab_autre_emp_fh)

# Faire les different croisements avec les variables de postes atypiques ?
# Peut être pas si intéressant vu les premiers résultats, on va plutot travailler sur les indicateurs

# Narrive pas a trouver un temps plein et donc est en tp 
# par âge : de moins en mois de difficulté avec l'âge mais etonnameent pas la même chose pour les femmes (plus stable)
tab_pas_tmpspl_age <- svytable(~ Age_tranche+raisons_tp_abs_plein, dw_tot)
lprop(tab_pas_tmpspl_age)
tab_pas_tmpspl_age_emp <- svytable(~ Age_tranche+raisons_tp_abs_plein, dw_emp)
lprop(tab_pas_tmpspl_age_emp)
tab_pas_tmpspl_age_fem <- svytable(~ Age_tranche+raisons_tp_abs_plein, dw_fem)
lprop(tab_pas_tmpspl_age_fem)
tab_pas_tmpspl_age_fem_emp <- svytable(~ Age_tranche+raisons_tp_abs_plein, dw_emp_fem)
lprop(tab_pas_tmpspl_age_fem_emp)
# par année d'enquête : croissance de la difficulté a trouvé un temps plein plutot qu'un temps partiel sur tout chez les femmes (attention au effet basculement vers le chomage)
tab_pas_tmpspl_enquete <- svytable(~ Annee_enquete +raisons_tp_abs_plein, dw_tot)
lprop(tab_pas_tmpspl_enquete)
tab_pas_tmpspl_enquete_emp <- svytable(~ Annee_enquete+raisons_tp_abs_plein, dw_emp)
lprop(tab_pas_tmpspl_enquete_emp)
tab_pas_tmpspl_enquete_fem <- svytable(~ Annee_enquete +raisons_tp_abs_plein, dw_fem)
lprop(tab_pas_tmpspl_enquete_fem)
tab_pas_tmpspl_enquete_fem_emp <- svytable(~ Annee_enquete +raisons_tp_abs_plein, dw_emp_fem)
lprop(tab_pas_tmpspl_enquete_fem_emp)
# par sexe : pas trop d'écart 
tab_pas_tmpspl_fh <- svytable(~ Sexe_1H_2F +raisons_tp_abs_plein, dw_emp)
lprop(tab_pas_tmpspl_fh)
# N'arrive pas a trouver un cdi 
# par âge : de moins en mois de difficulté avec l'âge mais pas etonnant 
tab_trouv_pas_cdi_age <- svytable(~ Age_tranche+raisons_cdd_trouve_ps_cdi, dw_tot)
lprop(tab_trouv_pas_cdi_age)
tab_trouv_pas_cdi_age_emp <- svytable(~ Age_tranche+raisons_cdd_trouve_ps_cdi, dw_emp)
lprop(tab_trouv_pas_cdi_age_emp)
tab_trouv_pas_cdi_age_fem <- svytable(~ Age_tranche+raisons_cdd_trouve_ps_cdi, dw_fem)
lprop(tab_trouv_pas_cdi_age_fem)
tab_trouv_pas_cdi_age_fem_emp <- svytable(~ Age_tranche+raisons_cdd_trouve_ps_cdi, dw_emp_fem)
lprop(tab_trouv_pas_cdi_age_fem_emp)
# par année d'enquête : pas très intéressant, relativement stable - attention bug certaines années
tab_trouv_pas_cdi_enquete <- svytable(~ Annee_enquete +raisons_cdd_trouve_ps_cdi, dw_tot)
lprop(tab_trouv_pas_cdi_enquete)
tab_trouv_pas_cdi_enquete_emp <- svytable(~ Annee_enquete+raisons_cdd_trouve_ps_cdi, dw_emp)
lprop(tab_trouv_pas_cdi_enquete_emp)
tab_trouv_pas_cdi_enquete_fem <- svytable(~ Annee_enquete +raisons_cdd_trouve_ps_cdi, dw_fem)
lprop(tab_trouv_pas_cdi_enquete_fem)
tab_trouv_pas_cdi_enquete_fem_emp <- svytable(~ Annee_enquete +raisons_cdd_trouve_ps_cdi, dw_emp_fem)
lprop(tab_trouv_pas_cdi_enquete_fem_emp)
# par sexe : pas trop d'écart 
tab_trouv_pas_cdi_fh <- svytable(~ Sexe_1H_2F +raisons_cdd_trouve_ps_cdi, dw_emp)
lprop(tab_trouv_pas_cdi_fh)

# indice de précarité
# par âge : les jeuens semblenty plus précaire -(diminue avec l'âge)
tab_precarit_age_emp <- svytable(~ Age_tranche+indic_precarite_emp, dw_emp)
lprop(tab_precarit_age_emp)
tab_precarit_age_fem_emp <- svytable(~ Age_tranche+indic_precarite_emp, dw_emp_fem)
lprop(tab_precarit_age_fem_emp)
# par année d'enquête : augmentation de la précariation, en absolu et en intensité 
tab_precarit_enquete_emp <- svytable(~ Annee_enquete+indic_precarite_emp, dw_emp)
lprop(tab_precarit_enquete_emp)
tab_precarit_enquete_fem_emp <- svytable(~ Annee_enquete +indic_precarite_emp, dw_emp_fem)
lprop(tab_precarit_enquete_fem_emp)
# par sexe : femmes plus précaires 
tab_precarit_fh <- svytable(~ Sexe_1H_2F +indic_precarite_emp, dw_emp)
lprop(tab_precarit_fh)

# indice de penibilité : attention beaucoup d'indicateur dispo qu'a partir de 2006
# par âge : ca décroit avec l'age globalement mais certaines intensités sont peut être plus stables 
# Pas toute a fait la même chose pour les femmes, c'est plus marqué 
tab_penibilit_age_emp <- svytable(~ Age_tranche+indic_penibilite_emp, dw_emp)
lprop(tab_penibilit_age_emp)
tab_penibilit_age_fem_emp <- svytable(~ Age_tranche+indic_penibilite_emp, dw_emp_fem)
lprop(tab_penibilit_age_fem_emp)
# par année d'enquête : augmentation de la penibilité mais plus subtil/stable pourles femmes
tab_penibilit_enquete_emp <- svytable(~ Annee_enquete+indic_penibilite_emp, dw_emp)
lprop(tab_penibilit_enquete_emp)
tab_penibilit_enquete_fem_emp <- svytable(~ Annee_enquete +indic_penibilite_emp, dw_emp_fem)
lprop(tab_penibilit_enquete_fem_emp)
# par sexe : ca me semble proche mais attention si on enlève les années a pb (avec l'analyse par periode)
tab_penibilit_fh <- svytable(~ Sexe_1H_2F +indic_penibilite_emp, dw_emp)
lprop(tab_penibilit_fh)

# Si on voit une évolution marquante, regarder par qui elle est porté dans chaque sous-population : 
# les familles monoparentales, les familles avec jeunes enfants, au contraire les personnes seules, les moins diplomées etc.

# On peut aussi essayer d'explorer le type d'emploi par le secteur dans cette partie / voir si ca vaut le temps de travail : peut être ciblé que certains secteurs