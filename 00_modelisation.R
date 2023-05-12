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

### Ensemble des paramètres pour faire tourner au lundi 24 avril : 
kmeans_sur_proj <- FALSE
methode <- "euclidean"
#manhattan = distance L1
#euclidean = distance L2
#Chebychev = disrance L^infini
nb_clusters <- 4


faire_traces <- FALSE #Ca prend du temps à tourner...
faire_choix_k_opti <- FALSE
faire_PCA <- FALSE

### Ca ça ne bouge pas beaucoup normalement

# liste_annees <- 2000:2002
liste_annees <- 2017:2018

liste_pays <- c("FR", "ES", "IT", "DE", "PT", "HU")

nom_fichier_html <- paste("Modelisation", liste_annees[1], liste_annees[length(liste_annees)], sep = "_")

creer_base <- FALSE

repo_prgm <- paste(repgen, "programmes/Projet_stat_app" , sep = "/")

repo_sorties <- paste(repgen, "sorties" , sep = "/")

repo_data <- paste(repgen, "Data" , sep = "/")

repo_inter <- paste(repgen, "bases_intermediaires" , sep = "/")

rep_html <- paste(repgen, "pages_html" , sep="/")

liste_variables <- c('QHHNUM', #Identifiant ménage
                     "COEFF",
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
                     'FTPTREAS',
                     'ISCO3D',
                     'MARSTAT', #Statut marital
                     'MAINSTAT', #Pour savoir si au foyer #Pour indice précarité
                     'LOOKREAS',
                     'EXIST2J',
                     'HHPARTNR',
                     'SUPVISOR', #Manager
                     "WSTAT1Y",
                     'HHNBCH2', # Number of children [0,2] years in the household
                     'HHNBCH5',
                     "HHNBCH8",
                     "HHNBCH11",
                     "HHNBCH14",
                     "HHNBCH17",
                     "HHNBCH24",
                     "INCDECIL",
                     "HWUSUAL"
)


age_min <- 20
age_max <- 59
mettre_coeffs_nan_a_zero <- FALSE
planter_si_non_specifie <- FALSE #Plante si toutes les varibales ne sont pas spécifiées (dummies, continues ou à supprimer). Autrement il supprime les non spécifiées



liste_cols_cont <- c("Age_tranche", "Index_conservatisme", "nb_enf_tot", "Decile_salaire")
# liste_cols_cont <- c("Age_tranche", "Index_conservatisme")
liste_cols_dummies <- c("enf_m3ans","Niveau_education", "Temps_partiel_clean", "Pays", "raisons_tp_enf_fam", "sit_pro_foyer", "indic_precarite_emp_tot_final", "travail_respon")
liste_cols_to_delete <- c('Identifiant_menage', "Sexe_1H_2F")



liste_var_sup <- c("Pays_HU", "Pays_DE", "Pays_DK", "Pays_ES", "Pays_FR", "Pays_IT") #Pour le cercle des corrélations

n_sample <- 10000 #La taille de l'échantillon pour la PCA 
inter_max <- 25 #Le nb de fois qu'il itère au maximum
nb_axes_ACM <- 8

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

# data_merged$HWUSUAL

################################################################################
#            II. NETTOYAGE, PREPARATION                        ===============================
################################################################################
source(paste(repo_prgm , "03_nettoyage.R" , sep = "/"))
data_merged <- calcul_index_conservatisme(data_merged)
data_merged <- calcul_EQTP(data_merged)

 
# table(data_merged$Decile_salaire)
# table(data_merged[Pays == "FR"]$Decile_salaire)
# table(data_merged[Pays == "HU"]$Decile_salaire)
# table(data_merged[Pays == "IT"]$Decile_salaire)
# table(data_merged[Pays == "ES"]$Decile_salaire)
# table(data_merged[Pays == "DE"]$Decile_salaire)
# table(data_merged[Pays == "PT"]$Decile_salaire)

# table(data_merged$Pays)


################################################################################
#            III. PREPARATION DE LA MODELISATION             ===============================
################################################################################

# table(data_merged$travail_respon)

source(paste(repo_prgm , "07_preparation_modelisation.R" , sep = "/"))

# 1061428 lignes pour 28 colonnes au final


data_merged


# ####### Stat des sur les colonnes
# data_merged[is.na(data_merged$COEFF)] <- 0
# 
# liste_cols <- colnames(data_merged)[-1]
# colnames(data_merged)
# 
# dw_tot <- svydesign(ids = ~1, data = data_merged, weights = ~ data_merged$COEFF)
# 
# i <- "enf_m3ans_1"
# 
# for(i in liste_cols){
#   print(i)
#   print(freq(svytable(~ get(i) , dw_tot )))
# }
# 
# 
# table1<- svytable(~ Age_tranche , dw_tot )
# table1
# lprop(table1)
# 


################################################################################
#            IV. MODELISATION    ===============================================
################################################################################
# data_merged

################################################################################
#            LA PCA   ----------------------------------------------------------
################################################################################

if(faire_PCA){
  resultats_acp  <- PCA(data_merged, scale.unit = TRUE, ncp = 5, ind.sup = liste_indices_sup,
                        quanti.sup=NULL, quali.sup=NULL, graph=FALSE)
  
  get_eigenvalue(resultats_acp)
  fviz_eig(resultats_acp, addlabels = TRUE)
  
  
  fviz_pca_var(resultats_acp,  choix = "var")
}

################################################################################
#            L'ACM   -----------------------------------------------------------
################################################################################
if(kmeans_sur_proj){
  data_merged_non_encoded
  data_merged_non_encoded[, eval(liste_cols_to_delete) :=NULL] 
  data_merged_non_encoded[is.na(data_merged_non_encoded)] <- 9999
  data_merged_non_encoded
  
  data_merged_non_encoded <- as.data.frame(data_merged_non_encoded)
  for (i in 1:ncol(data_merged_non_encoded)){
    data_merged_non_encoded[,i] <- as.factor(data_merged_non_encoded[,i])
  }
  
  acm_results <- dudi.acm(data_merged_non_encoded, nf = nb_axes_ACM, scannf = FALSE)

  inertia.dudi(acm_results)

  
  # A EXECUTER POUR AVOIR DES GRAPHES SUR L'ACM 
  # fviz_screeplot(acm_results)
  # summary(acm_results)
  # inertia.dudi(acm_results)
  # 
  # s.corcircle(acm_results$co, 1, 2, clabel = 0.7)
  # 
  # fviz_mca_var(acm_results, repel = TRUE) #==> Plus visuel je trouve
  # 
  # numero_axe <- 1
  # fviz_contrib(acm_results, choice = "var", axes = numero_axe)
  # 
  # On récupère la projection si on veut essayer les kmeans dessus
  data_projected <- acm_results$li
}

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

if(faire_traces){
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
}

if(faire_choix_k_opti){
  ####################### VERIFICATION DU NB DE CLUSTERS OPTI ####################### 
  
  # Elbow method
  fviz_nbclust(sample_scaled, Kmeans, method = "wss") +
    labs(subtitle = "Elbow method")
  # For each value of K, we are calculating WCSS (Within-Cluster Sum of Square). 
  # Kopti = le point d'inflexion ==> Moyen visible ici je trouve (table entière) 
  # Kopti = Idem (projection ACM)
  
  # Silhouette method
  fviz_nbclust(sample_scaled, Kmeans, method = "silhouette")+
    labs(subtitle = "Silhouette method")
  # In short, the average silhouette approach measures the quality of a clustering. That is, it determines how well each object lies within its cluster. A high average silhouette width indicates a good clustering. The average silhouette method computes the average silhouette of observations for different values of k. The optimal number of clusters k is the one that maximizes the average silhouette over a range of possible values for k.
  # Valeur : 0,10 au maximum (2 ou 4 clusters, éventuellement 6) après ACM
  # valeur : 0,10 au max (4 clusters, éventuellement 3 ou 7) sans ACM
  
  ## Que les variables de Charlotte :
  # Donne Kopti = 6 (table entière)
  # Kopti = 2 (projection ACM)
  ## En ajoutant les variables de Laurie : 
  # Donne Kopti = 4 ou 8 (table entière)? Eventuellement 2
  # Kopti = 2 (projection ACM)
  
  
  # Gap statistic ==> Plus long à tourner attention
  # nboot = 50 to keep the function speedy. 
  # recommended value: nboot= 500 for your analysis.
  # Use verbose = FALSE to hide computing progression.
  set.seed(123)
  fviz_nbclust(sample_scaled, Kmeans, nstart = 25,  method = "gap_stat", nboot = 25)+
    labs(subtitle = "Gap statistic method")
  # The gap statistic compares the total intracluster variation for different values of k with their expected values under null reference distribution of the data (i.e. a distribution with no obvious clustering)
  # Valeur : 0,35 au maximum (5 clusters) après ACM
  # Valeur : 0,4 au maximum (6 clusters) après ACM
  
  
  
  ## Que les variables de Charlotte :
  # Donne Kopti = 6 (table entière)
  # Kopti = 6 (projection ACM)
  ## En ajoutant les variables de Laurie : 
  # Donne Kopti = 4 (table entière), ou de plus en plus...
  # Kopti = 5, 6 ou 7 (projection ACM)
}

####################### Une fois qu'on a trouvé le nb de clusters ####################### 

# Sur le sample_scaled
# sample_scaled
resKM_sample_scaled <- Kmeans(sample_scaled, centers=nb_clusters, nstart=30, method = methode)
resKM_sample_scaled
fviz_cluster(resKM_sample_scaled, sample_scaled,  ellipse.type = "norm", geom = "point",
             palette = "jco",
             main = "",
             ggtheme = theme_minimal())


# summary(resKM_sample_scaled)
# plot(sample_scaled, col = resKM_sample_scaled$cluster,pch=16,cex=1.2,main="Regroupement par les k-means")


resKM <- Kmeans(data_kmeans_scale, centers=nb_clusters, nstart=25, method = methode)

if(faire_traces){
  # Sur toute la table
  p <- fviz_cluster(resKM, data_kmeans_scale,
                    ellipse.type = "norm", geom = "point",
                    palette = "jco",
                    main = "",
                    ggtheme = theme_minimal())
  nom_graphe <- paste("01_graphe_", methode,"_",nb_clusters, "_clusters","_kmeans_sur_proj_",kmeans_sur_proj, ".pdf", sep = "")
  ggsave(paste(repo_sorties, nom_graphe, sep = "/"), p ,  width = 297, height = 210, units = "mm")
  
  # 
  # data_kmeans_scale_acp <- as.data.frame(data_kmeans_scale)
  # for (i in 1:ncol(data_kmeans_scale_acp)){
  #   data_kmeans_scale_acp[,i] <- as.factor(data_kmeans_scale_acp)
  # }
  # 
  # acm_results <- dudi.acm(data_kmeans_scale_acp, nf = 3, scannf = FALSE)
  # data_projected <- acm_results$li
  # data_projected$cluster <- resKM_sample_scaled$cluster
  # inertie <- as.data.frame(inertia.dudi(acm_results)[1])
  # inertie_1 <- round(100*inertie$tot.inertia.inertia[1],2)
  # inertie_2 <- round(100*inertie$tot.inertia.inertia[2],2)
  # inertie_3 <- round(100*inertie$tot.inertia.inertia[3],2)
  # 
  # xlab <- paste("Axe 1 (",inertie_1, "%)", sep = "")
  # ylab <- paste("Axe 2 (",inertie_2, "%)", sep = "")
  # zlab <- paste("Axe 3 (",inertie_3, "%)", sep = "")
  # 
  # plot3d(x = data_projected$Axis1,
  #        y = data_projected$Axis2,
  #        z = data_projected$Axis3,
  #        xlab = xlab,
  #        ylab = ylab,
  #        zlab = zlab,                                   
  #        main = "Representation du clustering suivant les 3 principales dimensions",  
  #        col = data_projected$cluster,
  #        type = "s",
  #        size = 1,
  #        box = FALSE)
  # 
  
}

################################################################################
########## ANALYSE DU CLUSTERING ###############################################
################################################################################
source(paste(repo_prgm , "08_analyse_modelisation.R" , sep = "/"))


# df_analyse_cluster_sample_scaled <- fonction_calcul_scoring_kmeans(sample_scaled, resKM_sample_scaled)
df_analyse_cluster <- fonction_calcul_scoring_kmeans(data_kmeans_scale, resKM)

# df_analyse_cluster_sample_scaled
# df_analyse_cluster
# summary(df_analyse_cluster)
titre <- paste("Analyse_cluster_score_", methode,"_",nb_clusters, "_clusters","_kmeans_sur_proj_",kmeans_sur_proj, ".xlsx", sep = "")
write.xlsx(df_analyse_cluster, paste(repo_sorties,titre, sep = "/"))


# 100*resKM_sample_scaled$size/nrow(sample_scaled) ## La taille des clusters en % de l'effectif (sample_scaled)
100*resKM$size/nrow(data_kmeans_scale) ## La taille des clusters en % de l'effectif


################################################################################
#### Distribution par cluster ===> Pour faire des profils-types de femmes !!! ##
################################################################################
data_merged_copy <- copy(data_merged)

# On ajoute la prédiction du numéro de cluster
data_merged_copy$clustering <- resKM$cluster
# sample$clustering <- resKM_sample_scaled$cluster




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


###################### TESTE DU CHI 2

sum_clustering <- data_merged_copy[, lapply(.SD,sum) ,by=clustering]
sum_clustering <- rescale(sum_clustering)
sum_clustering <- as.data.table(sum_clustering)
sum_clustering <- round(sum_clustering)

# sum_clustering <- round(data_merged_copy[, lapply(.SD,sum) ,by=clustering])
sum_clustering <- remove_constant(sum_clustering, na.rm = FALSE, quiet = FALSE)
sum_clustering <- as.data.frame(sum_clustering)
for (i in 1:ncol(sum_clustering)){
  sum_clustering[,i] <- as.integer(sum_clustering[,i])
}

sum_clustering <- sum_clustering[,-1]
sum_clustering <- as.matrix(sum_clustering)
sum_clustering = rbind(sum_clustering)
sum_clustering

khi_test = chisq.test(sum_clustering)
khi_test

# Hypothèse nulle (H0) : il n'y a pas de différence significative dans la répartition des 4 groupes étudiés
# Hypothèse 1 (H1) : au moins 1 des 4 groupe qui ne suit pas la même distribution



 
# ## Pour tout regarder
# # Option 1 : 
# describeBy(data_merged_copy, group="clustering")
# 
# # Option 2 : 
# data_merged_copy %>% 
#   split(.$clustering) %>% 
#   map(summary)
# 
# 
############### ESSAI DE LA DISTANCE GOWER ##################
# 
# 
# data_merged_non_encoded
# 
# data_merged_non_encoded_sample <- as.data.table(sapply(data_merged_non_encoded[], sample, n_sample))
# data_merged_non_encoded_sample <- as.data.frame(data_merged_non_encoded_sample)
# for (i in 1:ncol(data_merged_non_encoded_sample)){
#   data_merged_non_encoded_sample[,i] <- as.factor(data_merged_non_encoded_sample[,i])
# }
# 
# gower_dist <- daisy(data_merged_non_encoded_sample,
#                     metric = "gower")
# 
# summary(gower_dist)
# 
# gower_mat <- as.matrix(gower_dist)
# 
# 
# # Choix nb clusters Kopti
# sil_width <- c(NA)
# for(i in 2:10){
#   pam_fit <- pam(gower_dist,
#                  diss = TRUE,
#                  k = i)
#   sil_width[i] <- pam_fit$silinfo$avg.width
#   
# }
# 
# # Plot sihouette width (higher is better)
# plot(1:10, sil_width,
#      xlab = "Number of clusters",
#      ylab = "Silhouette Width")
# lines(1:10, sil_width)
# 
# nb_clusters <- 4
# 
# pam_fit <- pam(gower_dist, diss = TRUE, k = nb_clusters)
# 
# pam_fit$clustering

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
