cocinando <- function(AC, cooksd, PESO_SP, PUERTO2, ESPECIE, ESTRATO_RIM, sp3, MN, FECHA) {

     colp <- c("A CORUNA" = "steelblue", "SANTA EUGENIA DE RIBEIRA" = "blue", "CILLERO"="darkgreen",
            "VIGO" = "orange", "AVILES-GIJON" = "darkblue","AVILES"="red", "GIJON"="#00BFC4",
            "SANTONA" = "#7CAE00", "CEDEIRA"="forestgreen", "FINISTERRE"= "darkgoldenrod2",
            "LUARCA" = "chartreuse4", "MUROS"= "#619CFF", "CELEIRO"="darkgreen", 
            "BURELA" ="yellowgreen","SUANCES"="deeppink3",
            "MARIN"= "mediumorchid", "SAN VICENTE DE LA BARQUERA"= "tomato",
            "ISLA CRISTINA" ="steelblue", "LLANES"= "darksalmon",
            "PUNTA UMBRIA" = "slateblue3", "BARBATE"= "red3","SANTANDER"= "red",
            "PUERTO DE SANTA MARIA"="darkorchid2","ROTA"="orange","A BORDO" = "black",
            "CADIZ"="Chartreuse2", "TARIFA"= "coral1", "AYAMONTE"= "coral3",
            "SANLUCAR DE BARRAMEDA"= "darksalmon","PUNTA DEL MORAL"= "red",
            "CASTLETOWN BERE" = "deeppink3", "PUERTO DE LA VEGA"="black", "MUXIA"="tomato2")    
         
         
         temp_plot  <-ggplot(data =AC,
         mapping = aes(y = cooksd, x=TALLA_MEDIA_MAREA, col=factor(PUERTO2)))  +
     #geom_point(aes(color = factor(PUERTO2)), position = "jitter",size=3) +  
     
     
     
    geom_quasirandom(aes(colour = PUERTO2, size=PESO_SP,x=TALLA_MEDIA_MAREA, y=cooksd  ),
                    method = "smiley")  +
    
    geom_hline(data = AC, aes(yintercept = 4*AC$MN),size=1.5, colour="red")  +
    guides(colour = guide_legend(override.aes = list(size = 3)))     +
    guides(scale= "none",size=FALSE,fill=guide_legend(override.aes=list(size=3))) +
    scale_size(range=c(4,10))  +
    facet_wrap(ESPECIE~ESTRATO_RIM, scales="free")   +
 
    labs(title=AC$ESPECIE,subtitle="Influential Obs by Cooks distance (cooksd>4*mean)",
         caption = "AÑO= 2023") +
    
    theme_minimal()    +  #theme(legend.position = "none") +
    theme(strip.text.x = element_text(size=12, angle=0,face="bold", colour="white"),
          strip.text.y = element_text(size=12, face="bold",colour="white"),
          strip.background = element_rect(colour="white", fill=c( "steelblue")))  +


     
    theme(plot.title = element_text(hjust=0.5,lineheight=7, face="bold", size=16),
          plot.subtitle = element_text(hjust=0.5,lineheight=10, face="bold.italic", 
                                       size = 14)) +
    scale_colour_manual(values=colp,limits = force)   +
    theme(legend.text = element_text(colour="steelblue", size = 10, face = "bold"))+
    theme( legend.title = element_text(colour="blue", size=10, face="bold"))+
    theme(axis.text=element_text(angle=0, size=12, face="bold")) +
    
    geom_blank(aes(x = 0.99*t_min)) + 
    geom_blank(aes(x = 1.05*t_max)) +
    geom_blank(aes(y = 0.99*MAX)) +
    
    
    
geom_label_repel(show.legend=FALSE,data=subset(AC,  EJEM_MED_MAREA>5 ),
aes(fontface="bold",  TALLA_MEDIA_MAREA,cooksd, 
label = ifelse(cooksd>4*MN,paste(round(TALLA_MEDIA_MAREA,2), "cm", "\n",
FECHA, " ", "\n",EJEM_MED_MAREA, "Ejemplares"),"") , vjust=0, hjust=0.5)) 
    # scale_x_sqrt()
  
ggsave(temp_plot, file=paste0("2023_plot_TALLAS_MEDIAS ",unique(AC$ESPECIE)," ", ".png"),
       width = 35, height =25, units = "cm")

temp_plot
     
}
