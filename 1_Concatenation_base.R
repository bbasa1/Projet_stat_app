library(readr)
library(data.table)
library(ggplot2)
# install.packages('viridis')
library(viridis)


######## Boucle sur le France entre 1998 et 2018



liste_annees <- 1998:2018
liste_pathes <- paste("C:/Users/Benjamin/Desktop/Ensae/Projet_statapp/Repo_codes/Data/YearlyFiles_1998_2018/FR", liste_annees, sep = "")
liste_pathes_2 <- paste(liste_pathes, "y.csv", sep = "_")


# Première importation

data_merged <- read_csv(liste_pathes_2[1], 
                        locale = locale(encoding ="UTF-8"),
                        show_col_types = FALSE)
data_merged <- as.data.table(data_merged)



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
  
  
  # Concaténation
  data_merged <- rbindlist(list(data_merged,
                                data_loc))
  
  
  liste_longeurs <- append(liste_longeurs,nrow(data_merged))
}



liste_longeurs_list <- copy(liste_longeurs)





########## PLOTS des longueurs des data.table obtenus ###############


df_plot <- list(annee = liste_annees,
                population = liste_longeurs_list)

df_plot <- as.data.table(df_plot)
df_plot <- df_plot[ , population := as.numeric(population)]
df_plot <- df_plot[ , annee := as.character(annee)]



ggplot(data = df_plot) + 
  geom_bar(aes(x = annee, y = population_1), stat="identity") + 
  labs(title="Longueur de la table après concaténation jusqu'à l'année x",
       x="Année",
       y="Population") + 
  scale_y_continuous(labels = function(y) format(y, scientific = FALSE)) +
  coord_flip()






























select(HHNUM,COEFF,COUNTRY,SEX,YEAR,AGE,YSTARTWK,
       ILOSTAT,WSTATOR,WANTWORK,WISHMORE,AVAILBLE,SEEKWORK,SEEKREAS,DEGURBA,STAPRO,FTPT,
       ISCO3D,TEMP,TEMPDUR,FTPTREAS,HWWISH,HWUSUAL,HWACTUAL,HWACTUA2,INCDECIL,
       NEEDCARE,HATLEV1D,HATFIELD,
       HHNBCH2,HHNBCH5,HHNBCH8,HHNBCH11,HHNBCH14)