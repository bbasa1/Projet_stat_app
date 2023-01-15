################################################################################
######### LES SORTIES GRAPHIQUES  #####
################################################################################

trace_barplot <- function(data_loc, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save){
  p <- ggplot(data = data_loc, aes(x = reorder(.data[[x]], .data[[sortby_x]]), y = .data[[y]], fill = .data[[fill]])) +
    geom_bar(stat="identity", position=position_dodge()) + 
    labs(title=titre,
         x= xlabel,
         y= ylabel) + 
    scale_y_continuous(limits = c(0, 100), labels = function(y) format(y, scientific = FALSE)) + 
    scale_fill_discrete() +
    scale_color_viridis() +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))
  
  # p
  # ggsave(titre_save, p ,  width = 297, height = 210, units = "mm")
  print(p)
}



trace_barplot_avec_facet <- function(data_loc, x, sortby_x, y, fill, xlabel, ylabel, titre, titre_save, facet, ordre_facet){

  if (length(ordre_facet) > 2){
  p <- ggplot(data = data_loc, aes(x = reorder(.data[[x]], .data[[sortby_x]]), y = .data[[y]], fill = .data[[fill]])) +
    geom_bar(stat="identity", position=position_dodge()) + 
    labs(title=titre,
         x= xlabel,
         y= ylabel) + 
    scale_y_continuous(limits = c(0, 100), labels = function(y) format(y, scientific = FALSE)) + 
    scale_fill_discrete() +
    scale_color_viridis() +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1)) +
    facet_grid(~factor(.data[[facet]], levels = ordre_facet))
  }
  else{
    p <- ggplot(data = data_loc, aes(x = reorder(.data[[x]], .data[[sortby_x]]), y = .data[[y]], fill = .data[[fill]])) +
      geom_bar(stat="identity", position=position_dodge()) + 
      labs(title=titre,
           x= xlabel,
           y= ylabel) + 
      scale_y_continuous(limits = c(0, 100), labels = function(y) format(y, scientific = FALSE)) + 
      scale_fill_discrete() +
      scale_color_viridis() +
      theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1)) +
      facet_wrap(~factor(.data[[facet]]), ncol = 2)
  }
  
  # p
  # ggsave(titre_save, p ,  width = 297, height = 210, units = "mm")
  print(p)
}
