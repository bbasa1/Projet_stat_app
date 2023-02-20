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


################################################################################
#            III. PREPARATION DE LA MODELISATION             ===============================
################################################################################

liste_cols_dummies <- c("Niveau_education", "Perennite_emploi", "Temps_partiel", "Dregre_urbanisation", "Souhaite_davantage_travailler", "Souhaite_travailler", "Statut_semaine", "Statut_emploi_1_emploi", "Sexe_1H_2F", "Pays")
liste_cols_cont <- c("Nb_enfants_moins_2_ans", "Age_tranche")
liste_cols_to_delete <- c('Identifiant_menage', 'Annee_enquete', "Sexe_1H_2F")


liste_var_sup <- c("Pays_AT", "Pays_DE", "Pays_DK", "Pays_ES", "Pays_FR", "Pays_IT") #Pour le cercle des corrélations

n_sample <- 1000 #La taille de l'échantillon pour la PCA (déso Laurie sans doute que si tu mets plus que 10 ton PC va mourir mdr)

data_merged

source(paste(repo_prgm , "07_preparation_modelisation.R" , sep = "/"))


################################################################################
#            IV. MODELISATION             ===============================
################################################################################
data_merged

### NOTE : Je laisse le script 08_modelisation.R vide pour le moment. 
# Quand on aura une idée de la façon dont on veut l'organiser on pourra le remplir avec le script en dessous :


####### LA PCA #######################

resultats_acp  <- PCA(data_merged, scale.unit = TRUE, ncp = 5, ind.sup = liste_indices_sup,
                      quanti.sup=NULL, quali.sup=NULL, graph=FALSE)

get_eigenvalue(resultats_acp)
fviz_eig(resultats_acp, addlabels = TRUE)


fviz_pca_var(resultats_acp,  choix = "var")


######### Les KMEANS ######################

#On prépare tout d'abord un petit échantillon au cas où
sample <- as.data.table(sapply(data_merged[], sample, n_sample))


# Il faut retirer les colonnes cstes pour pas faire bug l'ACP...
names(sample[, sapply(df, function(v) var(v, na.rm=TRUE)==0)]) 
sample[,sapply(sample, function(v) var(v, na.rm=TRUE)!=0)] 


### On normalise tout ça
data_merged_scale <- scale(data_merged)
data_merged_scale <- as.data.table(data_merged_scale)
data_merged_scale[is.na(data_merged_scale)] <- 0

sample_ <- scale(sample)
sample <- as.data.table(sample)
sample[is.na(sample)] <- 0





### Pour trouver le nombre de clusters ==> Ne marche pas terrible et prend 50 ans à tourner...
# factoextra::fviz_nbclust(sample, FUNcluster =factoextra::hcut, method = "silhouette",hc_method = "average", hc_metric = "euclidean", stand = TRUE) 


resKM <- kmeans(data_merged_scale, centers=2, nstart=20)
resKM
# data_merged_scale[, eval(c("Nb_enfants_moins_2_ans_9999", "Age_tranche_9999", "Sexe_1H_2F_2")) := NULL]


fviz_cluster(resKM, data_merged_scale)







etude_clus <- clusGap(sample, FUNcluster=pam, K.max=7)
etude_clus_DF <- as.data.frame(etude_clus$Tab) 

# Voir https://towardsdatascience.com/k-means-clustering-and-the-gap-statistics-4c5d414acd29 pour détails

ggplot(etude_clus_DF, aes(x=1:nrow(etude_clus_DF))) +
  geom_line(aes(y=logW), color="blue") +
  geom_point(aes(y=logW), color="blue") +
  geom_line(aes(y=E.logW), color="green") +
  geom_point(aes(y=E.logW), color="green") +
  labs(x="Number of Clusters", title = "Dissimilarité intra-cluster \n vert = Uniforme; bleu = Observé")


ggplot(etude_clus_DF, aes(x=1:nrow(etude_clus_DF))) +
  geom_line(aes(y=gap), color="red") +
  geom_point(aes(y=gap), color="red") +
  geom_errorbar(aes(ymin=gap-SE.sim, ymax=gap+SE.sim), color="red") +
  labs(x="Number of Clusters", y="Gap", "Ecart statistique entre les deux")




########## BROUILLON #######################


# summary(sample)


fviz_cluster(resKM, sample)

# 
# data_merged_scale[, lapply(.SD, function(x) sum(is.na(x)))]
# 
# data_merged_scale
# str(data_merged_scale)

resKM <- kmeans(data_merged_scale, centers=3,nstart=20)
resKM

# factoextra::fviz_nbclust(data_merged_scale, FUNcluster =factoextra::hcut, method = "silhouette",hc_method = "average", hc_metric = "euclidean", stand = TRUE)

sample <- as.data.table(sapply(data_merged_scale[], sample, 10000))


# factoextra::fviz_nbclust(sample, FUNcluster =factoextra::hcut, method = "silhouette",hc_method = "average", hc_metric = "euclidean", stand = TRUE)


# sample[, eval(c("Nb_enfants_moins_2_ans_9999", "Age_tranche_9999", "Sexe_1H_2F_2")) := NULL]

sample
# , kmeans_init_iter_max=10000
resKM <- kmeans(sample, centers=2, nstart=20)
resKM


# summary(sample)


fviz_cluster(resKM, sample)
# 
# fviz_cluster(res.km, data = df[, -5],
#              palette = c("#2E9FDF", "#00AFBB", "#E7B800"), 
#              geom = "point",
#              ellipse.type = "convex", 
#              ggtheme = theme_bw()
# )

# 
# ########### Et un peu de KNN
# ran <- sample(1:nrow(data_merged), 0.9 * nrow(data_merged)) 
# 
# ##the normalization function is created
# nor <-function(x) { (x -min(x))/(max(x)-min(x))   }
# 
# ##Run nomalization on first 4 coulumns of dataset because they are the predictors
# data_merged_norm <- as.data.table(lapply(data_merged, nor))
# data_merged_norm
# data_merged_norm[, eval(c("Nb_enfants_moins_2_ans_9999", "Age_tranche_9999", "Sexe_1H_2F_2")) := NULL]
# 
# 
# 
# # summary(iris_norm)
# ##extract training set
# iris_train <- data_merged_norm[ran,] 
# ##extract testing set
# iris_test <- data_merged_norm[-ran,] 
# 
# library(class)
# 
# 
# y_train <- iris_train$Statut_emploi_1_emploi_1
# y_test <- iris_test$Statut_emploi_1_emploi_1
# iris_train[, Statut_emploi_1_emploi_1 := NULL]
# iris_test[, Statut_emploi_1_emploi_1 := NULL]
# 
# 
# pr <- knn(iris_train,iris_test,cl=y_train,k=13)
# 
# ##create confusion matrix
# tab <- table(pr,y_test)
# 
# ##this function divides the correct predictions by total number of predictions that tell us how accurate teh model is.
# 
# accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
# accuracy(tab)
# 
# data_merged
# 
# 

