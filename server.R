library(shiny)
library(ggplot2)
library(ggvis)

load("data.rdata")
all_values <- function(x) {
 if(is.null(x)) return(NULL)
 paste0(names(x)[1:2], ": ", format(x)[1:2], collapse = "<br />")
}

shinyServer(function(input, output) {

  df <- reactive({
    data.frame(x=df_complete[,input$xaxis],y=df_complete[,input$yaxis],
      country=rownames(df_complete))
    })
  size <- reactive({
    df_complete[,input$choice]
    })

  base <- df %>% ggvis(x=~x,y=~y) %>%
  layer_points(size:=size,fill.update= ~factor(regions_complete)) %>% 
  layer_smooths(
    span = input_slider(0.2, 1, value = 1, step = 0.05, label = "span")
    ) %>% 
  layer_text(text.hover:=~country,text.update:=~country)

  base %>% add_tooltip(all_values,"hover") %>%
  bind_shiny("ggvis", "ggvis_ui")

  box <- reactive(
    as.numeric(df_complete[,input$boxplot])
    )
  # yaxis <- reactive(
  #   as.numeric(df_complete[,input$yaxis])
  #   )
  # size <- reactive(
  #   # scaleFunction(as.numeric(df_complete[,input$size]))
  #   )
  
output$boxp<-renderPlot({
  # qplot(x=xaxis(),y=yaxis(),size=size(),xlab=input$xaxis,ylab=input$yaxis) + scale_size_continuous() + geom_smooth()
  boxplot(box()~factor(regions_complete))
  })

 })