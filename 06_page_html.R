######################################################
#                 CONSTRUCTION HTML                    #
######################################################


# Ce programme permet de construire une page HTML

# Création d une fonction


genere_html <- function(rep , mardown , nom_html){
  
  output_dir <- rep
  
  rmarkdown::render(
    mardown,
    output_format = c("html_document") ,
    output_dir = output_dir,
    params = c(output_dir = output_dir),
    output_file = nom_html,
    envir = parent.frame()
  )
  
  
}

# Sortie de la page


setwd(dir = repo_prgm )

genere_html( rep_html , 
             "visualisation.Rmd",
             paste(nom_fichier_html,"html" , sep ="."))

