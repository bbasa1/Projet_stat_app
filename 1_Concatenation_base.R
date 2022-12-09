library(readr)
# install.packages("data.table")
library(data.table)
library(ggplot2)
# install.packages('viridis')
library(viridis)
library(dplyr)
# install.packages("data.table", repos="http://R-Forge.R-project.org")



################################################################################
################### PARAMETRES DIVERS ET VARIES ################################
################################################################################


url_sorties_graphiques <- "C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Sorties_graphiques"


# liste_annees <- 1998:2018 #La liste complète. Peut faire crash le PC car trop lourd en RAM
liste_annees <- 1998:2010
liste_pathes <- paste("C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Repo_codes/Data/YearlyFiles_1998_2018/FR", liste_annees, sep = "")
liste_pathes_2 <- paste(liste_pathes, "y.csv", sep = "_")




################################################################################
########################### CREATION DE LA BASE ################################
################################################################################

# Première importation
data_merged <- read_csv(liste_pathes_2[1], 
                        locale = locale(encoding ="UTF-8"),
                        show_col_types = FALSE)
data_merged <- as.data.table(data_merged)



liste_longeurs <- list(nrow(data_merged))


# Boucle sur les années
for (indice in seq_along(liste_pathes_2)[c(-1)]){
  # Pour situer dans la boucle :
  path <- liste_pathes_2[indice]
  annee <- liste_annees[indice]
  print(paste("Année =", annee,"|",nrow(data_merged), "lignes | path = ", path, sep = " "))
  
  # Importation
  data_loc <- read_csv(path,
                       locale = locale(encoding ="UTF-8"),
                       show_col_types = FALSE
  )
  data_loc <- as.data.table(data_loc)
  
  
  # Concaténation
  data_merged <- rbindlist(list(data_merged,
                                data_loc))
  
  
  liste_longeurs <- append(liste_longeurs,nrow(data_merged))
}


# Une copie de la liste. On ne sait jamais (et ça ne manche pas de pain !)
liste_longeurs_list <- copy(liste_longeurs)





########## PLOTS des longueurs des data.table obtenus ###############


df_plot <- list(annee = liste_annees,
                population = liste_longeurs_list)

df_plot <- as.data.table(df_plot)
df_plot <- df_plot[ , population := as.numeric(population)]
df_plot <- df_plot[ , annee := as.character(annee)]



ggplot(data = df_plot) + 
  geom_bar(aes(x = annee, y = population), stat="identity") + 
  labs(title="Longueur de la table après concaténation jusqu'à l'année x",
       x="Année",
       y="Population") + 
  scale_y_continuous(labels = function(y) format(y, scientific = FALSE))






################################################################################
################### PREPARATION GENERALE DE LA BASE ############################
################################################################################

liste_variables <- c('QHHNUM', #Identifiant ménage
                     # 'COEFFY', #Yearly weighting factor,
                     # 'COEFFH', #Yearly weighting factor of the sample for household characteristics
                     'COEFF',
                     'COUNTRY',
                     'SEX',
                     'YEAR',
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

data_merged <- data_merged[,..liste_variables]
data_merged <- copy(data_merged_copy)


######### Renaming des variables conservées ######################
setnames(data_merged,'QHHNUM',"Identifiant_menage")
# setnames(data_merged,'HHNUM',"Pondération du ménage")
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


data_merged




################################################################################
################### UN PREMIER CALCUL DE TAUX D'EMPLOI #########################
################################################################################

#Juste par sexe
calculs_sexe <- data_merged %>% 
  group_by(Sexe_1H_2F) %>% 
  summarize( population = sum(COEFF),
             population_active = sum( COEFF * (Statut_emploi_1_emploi %in% c("1","2"))),
             population_emplois = sum( COEFF * (Statut_emploi_1_emploi==1))) %>% 
  dplyr::mutate(tx_activite = round(population_active/population , 3),
                tx_emploi = round(population_emplois/population , 3),
                population = round(population / 1000 , 2),
                population_active = round(population_active / 1000 , 2),
                population_emplois = round(population_emplois / 1000 , 2))

calculs_sexe <- as.data.table(calculs_sexe)




#Par sexe et par age
calculs_age <- data_merged %>% 
  group_by(Age_tranche, Sexe_1H_2F) %>% 
  summarize( population = sum(COEFF),
             population_active = sum( COEFF * (Statut_emploi_1_emploi %in% c("1","2"))),
             population_emplois = sum( COEFF * (Statut_emploi_1_emploi==1))) %>% 
  dplyr::mutate(tx_activite = round(100 * population_active/population , 3),
                tx_emploi = round(100 * population_emplois/population , 3),
                population = round(population / 1000 , 2),
                population_active = round(population_active / 1000 , 2),
                population_emplois = round(population_emplois / 1000 , 2))

calculs_age <- as.data.table(calculs_age)





########## PLOTS TAUX D'ACTIVITE ET D'EMPLOI PAR AGE ET SEXE ###############
calculs_age[, indice_bar := Age_tranche] #Pour pouvoir ordonner facilement les barres entre elles


calculs_age <- calculs_age[ , Sexe_1H_2F := as.character(Sexe_1H_2F)]
calculs_age <- calculs_age[ , Age_tranche := as.integer(Age_tranche)]


calculs_age[, Sexe_1H_2F:= factor(
  fcase(
    Sexe_1H_2F == 1, "Hommes",
    Sexe_1H_2F == 2, "Femmes"
  )
)
]

calculs_age[, Age_tranche:= factor(
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

setnames(calculs_age,'Sexe_1H_2F',"SEXE")



##### Les taux d'activité
titre = paste("Taux d'activité par âge et par sexe,\n moyenne entre", toString(liste_annees[1]), "et", toString(tail(liste_annees, n=1)))

p <- ggplot(data = calculs_age, aes(x = reorder(Age_tranche, indice_bar), y = tx_activite, fill = SEXE)) + 
  geom_bar(stat="identity", position=position_dodge()) + 
  labs(title=titre,
       x="Tranche d'âge",
       y="Taux d'activité") + 
  scale_y_continuous(limits = c(0, 100), labels = function(y) format(y, scientific = FALSE)) + 
  scale_fill_discrete() +
  scale_color_viridis() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))

p
ggsave(paste(url_sorties_graphiques, "Taux_activite_age_sexe.pdf", sep ='/'), p ,  width = 297, height = 210, units = "mm")



##### Et les taux d'emploi
titre = paste("Taux d'empoi par âge et par sexe,\n moyenne entre", toString(liste_annees[1]), "et", toString(tail(liste_annees, n=1)))

p <- ggplot(data = calculs_age, aes(x = reorder(Age_tranche, indice_bar), y = tx_emploi, fill = SEXE)) + 
  geom_bar(stat="identity", position=position_dodge()) + 
  labs(title=titre,
       x="Tranche d'âge",
       y="Taux d'emploi") + 
  scale_y_continuous(limits = c(0, 100), labels = function(y) format(y, scientific = FALSE)) + 
  scale_fill_discrete() +
  scale_color_viridis() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))

p
ggsave(paste(url_sorties_graphiques, "Taux_emploi_age_sexe.pdf", sep ='/'), p ,  width = 297, height = 210, units = "mm")


