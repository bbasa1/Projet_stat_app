library(readr)
library(data.table)


############## PARTIE 0 : POUR COMPRENDRE LE MERGE DE DATA.TABLE #######################
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

a <- 2



### Inner join, par deux méthodes
small[big, on = .(id), nomatch = NULL]

result <- merge(small, big,
                all.x = FALSE, 
                all.y = FALSE, 
                by = 'id', 
                allow.cartesian=TRUE)
result
inner <- 4

# Ouf les deux méthodes donnent bien la MEME chose !

### Outer join

result <- merge(small, big,
                all.x = TRUE, 
                all.y = TRUE, 
                by = 'id', 
                allow.cartesian=TRUE)

result[is.na(y) | is.na(a)]
outer <- 7
# Ouf ça semble bien fonctionner !

2*inner + outer
nrow(small) + nrow(big)





######## PARTIE 1 : Importation et deux types de merge : inner ou full-outer des bases Françaises 1998 et 1999 ###########
# Pour $merge$ deux bases sur deux années consécutives en France
# 
# ## Explications :
# - Il faut joindre sur deux variables :
#   - 'QHHNUM'= L'identifiant du ménage
#   - 'HHSEQNUM'= L'identifiant au sein du ménage
# 
# 
# ## Attention sur l'importation :
# 
# - Quarterly datasets containing only the quarterly variables.
# - Yearly datasets containing all variables of the core LFS survey, the quarterly and the structural ones.
# 



# Importation
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


suffixe_ajoute <- paste("_", as.character(1998 + 1), sep = "")


# Deux types de jointures
faire_outer_join <- TRUE

if(faire_outer_join == FALSE){
  data_merged <- merge(data_1998, data_1999,
                        all.x = FALSE, 
                        all.y = FALSE, 
                        by = c('QHHNUM', 'HHSEQNUM'), 
                        allow.cartesian=TRUE, 
                        suffixes = c("", suffixe_ajoute))
}else{
  data_merged <- merge(data_1998, data_1999,
                        all.x = TRUE, 
                        all.y = TRUE, 
                        by = c('QHHNUM', 'HHSEQNUM'), 
                        allow.cartesian=TRUE, 
                        suffixes = c("", suffixe_ajoute))
  data_merged <- data_merged[is.na(SEX_1999) | is.na(SEX)]
  
}

# Quelques vérifs

data_merged

nrow(data_merged)

View(data_merged[QHHNUM == "Q1003025"])
View(data_merged[QHHNUM == "Q1001192"])

inner <- 113648
outer<- 137931

2*inner + outer
nrow(data_1998) + nrow(data_1999)


######## PARTIE 2 : Boucle sur le France entre 1998 et 2018. Uniquement

liste_annees <- 1998:2018
liste_pathes <- paste("C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Repo_codes/Data/YearlyFiles_1998_2018/FR", liste_annees, sep = "")
liste_pathes_2 <- paste(liste_pathes, "y.csv", sep = "_")

faire_outer_join <- TRUE


# Première importation

data_merged <- read_csv(liste_pathes_2[1], 
                      locale = locale(encoding ="UTF-8"),
                      show_col_types = FALSE
)
data_merged <- as.data.table(data_merged)


# Boucle
for (indice in seq_along(liste_pathes_2)[c(-1)]){
  path <- liste_pathes_2[indice]
  annee <- liste_annees[indice]
  
  print(paste("Année =", annee, "| path = ", path, sep = " "))
  data_loc <- read_csv(path,
                       locale = locale(encoding ="UTF-8"),
                       show_col_types = FALSE
  )
  data_loc <- as.data.table(data_loc)


  suffixe_ajoute <- paste("_", as.character(1998 + indice -1), sep = "")
  
  
  # Deux types de jointures
  if(faire_outer_join == FALSE){
    data_merged <- merge(copy(data_merged), data_loc,
                         all.x = FALSE, 
                         all.y = FALSE, 
                         by = c('QHHNUM', 'HHSEQNUM'), 
                         allow.cartesian=TRUE, 
                         suffixes = c("", suffixe_ajoute))
  }else{
    data_merged <- merge(copy(data_merged), data_loc,
                         all.x = TRUE, 
                         all.y = TRUE, 
                         by = c('QHHNUM', 'HHSEQNUM'), 
                         allow.cartesian=TRUE, 
                         suffixes = c("", suffixe_ajoute))
    nom_col <- paste0("SEX_", as.character(1998 + indice - 1), sep = "")
    # colnames(nom_col)
    data_merged <- data_merged[ is.na(data_merged[[nom_col]]) | is.na(SEX)]
    
  }
  
}

