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

repgen <- "C:/Users/Benjamin/Desktop/Ensae/Projet_statapp"

liste_annees <- 1998:2018
pays <- "FR"

creer_base <- FALSE


repo_prgm <- paste(repgen, "programmes/Projet_stat_app" , sep = "/")

repo_sorties <- paste(repgen, "sorties" , sep = "/")

repo_data <- paste(repgen, "Data" , sep = "/")

repo_inter <- paste(repgen, "bases_intermediaires" , sep = "/")


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
                     'SEEKREAS', # Reasons for not searching an employment because. 1 = awaiting recall to work (persons on lay-off). 2 = of own illness or disability. 3 = looking after children or incapacitated adults (from 2006). 4 = of other personal or family responsibilities. 5 = of education or training. 6 = of retirement. 7 = of belief that no work is available. 8 = of other reasons
                     'DEGURBA', # Degree of urbanisation. 1 = Densely. 2 = intermediate. 3 = rural
                     'STAPRO', #Professional status. 1 = Self-employed with employees. 2 = Self-employed without employees. 3 = Employee. 4 = Family worker. 
                     'FTPT', # 1 = Full-time. 2 = Part-time job.
                     'ISCO3D',
                     'TEMP', # 1 = CDI. 2 = CDD
                     'TEMPDUR', # Total duration of temporary job or work contract of limited duration. 1 = Less than one month. 2 =1 to 3 months. 3 = 4 to 6 months. 4 = 7 to 12 months = 17. 5 = 13 to 18 months. 6 = 19 to 24 months. 7 = 25 to 36 months. 8 = More than 3 years
                     'FTPTREAS', # Reasons for the part-time work. 1 = Person is undergoing school education or training. 2 = Of own illness or disability. 3 =Looking after children or incapacitated adults. 4 = Other family or personal reasons (from 2006). 5 = Person could not find a full-time job. 6 = Other
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
                     'HHNBCH14' # Number of children [12,14] years in the household
)


################################################################################
#            B. PACKAGES              -------------------------------
################################################################################

source(paste(repo_prgm , "01_packages.R" , sep = "/"))


################################################################################
#            I. CREATION OU IMPOERT DE LA BASE   ===============================
################################################################################

# Soit on créé la table, soit on l'importe...
if(creer_base){
  source(paste(repo_prgm , "02_creation_base.R" , sep = "/"))
}else{
  nom_base <- paste(repo_data, "/data_intermediaire/base_", pays, ".Rdata", sep = "")
  load(file = nom_base)
}


################################################################################
#            II. NETTOYAGE, PREPARATION                        ===============================
################################################################################

source(paste(repo_prgm , "03_nettoyage.R" , sep = "/"))

################################################################################
#            II. CALCULS TAUX D'EMPLOIS ET ACTIVITE PAR ÂGE ET SEXE  ===============================
################################################################################

#            II.A Préparation               ------------------

# On récupère les fonctions
source(paste(repo_prgm , "04_calculs_tables.R" , sep = "/"))

# On calcule les taux d'activités et d'emplois par âge et sexe
liste_var <- c("Age_tranche", "Sexe_1H_2F")
calculs_age <- calcul_taux_emplois_activite(liste_var_groupby = liste_var)


#            II.B CONSTRUCTION GRAPHIQUES               ------------------
source(paste(repo_prgm , "05_sorties_graphiques.R" , sep = "/"))


# Phase de nettoyage
calculs_age <- nettoyage_tranche_age(calculs_age)
calculs_age <- nettoyage_sexe(calculs_age)
calculs_age
# calculs_age <- as.data.table(calculs_age)


# Puis de tracé
titre <- paste("Taux d'activité par âge et par sexe,\n moyenne entre", toString(liste_annees[1]), "et", toString(tail(liste_annees, n=1)))
titre_save <- paste(repo_sorties, "Taux_activite_age_sexe.pdf", sep ='/')
x <-"Age_tranche"
sortby_x <- "Indice_ages"
y <- "tx_activite"
fill <- "Sexe"
xlabel <-"Tranche d'âge"
ylabel <-"Taux d'activité"

trace_barplot(calculs_age, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save)


# Second tracé 
titre <- paste("Taux d'emploi par âge et par sexe,\n moyenne entre", toString(liste_annees[1]), "et", toString(tail(liste_annees, n=1)))
titre_save <- paste(repo_sorties, "Taux_emploi_age_sexe.pdf", sep ='/')
x <-"Age_tranche"
sortby_x <- "Indice_ages"
y <- "tx_emploi"
fill <- "Sexe"
xlabel <-"Tranche d'âge"
ylabel <-"Taux d'emploi"

trace_barplot(calculs_age, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save)




################################################################################
#            III. CALCULS TAUX D'EMPLOIS ET ACTIVITE PAR ÂGE, SEXE & ANNEE D'ENQUETE  ===============================
################################################################################

#            II.A Préparation               ------------------


# On calcule les taux d'activités et d'emplois par âge et sexe
liste_var <- c("Age_tranche", "Sexe_1H_2F", "Annee_enquete")
calculs_annee <- calcul_taux_emplois_activite(liste_var_groupby = liste_var)


#            II.B CONSTRUCTION GRAPHIQUES               ------------------

# Phase de nettoyage
calculs_annee <- nettoyage_tranche_age(calculs_annee)
calculs_annee <- nettoyage_sexe(calculs_annee)

sous_calculs_annee <- calculs_annee[Age_tranche %in% c("20-24 ans",
                                                       "25-29 ans", "30-34 ans",
                                                       "35-39 ans", "40-44 ans",
                                                       "45-49 ans", "50-54 ans",
                                                       "55-59 ans"
)]

# Puis de tracé
titre <- "Taux d'activité par âge, sexe et année d'enquête"
titre_save <- paste(repo_sorties, "Taux_activite_age_sexe_annee_enqu.pdf", sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "tx_activite"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Taux d'activité"
facet <- "Age_tranche"

trace_barplot_avec_facet(sous_calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet)

# Second tracé 
titre <- "Taux d'emploi par âge, sexe et année d'enquête"
titre_save <- paste(repo_sorties, "Taux_emploi_age_sexe_annee_enqu.pdf", sep ='/')
x <-"Annee_enquete"
sortby_x <- "Annee_enquete"
y <- "tx_emploi"
fill <- "Sexe"
xlabel <-"Année d'enquête"
ylabel <-"Taux d'emploi"
facet <- "Age_tranche"

trace_barplot_avec_facet(sous_calculs_annee, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet)



