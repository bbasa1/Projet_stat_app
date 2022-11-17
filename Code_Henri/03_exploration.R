######################################################
#     IMPORT DES DONNEES      #
######################################################

sort(colnames(lfs_fr_1998))

sort(colnames(lfs_fr_2018))

lfs_fr_1998_traite <- lfs_fr_1998 %>% 
  dplyr::select(HHNUM,COEFF,COUNTRY,SEX,YEAR,AGE,YSTARTWK,
                ILOSTAT,WSTATOR,WANTWORK,WISHMORE,AVAILBLE,SEEKWORK,SEEKREAS,DEGURBA,STAPRO,FTPT,
                ISCO3D,TEMP,TEMPDUR,FTPTREAS,HWWISH,HWUSUAL,HWACTUAL,HWACTUA2,INCDECIL,
                NEEDCARE,HATLEV1D,HATFIELD,
                HHNBCH2,HHNBCH5,HHNBCH8,HHNBCH11,HHNBCH14)


#   Age en tranches  #

table(lfs_fr_1998_traite$AGE)

#   Pondération en millions  #

sum(lfs_fr_1998_traite$COEFF)


table(lfs_fr_1998_traite$INCDECIL)