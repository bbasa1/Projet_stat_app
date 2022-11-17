######################################################
#     STATISTIQUES APPLIQUEES : CHAPEAU      #
######################################################

# Ce programme est un chapeau pour le mémoire de StatAp


require("stringr")


######################################################
#   I. INITIALISATION =============================  


######################################################
#   A. Définition des chemins  --------------------  




  
chemin <- dirname(rstudioapi::getSourceEditorContext()$path)
  

a <- stringr::str_locate_all(chemin,"Stat_Ap_Ensae")

b <- stringr::str_locate_all(chemin,"programmes")

nom_dossier <- substr(chemin, b[[1]][2]+2 , 200 )

repgen <- substr(chemin, 1 , a[[1]][2] )

rep_progm <- paste(repgen,"programmes",sep="/")

rep_data <- paste(repgen, "LFS" , sep="/")

remove(a,b)


######################################################
#   B. Chargement des packages      --------------------  



source(paste(rep_progm,"01_packages.R",sep="/") , 
       encoding = "UTF-8" )


######################################################
#  II. IMPORT DES DONNEES    ===============



source(paste(rep_progm,"02_imports.R",sep="/") , 
       encoding = "UTF-8" )


######################################################
#  III. EXPLORATION DES DONNEES    ===============


source(paste(rep_progm,"03_exploration.R",sep="/") , 
       encoding = "UTF-8" )