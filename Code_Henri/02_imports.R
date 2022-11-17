######################################################
#     IMPORT DES DONNEES      #
######################################################

lfs_fr_1998 <- rio::import(paste(rep_data , "lfs_1998_2018" , "FR_YEAR_1998_onwards" , "FR1998_y.csv" , sep ="/"))

lfs_fr_2018 <- rio::import(paste(rep_data , "lfs_1998_2018" , "FR_YEAR_1998_onwards" , "FR2018_y.csv" , sep ="/"))


lfs_fr_2018_q1 <- rio::import(paste(rep_data , "LFS2018" , "FR2018Q1.csv" , sep ="/"))
