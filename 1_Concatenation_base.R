library(readr)
library(data.table)
library(ggplot2)
# install.packages('viridis')
library(viridis)


############## PARTIE 0 : POUR COMPRENDRE L'OBJET #######################


set.seed(42)
big <- data.table( 
  id = LETTERS[2:11],
  a = sample(101:105, 10, replace = TRUE),
  b = sample(200:300, 10)
)
small <- data.table(
  id = LETTERS[1:5],
  y = sample(1:5, 5, replace = TRUE),
  z = sample(10:20, 5) 
)
small
big


id_small <- small[, id]
# big[is.element(id, id_small),]

big[! id %in% id_small, ]




######## PARTIE 1 : Uniquement surles bases Françaises 1998 et 1999 ###########


liste_annees <- 1998:2018

liste_pathes <- paste("C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Repo_codes/Data/YearlyFiles_1998_2018/FR", liste_annees, sep = "")
liste_pathes_2 <- paste(liste_pathes, "y.csv", sep = "_")


data_1998 <- read_csv(liste_pathes_2[1], 
                      locale = locale(encoding ="UTF-8"),
                      show_col_types = FALSE
)
data_1998 <- as.data.table(data_1998)


path <- liste_pathes_2[2]
data_1999 <- read_csv(path, 
                      locale = locale(encoding ="UTF-8"),
                      show_col_types = FALSE
)
data_1999 <- as.data.table(data_1999)

QHHNUM_list_prev <- data_1998[, QHHNUM]
# HHSEQNUM_list_prev <- data_1998[, HHSEQNUM] # ===> En fait on ne va pas l'utiliser ici je pense

# Que en 1998 : Q1001191
# Que en 1999 : Q1078296
# Dans les deux : Q1003024

data_1998[QHHNUM == 'Q1078296',]
data_1999[QHHNUM == 'Q1078296',]

data_1999_filtered <- data_1999[! QHHNUM %in% QHHNUM_list_prev, ]
### Si on rajoute la condition [! HHSEQNUM %in% HHSEQNUM_list_prev,] alors on va virer tout le monde : HHSEQNUM = 01, 02, 03 ... 

# On se rassure : 
data_1999_filtered[QHHNUM == 'Q1001191',]
data_1999_filtered[QHHNUM == 'Q1078296',]
data_1999_filtered[QHHNUM == 'Q1003024',]




######## PARTIE 2 : Boucle sur le France entre 1998 et 2018. Uniquement



liste_annees <- 1998:2018
liste_pathes <- paste("C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Repo_codes/Data/YearlyFiles_1998_2018/FR", liste_annees, sep = "")
liste_pathes_2 <- paste(liste_pathes, "y.csv", sep = "_")


# Première importation

data_merged <- read_csv(liste_pathes_2[1], 
                        locale = locale(encoding ="UTF-8"),
                        show_col_types = FALSE
)
data_merged <- as.data.table(data_merged)

# Liste des ménages précédents
QHHNUM_list_prev <- data_merged[, QHHNUM]

liste_longeurs <- list(nrow(data_merged))

# Boucle
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
  
  
  # Filtration
  data_loc_filtered <- data_loc[! QHHNUM %in% QHHNUM_list_prev, ]
  
  # Concaténation
 
  data_merged <- rbindlist(list(data_merged,
                                data_loc_filtered))
  
  
  # Liste des ménages précédents, pour la boucle d'après
  QHHNUM_list_prev <- data_loc[, QHHNUM]
  
  liste_longeurs <- append(liste_longeurs,nrow(data_merged))
   
}



liste_longeurs_list <- copy(liste_longeurs)


####### ON RECOMMENCE EN GARDANT EN MEMOIRE LE QHHNUM_list_prev


data_merged <- read_csv(liste_pathes_2[1], 
                        locale = locale(encoding ="UTF-8"),
                        show_col_types = FALSE
)
data_merged <- as.data.table(data_merged)

# Liste des ménages précédents
QHHNUM_list_prev <- data_merged[, QHHNUM]

liste_longeurs <- list(nrow(data_merged))

# Boucle
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
  
  
  # Filtration
  data_loc_filtered <- data_loc[! QHHNUM %in% QHHNUM_list_prev, ]
  
  # Concaténation
  
  data_merged <- rbindlist(list(data_merged,
                                data_loc_filtered))
  
  
  # Liste des ménages précédents, pour la boucle d'après
  QHHNUM_list_prev <- data_merged[, QHHNUM]
  
  liste_longeurs <- append(liste_longeurs,nrow(data_merged))
  }
  
liste_longeurs_list_2 <- copy(liste_longeurs)

  
  
########## PLOTS des longueurs des data.table obtenus ###############


df_plot <- list(annee = liste_annees,
                population_1 = liste_longeurs_list, 
                population_2 = liste_longeurs_list_2)

df_plot <- as.data.table(df_plot)
df_plot <- df_plot[ , population_1 := as.numeric(population_1)]
df_plot <- df_plot[ , population_2 := as.numeric(population_2)]
df_plot <- df_plot[ , annee := as.character(annee)]



ggplot(data = df_plot) + 
  geom_bar(aes(x = annee, y = population_1), stat="identity") + 
  labs(title="Longueur de la table après jointure jusqu'à l'année x",
       x="Année",
       y="Population",
       caption = "Version 1 : On ne garde en mémoire que les identifiants de l'année d'avant") + 
  scale_y_continuous(labels = function(y) format(y, scientific = FALSE)) +
  coord_flip()
  



ggplot(data = df_plot) + 
  geom_bar(aes(x = annee, y = population_2), stat="identity") + 
  labs(title="Longueur de la table après jointure jusqu'à l'année x",
       x="Année",
       y="Population",
       caption = "Version 2 : On garde en mémoire rous les identifiants précédents") + 
  scale_y_continuous(labels = function(y) format(y, scientific = FALSE)) +
  coord_flip()




df_plot_melted <- melt(data = df_plot, 
                       id.vars = 'annee', 
                       measure.vars = c('population_1', 'population_2'),
                       variable.name = 'Méthode',
                       value.name = "population")

df_plot_melted[, Méthode := factor(
  fcase(
    Méthode == 'population_1', "Méthode 1 (uniquement les identifiants de l'année passée)",
    Méthode == 'population_2', "Méthode 2 (les identifiants de toutes les années)"
  )
)
]


ggplot(data = df_plot_melted) + 
  geom_bar(aes(x = annee, y = population, fill = Méthode), stat="identity", position=position_dodge()) + 
  labs(title="Longueur de la table après jointure jusqu'à l'année x",
       x="Année",
       y="Population") +
  scale_y_continuous(labels = function(y) format(y, scientific = FALSE)) +
  coord_flip() +
  scale_fill_viridis(, discrete = TRUE) +
  theme(legend.position="bottom")





