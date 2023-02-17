################################################################################
################### PROGRAMMES POUR LE STATP ################################
################################################################################


################################################################################
 #                      PREAMBULE               ===============================
################################################################################


################################################################################
#            A. PARAMETRES              -------------------------------
################################################################################
repgen <- "C:/Users/Benjamin/Desktop/Ensae/Projet_statapp"#BB
# repgen <- "C:/Users/Lenovo/Desktop/statapp22"#LP
# repgen <- "/Users/charlottecombier/Desktop/ENSAE/Projet_statapp"


annee <- 2000
liste_pays <- c("FR", "ES", "IT", "DE", "DK", "AT")

nom_fichier_html <- paste("Modelisation", annee, sep = "_")

creer_base <- FALSE

repo_prgm <- paste(repgen, "programmes/Projet_stat_app" , sep = "/")

repo_sorties <- paste(repgen, "sorties" , sep = "/")

repo_data <- paste(repgen, "Data" , sep = "/")

repo_inter <- paste(repgen, "bases_intermediaires" , sep = "/")

rep_html <- paste(repgen, "pages_html" , sep="/")

liste_variables <- c('QHHNUM', #Identifiant ménage
                     'COUNTRY',
                     'SEX',
                     'YEAR',
                     'AGE',
                     'ILOSTAT', # ILO working status. 1 = employed. 2 = Unemployed. 3 = inactive. 4 = Compulsory military service. 5 = persons < 15 years old
                     'WSTATOR', # Labor status during the reference week (for aged >15 years). 1 = worked at least 1 hours. 2 =  Vacances/service militaire/... 3 = licencicé. 4 = Service militaire ou civique. 5 = Autre.
                     'WANTWORK', # Willingness to work for person not seeking employment. 1 = but would nevertheless like to have work. 2 = does not want to have work. 9 = not applicable
                     'WISHMORE', # Wish to work usually more than the current number of hours. 0 = No. 1 = Yes
                     'DEGURBA', # Degree of urbanisation. 1 = Densely. 2 = intermediate. 3 = rural
                     'FTPT', # 1 = Full-time. 2 = Part-time job.
                     'TEMP', # 1 = CDI. 2 = CDD
                     'HATLEV1D', # Level of education. L = low. M = Medium. H = High
                     'HHNBCH2' # Number of children [0,2] years in the household
)

age_min <- 20
age_max <- 59
mettre_coeffs_nan_a_zero <- FALSE


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
  data_merged <- fnt_creation_base_modelisation()
}else{
  nom_base <- paste(repo_data, "/data_intermediaire/base_", annee, ".Rdata", sep = "")
  load(file = nom_base)
}


data_merged

################################################################################
#            II. NETTOYAGE, PREPARATION                        ===============================
################################################################################
source(paste(repo_prgm , "03_nettoyage.R" , sep = "/"))
# 100 * nrow(data_merged[is.na(COEFF), ])/nrow(data_merged)

### On commence par filtrer sur l'âge
data_merged <- data_merged[Age_tranche - 2 >= age_min, ]
data_merged <- data_merged[Age_tranche + 2 <= age_max, ]

data_merged

#On vire les identifiants et les années d'enquête
data_merged[, c('Identifiant_menage', 'Annee_enquete') :=NULL]  # remove two columns

data_merged

# On encode les variables catégorielles en dummies, en n'oubliant pas de supprimer les colonnes initiales
liste_cols_dummies <- c("Niveau_education", "Perennite_emploi", "Temps_partiel", "Dregre_urbanisation", "Souhaite_davantage_travailler", "Souhaite_travailler", "Statut_semaine", "Statut_emploi_1_emploi", "Sexe_1H_2F", "Pays")
for (colonne in liste_cols_dummies){
  rs = split(seq(nrow(data_merged)), data_merged[, ..colonne])
  # data_merged[, names(paste(colonne, rs, sep = "_")) := 0 ]
  for (n in names(rs)) set(data_merged, i = rs[[n]], j = paste(colonne, n, sep = "_"), v = 1)
}


# On rajoute une modalité pour les variables continues : Le NA ou le 9999
liste_cols_cont <- c("Nb_enfants_moins_2_ans", "Age_tranche")
for (colonne in liste_cols_cont){
  data_merged[colonne == 99, paste(colonne, "9999", sep = "_") := 1]
}


# Il faut passer le nb d'enfants en numérique pour ne pas avoir de problème
data_merged[ , Nb_enfants_moins_2_ans := as.numeric(Nb_enfants_moins_2_ans)] #### A VERIFIER 


data_merged[, eval(liste_cols_dummies) :=NULL]  # remove columns


# On supprime les 
liste_cols_delete <- paste(liste_cols_dummies, "9999", sep = "_")
data_merged[, eval(liste_cols_delete) :=NULL]  # remove columns

data_merged[is.na(data_merged)] <- 0



resultats_acp  <- PCA(data_merged, scale.unit = TRUE, ncp = 5, graph = FALSE)

get_eigenvalue(resultats_acp)
fviz_eig(resultats_acp, addlabels = TRUE)


fviz_pca_var(resultats_acp)


### On essaie du clustering

data_merged_scale <- scale(data_merged)
data_merged_scale <- as.data.table(data_merged_scale)
data_merged_scale[is.na(data_merged_scale)] <- 0

# 
# data_merged_scale[, lapply(.SD, function(x) sum(is.na(x)))]
# 
# data_merged_scale
# str(data_merged_scale)

resKM <- kmeans(data_merged_scale, centers=3,nstart=20)
resKM


sample <- as.data.table(sapply(data_merged_scale[], sample, 10000))


factoextra::fviz_nbclust(sample, FUNcluster =factoextra::hcut, method = "silhouette",hc_method = "average", hc_metric = "euclidean", stand = TRUE)


sample[, eval(c("Nb_enfants_moins_2_ans_99", "Age_tranche_99")) := NULL]

resKM <- kmeans(sample, centers=3, nstart=20, kmeans_init_iter_max=10000000)
resKM

fviz_cluster(resKM, sample)




# 
# rs = split(seq(nrow(data_merged)), data_merged$Temps_partiel)
# # data_merged[, names(rs) := 0 ]
# 
# # paste("Temps_partiel", rs, sep = "_")
# 
# data_merged[, names(paste("Temps_partiel", rs, sep = "_")) := 0 ]
# data_merged
# for (n in names(rs)) set(data_merged, i = rs[[n]], j = paste("Temps_partiel", n, sep = "_"), v = 1)
# # for (n in names(rs)){data_merged[is.na(paste("Temps_partiel", n, sep = "_")), paste("Temps_partiel", n, sep = "_") = 0]}
# data_merged
# 
# n = 1
# 
# names(paste("Temps_partiel", n, sep = "_"))
# data_merged[is.na(names(paste("Temps_partiel", n, sep = "_")))]




data_merged



