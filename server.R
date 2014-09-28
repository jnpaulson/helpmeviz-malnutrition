library(shiny)
library(ggplot2)
library(ggvis)

df_complete = read.csv("./Stunting_clean.csv")
regions_complete = df_complete[,2]
rownames(df_complete) = df_complete[,1]
df_complete = df_complete[,-c(1:2)]

all_values <- function(x) {
 if(is.null(x)) return(NULL)
 paste0(names(x)[1:2], ": ", format(x)[1:2], collapse = "<br />")
}

shinyServer(function(input, output) {

  df <- reactive({
    data.frame(x=df_complete[,input$xaxis],y=df_complete[,"mean_stunting"],
      country=rownames(df_complete))
    })

  base <- df %>% ggvis(x=~x,y=~y) %>%
  layer_points(fill.update= ~factor(regions_complete)) %>% 
  layer_smooths(
    span = 1
    ) %>% 
  layer_text(text.hover:=~country,text.update:=~country) %>%
  add_axis("y", title = "Average stunting")

  base %>% add_tooltip(all_values,"hover") %>%
  bind_shiny("ggvis", "ggvis_ui")

  # box <- reactive(
  #   as.numeric(df_complete[,input$boxplot])
  #   )
  # yaxis <- reactive(
  #   as.numeric(df_complete[,input$yaxis])
  #   )
  # size <- reactive(
  #   # scaleFunction(as.numeric(df_complete[,input$size]))
  #   )
  
# output$boxp<-renderPlot({
  # qplot(x=xaxis(),y=yaxis(),size=size(),xlab=input$xaxis,ylab=input$yaxis) + scale_size_continuous() + geom_smooth()
  # boxplot(box()~factor(regions_complete))
  # })

output$text<-renderText({
  "Data aggregated from the World Bank Development Indicators from 1990-2013. 
  Github repo for data aggregation located here:
  Github repo for the shiny visualization located here:
  "
  })

 })