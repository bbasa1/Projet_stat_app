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


data_merged

data_merged[, c('Identifiant_menage', 'Annee_enquete') :=NULL]  # remove two columns

data_merged

rs = split(seq(nrow(data_merged)), data_merged$Temps_partiel)
data_merged[, names(rs) := FALSE ]
for (n in names(rs)) set(data_merged, i = rs[[n]], j = n, v = TRUE )

PCA(df, scale.unit = TRUE, ncp = 5, graph = TRUE)


data_merged



