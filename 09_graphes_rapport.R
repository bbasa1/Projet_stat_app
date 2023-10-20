titre <- "tableau_tx_acti_emp_pour_Sexe_1H_2F_Pays_Annee_enquete-Copie.xlsx"
df_stat <- read.xlsx(paste(repo_sorties,titre, sep = "/"), 1)
df_stat <- as.data.table(df_stat)
df_stat
df_stat[,tx_activite_round := round(tx_activite,1)]
df_stat[,tx_emploi_round := round(tx_emploi ,1)]
df_stat[,tx_emploi_etp_round := round(tx_emploi_etp ,1)]


setnames(df_stat, "tx_activite", "Taux d'activité")
setnames(df_stat, "tx_emploi_etp", "Taux d'emploi (EQTP)")
setnames(df_stat, "tx_emploi", "Taux d'emploi")
setnames(df_stat, "Pays_label", "Pays")

df_melted <- melt(df_stat, id.vars = c("Sexe", "Annee_enquete", "Pays"))
df_melted

ggplot(data = df_melted[variable == "Taux d'emploi (EQTP)"], aes(x = Annee_enquete, y = value, color = Pays, shape = Sexe, group = interaction(Pays, Sexe))) +
  geom_point(size=2) +
  geom_line() +
  labs(x= "Année d'enquête",
       y= "Taux d'emploi EQTP (%)") + 
  scale_y_continuous(limits = c(35, 100), labels = function(y) format(y, scientific = FALSE)) + 
  scale_fill_discrete() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))


a <- 1











df_stat[,tx_activite :=NULL]
df_stat[,tx_emploi :=NULL]
df_stat[,tx_emploi_etp :=NULL]
df_stat

casted <- dcast(df_stat,
      Annee_enquete ~ Sexe + Pays_label,
      value.var = c("tx_emploi_round"))

casted
titre <- paste("tx_emploi_round", ".xlsx", sep = "")
write.xlsx(casted, paste(repo_sorties,titre, sep = "/"))

