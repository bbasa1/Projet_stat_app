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


liste_annees <- 2000:2002

liste_pays <- c("FR", "ES", "IT", "DE", "PT", "HU")

nom_fichier_html <- paste("Modelisation", liste_annees[1], liste_annees[length(liste_annees)], sep = "_")

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
                     'HHNBCH2', # Number of children [0,2] years in the household
                     'HHNBCH5',
                     'FTPTREAS',
                     'ISCO3D'
                     
)

age_min <- 20
age_max <- 59
mettre_coeffs_nan_a_zero <- FALSE
planter_si_non_specifie <- FALSE #Plante si toutes les varibales ne sont pas spécifiées (dummies, continues ou à supprimer). Autrement il supprime les non spécifiées



liste_cols_cont <- c("Nb_enfants_moins_2_ans","Nb_enfants_entre_3_5_ans", "Age_tranche")
liste_cols_dummies <- c("Niveau_education", "Temps_partiel", "Pays", "Raisons_temps_partiel", "CSP")
liste_cols_to_delete <- c('Identifiant_menage', "Sexe_1H_2F")

kmeans_sur_proj <- FALSE


liste_var_sup <- c("Pays_HU", "Pays_DE", "Pays_DK", "Pays_ES", "Pays_FR", "Pays_IT") #Pour le cercle des corrélations

n_sample <- 10000 #La taille de l'échantillon pour la PCA 
methode <- "manhattan"
#manhattan = distance L1
#euclidean = distance L2
#Chebychev = disrance L^infini
inter_max <- 25 #Le nb de fois qu'il itère au maximum

nb_axes_ACM <- 5

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
  nom_base <- paste(repo_data, "/data_intermediaire/base_", liste_annees[1],"_", liste_annees[length(liste_annees)], ".Rdata", sep = "")
  load(file = nom_base)
}




################################################################################
#            II. NETTOYAGE, PREPARATION                        ===============================
################################################################################
source(paste(repo_prgm , "03_nettoyage.R" , sep = "/"))
data_merged <- calcul_index_conservatisme(data_merged)

################################################################################
#            III. PREPARATION DE LA MODELISATION             ===============================
################################################################################

data_merged

source(paste(repo_prgm , "07_preparation_modelisation.R" , sep = "/"))


################################################################################
#            IV. MODELISATION    ===============================================
################################################################################
data_merged

################################################################################
#            LA PCA   ----------------------------------------------------------
################################################################################

resultats_acp  <- PCA(data_merged, scale.unit = TRUE, ncp = 5, ind.sup = liste_indices_sup,
                      quanti.sup=NULL, quali.sup=NULL, graph=FALSE)

get_eigenvalue(resultats_acp)
fviz_eig(resultats_acp, addlabels = TRUE)


fviz_pca_var(resultats_acp,  choix = "var")


################################################################################
#            L'ACM   -----------------------------------------------------------
################################################################################
data_merged_non_encoded
data_merged_non_encoded[, eval(liste_cols_to_delete) :=NULL] 
data_merged_non_encoded[is.na(data_merged_non_encoded)] <- 9999
data_merged_non_encoded

data_merged_non_encoded <- as.data.frame(data_merged_non_encoded)
for (i in 1:ncol(data_merged_non_encoded)){
  data_merged_non_encoded[,i] <- as.factor(data_merged_non_encoded[,i])
}

acm_results <- dudi.acm(data_merged_non_encoded, nf = nb_axes_ACM, scannf = FALSE)

fviz_screeplot(acm_results)
summary(acm_results)
inertia.dudi(acm_results)

s.corcircle(acm_results$co, 1, 2, clabel = 0.7)

fviz_mca_var(acm_results, repel = TRUE) #==> Plus visuel je trouve

numero_axe <- 2
fviz_contrib(acm_results, choice = "var", axes = numero_axe)

# On récupère la projection si on veut essayer les kmeans dessus
data_projected <- acm_results$li

################################################################################
#            LES KMEANS  -------------------------------------------------------
################################################################################

if(kmeans_sur_proj){
  # Alors il faut modifier data_merged
  data_kmeans <- copy(data_projected)
}else{
  data_kmeans <- copy(data_merged)
}

#############  PREPARATION ##################

#On prépare tout d'abord un petit échantillon au cas où
sample <- as.data.table(sapply(data_kmeans[], sample, n_sample))


data_kmeans_scaled <- scale(data_kmeans)
data_kmeans_scaled <- as.data.table(data_kmeans_scaled)
data_kmeans_scaled[is.na(data_kmeans_scaled)] <- 0


sample_scaled <- scale(sample)
sample_scaled <- as.data.table(sample_scaled)
sample_scaled[is.na(sample_scaled)] <- 0


# Il faut retirer les colonnes cstes pour pas faire bug l'ACP...
sample_scaled <- remove_constant(sample_scaled, na.rm = FALSE, quiet = FALSE)
data_kmeans_scale <- remove_constant(data_kmeans_scaled, na.rm = FALSE, quiet = FALSE)


############ POUR UNE RAISON QUI M'ECHAPPE LA FONCTION kmeans A L'AIR DE FAIRE DES CLUSTERS PLUS JOLIS############


########## Si votre PC tient le coup : pour trouver le nombre de clusters optimal ""à la main""
k2 <- Kmeans(data_kmeans_scale, centers = 2, nstart = 25, method = methode, iter.max=inter_max)
k3 <- Kmeans(data_kmeans_scale, centers = 3, nstart = 25, method = methode, iter.max=inter_max)
k4 <- Kmeans(data_kmeans_scale, centers = 4, nstart = 25, method = methode, iter.max=inter_max)
k5 <- Kmeans(data_kmeans_scale, centers = 5, nstart = 25, method = methode, iter.max=inter_max)

# plots to compare
p1 <- fviz_cluster(k2, geom = "point", data = data_kmeans_scale) + ggtitle("k = 2")
p2 <- fviz_cluster(k3, geom = "point",  data = data_kmeans_scale) + ggtitle("k = 3")
p3 <- fviz_cluster(k4, geom = "point",  data = data_kmeans_scale) + ggtitle("k = 4")
p4 <- fviz_cluster(k5, geom = "point",  data = data_kmeans_scale) + ggtitle("k = 5")

p <- grid.arrange(p1, p2, p3, p4, nrow = 2)


nom_graphe <- paste("00_graphe_clustering_", methode,"_kmeans_sur_proj_",kmeans_sur_proj, ".pdf", sep = "")
ggsave(paste(repo_sorties, nom_graphe, sep = "/"), p ,  width = 297, height = 210, units = "mm")

####################### VERIFICATION DU NB DE CLUSTERS OPTI ####################### 

# Elbow method
fviz_nbclust(sample_scaled, Kmeans, method = "wss") +
  # geom_vline(xintercept = 2, linetype = 2)+
  labs(subtitle = "Elbow method")
# For each value of K, we are calculating WCSS (Within-Cluster Sum of Square). 
# Kopti = le point d'inflexion ==> Moyen visible ici je trouve (table entière)
# Kopti = Idem (projection ACM)

# Silhouette method
fviz_nbclust(sample_scaled, Kmeans, method = "silhouette")+
  labs(subtitle = "Silhouette method")
# In short, the average silhouette approach measures the quality of a clustering. That is, it determines how well each object lies within its cluster. A high average silhouette width indicates a good clustering. The average silhouette method computes the average silhouette of observations for different values of k. The optimal number of clusters k is the one that maximizes the average silhouette over a range of possible values for k.
# Donne Kopti = 6 (table entière)
# Kopti = 2 (projection ACM)

# Gap statistic ==> Plus long à tourner attention
# nboot = 50 to keep the function speedy. 
# recommended value: nboot= 500 for your analysis.
# Use verbose = FALSE to hide computing progression.
set.seed(123)
fviz_nbclust(sample_scaled, Kmeans, nstart = 25,  method = "gap_stat", nboot = 50)+
  labs(subtitle = "Gap statistic method")
# The gap statistic compares the total intracluster variation for different values of k with their expected values under null reference distribution of the data (i.e. a distribution with no obvious clustering)
# Donne Kopti = 6 (table entière)
# Kopti = 6 (projection ACM)


####################### Une fois qu'on a trouvé le nb de clusters ####################### 
nb_clusters <- 3


# Sur le sample_scaled
sample_scaled
resKM_sample_scaled <- Kmeans(sample_scaled, centers=nb_clusters, nstart=30, method = methode)
resKM_sample_scaled
fviz_cluster(resKM_sample_scaled, sample_scaled)

# summary(resKM_sample_scaled)
# plot(sample_scaled, col = resKM_sample_scaled$cluster,pch=16,cex=1.2,main="Regroupement par les k-means")



# Sur toute la table
resKM <- Kmeans(data_kmeans_scale, centers=nb_clusters, nstart=30, method = methode)
resKM
p <- fviz_cluster(resKM, data_kmeans_scale)
nom_graphe <- paste("01_graphe_", methode,"_",nb_clusters, "_clusters","_kmeans_sur_proj_",kmeans_sur_proj, ".pdf", sep = "")
ggsave(paste(repo_sorties, nom_graphe, sep = "/"), p ,  width = 297, height = 210, units = "mm")


################################################################################
########## ANALYSE DU CLUSTERING ###############################################
################################################################################
source(paste(repo_prgm , "08_analyse_modelisation.R" , sep = "/"))


df_analyse_cluster_sample_scaled <- fonction_calcul_scoring_kmeans(sample_scaled, resKM_sample_scaled)
df_analyse_cluster <- fonction_calcul_scoring_kmeans(data_kmeans_scale, resKM)

df_analyse_cluster_sample_scaled
df_analyse_cluster
summary(df_analyse_cluster)
titre <- paste("Analyse_cluster_score_", methode,"_",nb_clusters, "_clusters","_kmeans_sur_proj_",kmeans_sur_proj, ".xlsx", sep = "")
write.xlsx(df_analyse_cluster, paste(repo_sorties,titre, sep = "/"))


100*resKM_sample_scaled$size/nrow(sample_scaled) ## La taille des clusters en % de l'effectif (sample_scaled)
100*resKM$size/nrow(data_kmeans_scale) ## La taille des clusters en % de l'effectif


################################################################################
#### Distribution par cluster ===> Pour faire des profils-types de femmes !!! ##
################################################################################
data_merged_copy <- copy(data_merged)

# On ajoute la prédiction du numéro de cluster
data_merged_copy$clustering <- resKM$cluster
sample$clustering <- resKM_sample_scaled$cluster



## Analyse d'une variable continue
variable <- "Age_tranche"
tapply(data_merged_copy[[variable]] , data_merged_copy$clustering, summary)


## Analyse d'une variable catégorielle
variable <- "Niveau_education_H"
counted_occurences <- as.data.table(data_merged_copy %>% count(clustering, !! rlang::sym(variable)))
counted_occurences[, n_norm_by_cluster := 100*n/sum(n), by = clustering]
counted_occurences[, n_norm_by_var := 100*n/sum(n), by = variable]
counted_occurences



## Analyse de toutes les variables catégorielles
liste_cols_dummies <- colnames(data_merged_copy)

# On ne garde que les cols catégorielles avec leurs modalités
# liste_cols_dummies <- liste_cols_dummies[! liste_cols_dummies %in% liste_cols_cont]
liste_cols_dummies <- liste_cols_dummies[! liste_cols_dummies %in% liste_cols_to_delete]
liste_cols_dummies <- liste_cols_dummies[! liste_cols_dummies %in% c('clustering')]
liste_cols_dummies

# Initialisation
variable <- liste_cols_dummies[1]
counted_occurences <- as.data.table(data_merged_copy %>% count(clustering, !! rlang::sym(variable)))
counted_occurences[, Pourcent_by_cluster := 100*n/sum(n), by = clustering]
counted_occurences[, Pourcent_by_modalite_var := 100*n/sum(n), by = variable]
setnames(counted_occurences, variable, "valeur_variable")
counted_occurences[, variable := variable]
counted_occurences_all <- counted_occurences

# Boucle sur toutes les colonnes
for (variable in liste_cols_dummies[c(-1)]){
  # print(variable)
  counted_occurences <- as.data.table(data_merged_copy %>% count(clustering, !! rlang::sym(variable)))
  counted_occurences[, Pourcent_by_cluster := 100*n/sum(n), by = clustering]
  counted_occurences[, Pourcent_by_modalite_var := 100*n/sum(n), by = variable]
  setnames(counted_occurences, variable, "valeur_variable")
  counted_occurences[, variable := variable]
  counted_occurences_all <- rbindlist(list(counted_occurences_all,
                                         counted_occurences), fill = TRUE)
}
  
counted_occurences_all
titre <- paste("Analyse_cluster_contenu_", methode,"_",nb_clusters, "_clusters","_kmeans_sur_proj_",kmeans_sur_proj, ".xlsx", sep = "")
write.xlsx(counted_occurences_all, paste(repo_sorties,titre, sep = "/"))
# write.xlsx(counted_occurences_all, paste(repo_sorties,"Analyse_cluster_contenu_cat_0.xlsx", sep = "/"))



## Pour tout regarder
# Option 1 : 
describeBy(data_merged_copy, group="clustering")

# Option 2 : 
data_merged_copy %>% 
  split(.$clustering) %>% 
  map(summary)


############### ESSAI DE LA DISTANCE GOWER ##################


data_merged_non_encoded

data_merged_non_encoded_sample <- as.data.table(sapply(data_merged_non_encoded[], sample, n_sample))
data_merged_non_encoded_sample <- as.data.frame(data_merged_non_encoded_sample)
for (i in 1:ncol(data_merged_non_encoded_sample)){
  data_merged_non_encoded_sample[,i] <- as.factor(data_merged_non_encoded_sample[,i])
}

gower_dist <- daisy(data_merged_non_encoded_sample,
                    metric = "gower")

summary(gower_dist)

gower_mat <- as.matrix(gower_dist)


# Choix nb clusters Kopti
sil_width <- c(NA)
for(i in 2:10){
  pam_fit <- pam(gower_dist,
                 diss = TRUE,
                 k = i)
  sil_width[i] <- pam_fit$silinfo$avg.width
  
}

# Plot sihouette width (higher is better)
plot(1:10, sil_width,
     xlab = "Number of clusters",
     ylab = "Silhouette Width")
lines(1:10, sil_width)

nb_clusters <- 4

pam_fit <- pam(gower_dist, diss = TRUE, k = nb_clusters)

pam_fit$clustering


# ################################################################################
# ##### BROUILLON : CLUSTERING GAP ###############################################
# ################################################################################
# etude_clus <- clusGap(sample_scaled, FUNcluster=pam, K.max=7)
# etude_clus_DF <- as.data.frame(etude_clus$Tab) 
# 
# # Voir https://towardsdatascience.com/k-means-clustering-and-the-gap-statistics-4c5d414acd29 pour détails
# 
# ggplot(etude_clus_DF, aes(x=1:nrow(etude_clus_DF))) +
#   geom_line(aes(y=logW), color="blue") +
#   geom_point(aes(y=logW), color="blue") +
#   geom_line(aes(y=E.logW), color="green") +
#   geom_point(aes(y=E.logW), color="green") +
#   labs(x="Number of Clusters", title = "Dissimilarité intra-cluster \n vert = Uniforme; bleu = Observé")
# 
# 
# ggplot(etude_clus_DF, aes(x=1:nrow(etude_clus_DF))) +
#   geom_line(aes(y=gap), color="red") +
#   geom_point(aes(y=gap), color="red") +
#   geom_errorbar(aes(ymin=gap-SE.sim, ymax=gap+SE.sim), color="red") +
#   labs(x="Number of Clusters", y="Gap", "Ecart statistique entre les deux")
# 
# 
# 
# ########## Dendogrammes
# hclust_sample_scaled <- hclust(d=dist(sample_scaled, method="euclidean"))
# plot(hclust_sample_scaled) ##ASsez illisible...
# 
# 
# distMatrix <- dist(sample_scaled, method="euclidean")
# groups <- hclust(distMatrix,method="ward.D")
# fviz_dend(groups, cex = 0.8, lwd = 0.8, k = 3, 
#           rect = TRUE, 
#           k_colors = "jco", 
#           rect_border = "jco", 
#           rect_fill = TRUE,
#           ggtheme = theme_gray(),labels=F)
# 
# 
# ########## BROUILLON #######################
# 
# 
# # summary(sample_scaled)
# 
# 
# fviz_cluster(resKM, sample_scaled)
# 
# # 
# # data_merged_scale[, lapply(.SD, function(x) sum(is.na(x)))]
# # 
# # data_merged_scale
# # str(data_merged_scale)
# 
# resKM <- Kmeans(data_merged_scale, centers=3,nstart=20)
# resKM
# 
# # factoextra::fviz_nbclust(data_merged_scale, FUNcluster =factoextra::hcut, method = "silhouette",hc_method = "average", hc_metric = "euclidean", stand = TRUE)
# 
# sample_scaled <- as.data.table(sapply(data_merged_scale[], sample_scaled, 10000))
# 
# 
# # factoextra::fviz_nbclust(sample_scaled, FUNcluster =factoextra::hcut, method = "silhouette",hc_method = "average", hc_metric = "euclidean", stand = TRUE)
# 
# 
# # sample_scaled[, eval(c("Nb_enfants_moins_2_ans_9999", "Age_tranche_9999", "Sexe_1H_2F_2")) := NULL]
# 
# sample_scaled
# # , Kmeans_init_iter_max=10000
# resKM <- Kmeans(sample_scaled, centers=2, nstart=20)
# resKM
# 
# 
# # summary(sample_scaled)
# 
# 
# fviz_cluster(resKM, sample_scaled)
# # 
# # fviz_cluster(res.km, data = df[, -5],
# #              palette = c("#2E9FDF", "#00AFBB", "#E7B800"), 
# #              geom = "point",
# #              ellipse.type = "convex", 
# #              ggtheme = theme_bw()
# # )
# 
