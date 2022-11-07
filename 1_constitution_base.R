library(readr)
library(data.table)


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




# Etape 1 : Ouvrir les données

# path <- "C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Repo_codes/Data/YearlyFiles_1998_2018"
# 
# 
# # data <- read.table(unz(paste(path,"FR_YEAR_1998_onwards.zip"), "FR2018_y.csv"), nrows=10, header=T, quote="\"", sep=",")
# 
# data <- readr::read_csv(file = unzip(paste(path, 'FR_YEAR_1998_onwards.zip', sep="/"), "FR2018_y.csv"),
#                         show_col_types = FALSE)
# 




# path <- "C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Repo_codes/Data/YearlyFiles_1998_2018/FR2015_y.csv"
# 
# 
# data_fr <- read_csv(path, 
#                     locale = locale(encoding ="UTF-8"),
#                     # col_types = cols(com = col_character(),
#                     #                  reg = col_integer()),
#                     show_col_types = FALSE
# )
# 
# data_fr


liste_annees <- 1998:2018

liste_pathes <- paste("C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Repo_codes/Data/YearlyFiles_1998_2018/FR", liste_annees, sep = "")
liste_pathes_2 <- paste(liste_pathes, "y.csv", sep = "_")


data_concat <- read_csv(liste_pathes_2[1], 
                        locale = locale(encoding ="UTF-8"),
                        show_col_types = FALSE
)
data_concat <- as.data.table(data_concat)


path <- liste_pathes_2[2]
data_loc <- read_csv(path, 
                     locale = locale(encoding ="UTF-8"),
                     show_col_types = FALSE
)
data_loc <- as.data.table(data_loc)


suffixe_ajoute <- paste("_", as.character(1998 + 2), sep = "")



data_concat2 <- merge(data_concat, data_loc,
                      all.x = FALSE, 
                      all.y = FALSE, 
                      by = c('QHHNUM', 'HHSEQNUM'), 
                      allow.cartesian=TRUE, 
                      suffixes = c("", suffixe_ajoute))

data_concat2


df_loc <- data_loc[QHHNUM == 'Q1003100']
df_loc

###########################################
# 
# 
# for (path in liste_pathes_2[c(-1)]){
#   data_loc <- read_csv(path, 
#                        locale = locale(encoding ="UTF-8"),
#                        show_col_types = FALSE
#   )
#   data_loc <- as.data.table(data_loc)
#   
#   
#   data_concat <- merge(data_concat, data_loc, all = TRUE, by = 'QHHNUM')
#   
#   # data_concat <- rbindlist(list(data_concat, data_loc))    
# }
# 
# 
# data_concat_dt <- as.data.table(data_concat)


###########################################

# 
# for (year in c(2010,2011,2012,2013,2014,2015)){
#   print(paste("The year is", year))
# }
# 
# 
# data_fr <- read_csv(liste_pathes_2[1], 
#                      locale = locale(encoding ="UTF-8"),
#                     show_col_types = FALSE
#                      )
# data_fr_dt <- as.data.table(data_fr)
# 
# data_fr2 <- read_csv(liste_pathes_2[2], 
#                      locale = locale(encoding ="UTF-8"),
#                     show_col_types = FALSE
#                      )
# data_fr_dt2 <- as.data.table(data_fr2)
# 
# 
# 
# data_concat <- rbindlist(list(data_fr_dt, data_fr_dt2))    
# data_concat                                  

