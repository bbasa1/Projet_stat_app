library(readr)
library(data.table)
library(ggplot2)
# install.packages('viridis')
library(viridis)


######## Boucle sur le France entre 1998 et 2018



# liste_annees <- 1998:2018
liste_annees <- 1998:2010
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
  geom_bar(aes(x = annee, y = population), stat="identity") + 
  labs(title="Longueur de la table après concaténation jusqu'à l'année x",
       x="Année",
       y="Population") + 
  scale_y_continuous(labels = function(y) format(y, scientific = FALSE))







############# SELECTION VARIABLES ######################
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






