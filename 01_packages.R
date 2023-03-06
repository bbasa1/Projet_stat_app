################################################################################
########### PROGRAMMES POUR LE CHARGEMENT DES PACKAGES #########################
################################################################################

library(readr)
# install.packages("data.table")
library(data.table)
# install.packages("ggplot2")
library(ggplot2)
# install.packages('viridis')
library(viridis)
library(dplyr)
# install.packages("ggpmisc")
library(ggpmisc)
# install.packages("tibble")
library(magrittr) # needs to be run every time you start R and want to use %>%
# install.packages("broom")
# install.packages("ggpubr")
library(ggpmisc)
library(tibble)
library(dplyr)
library(quantreg)
# install.packages("tidyverse")
library(tidyverse) 
library(broom)
library(ggpubr)
#install.packages("finalfit")
library(finalfit)
# install.packages("FactoMineR")
library(FactoMineR)
# install.packages("factoextra")
library(factoextra)
library(cluster)
# install.packages("compare")
library(compare)
# install.packages("janitor")
library(janitor)
# install.packages("survey")
library(survey)


### Liste des pays possibles (dico sur https://www.iban.com/country-codes )###
dico_pays <- c(
  "FR" ="France",
  "AT" ="Autriche",
  "BE" ="Belgique",
  "BG" ="Bulgarie",
  "CH" ="Suisse",
  "CY" ="Chypre",
  "CZ" ="République Tchèque",
  "DE" ="Allemagne",
  "DK" ="Dannemark",
  "EE" ="Estonie",
  "ES" ="Espagne",
  "FI" ="Finlande",
  "GR" ="Grèce",
  "HR" ="Croatie",
  "HU" ="Hongrie",
  "IE" ="Irlande",
  "IS" ="Islande",
  "IT" ="Italie",
  "LT" ="Lituanie",
  "LU" ="Luxembourg",
  "LV" ="Lettonie",
  "MT" ="Malte",
  "NL" ="Pays-bas",
  "NO" ="Norvège",
  "PL" ="Pologne",
  "PT" ="Portugal",
  "RO" ="Roumanie",
  "SE" ="Suisse",
  "SI" ="Slovénie",
  "SK" ="Slovakie",
  "UK" ="Royaume-Unis"
)