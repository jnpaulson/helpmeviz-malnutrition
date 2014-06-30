library(shiny)
library(ggplot2)
library(ggvis)
dat = read.csv("Stunting3.csv")
rownames(dat) = dat[,1]
dat = dat[,c(1:12,15,18,21,24,26,27)]
colnames(dat) = c("Country","Female parliament % (12)","LaborForceF (11)","LaborForceM (11)",
                  "Maternal.Mortality.Ratio (10)","Adolescent fertility rate","Pop. 2nd Ed Female (06-10)",
                  "Pop. 2nd Ed Male (06-10)","LaborForceF Participation (11)","LaborForceM Participation (11)",
                  "GII (10)","GII (12)","2013 Global Hunger Index","Under-five Mortality rate (%)","Prevalence of undernourishment"
                  ,"Prevalence of underweight in children under five years","MeanStuntingF","MeanStuntingM")

all_values <- function(x) {
 if(is.null(x)) return(NULL)
 paste0(names(x)[1:2], ": ", format(x)[1:2], collapse = "<br />")
}

shinyServer(function(input, output) {
  df <- reactive({
    data.frame(x=dat[,input$xaxis],y=dat[,input$yaxis],
      country=dat[,1],xlab=input$xaxis,ylab=input$yaxis)
    })
  size <- reactive({
    dat[,input$choice]
    })
  xlab <- reactive({
    as.character(input$xaxis)
    })


  base <- df %>% ggvis(x=~x,y=~y) %>%
  layer_points(size := size, fill.update
     := "black", fill.hover := "red") %>% 
  layer_smooths(
    span = input_slider(0.2, 1, value = 1, step = 0.05, label = "span")
    ) %>% 
  layer_text(text.hover:=~country,text.update:=~country)

  base %>% add_tooltip(all_values,"hover") %>%
  bind_shiny("ggvis", "ggvis_ui")

  xaxis <- reactive(
    as.numeric(dat[,input$xaxis])
    )
  yaxis <- reactive(
    as.numeric(dat[,input$yaxis])
    )
  size <- reactive(
    scaleFunction(as.numeric(dat[,input$size]))
    )
  
output$plot<-renderPlot({
  qplot(x=xaxis(),y=yaxis(),size=size(),xlab=input$xaxis,ylab=input$yaxis) + scale_size_continuous() + geom_smooth()
  })
 })