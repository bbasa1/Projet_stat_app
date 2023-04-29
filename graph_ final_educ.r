library(readxl)
#install.packages("ggplot2")
library(ggplot2)
graphique_statapp <- read_excel("/Users/charlottecombier/Desktop/graphique_statapp.xlsx") |>
  rename(educ = "...1") |>
  pivot_longer(cols=c(-1), names_to = "Pays", values_to = "value")
  
View(graphique_statapp)


plot_nams <-ggplot(data = graphique_statapp,
                                    aes(x =forcats::fct_relevel(Pays),
                                        y = value, fill = forcats::fct_relevel(educ, c("Niveau d'éducation élevé", "Niveau d'éducation moyen", "Niveau d'éducation faible"), after = 1))) +
  geom_col(position = "dodge") + 
  labs(title = "Taux d'emploi des femmes en fonction du niveau d'éducation", 
       subtitle = "Lecture : En 2018, les femmes allemandes avec un niveau d'éducation élevé ont un taux d'emploi de 87 %.", 
       y = "Taux d'emploi (en %)", x = "Pays") +
  #scale_color_manual(name = "Composante", values=c("red","grey50","grey50","grey50","grey50","grey50")) +
  theme_grey()+
  theme(legend.position="bottom",
        axis.text.x = element_text(angle = 90),
        legend.title = element_text(size=9), 
        legend.text = element_text(size=7),
        plot.title = element_text(color = "#333333", size = 18, face = "bold"),
        plot.subtitle = element_text(color = "#333333", face = "italic")) +
  scale_fill_discrete(name=NULL)
plot_nams    