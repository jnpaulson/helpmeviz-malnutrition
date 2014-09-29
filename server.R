library(shiny)
library(ggplot2)
library(ggvis)

df_complete = read.csv("./Stunting_clean.csv")
Region = factor(df_complete[,2])
names(Region) = df_complete[,1]
rownames(df_complete) = df_complete[,1]
df_complete = df_complete[,-c(1:2)]
df_complete = df_complete[,(c(1,2,17,15,20,8,11,22:25,26))]
colnames(df_complete)[1:11] = c("Gender Inequality Index Score","Maternal Mortality Ratio","Male-Female Secondary School Enrollment Ratio",
  "Female Secondary School Completion Rate","Percent of Girls Married before Age 18","Under 5 Mortality Rate",
  "Female Labor Force Participation","Labor force participation rate for ages 15-24, female (%) (modeled ILO estimate)","Labor force, female (% of total labor force)",
  "Account at a formal financial institution, female (% age 15+)","Female legislators, senior officials and managers (% of total)")
df_complete = cbind(df_complete,Region)

all_values <- function(x) {
 if(is.null(x)) return(NULL)
 paste0(names(x)[1:2], ": ", format(x)[1:2], collapse = "<br />")
}

shinyServer(function(input, output) {

  df <- reactive({
    dataframe = data.frame(x=df_complete[,input$xaxis],y=df_complete[,"mean_stunting"],
      country=rownames(df_complete),Regions=df_complete[,"Region"])
    dataframe = na.omit(dataframe)
    dataframe
    })

  reactive({
   base <- df() %>% ggvis(x=~x,y=~y) %>%
    layer_points(size=100,fill.update=~Regions) %>% 
    layer_smooths(span = 1) %>% 
    add_tooltip(all_values,"hover") %>%
    add_axis("y", title = "Average stunting") %>% scale_numeric("y", domain = c(0, 55), nice = FALSE, clamp = TRUE)

    maxx = max(df()$x,na.rm=TRUE)
    if(input$countryText==TRUE){
      base %>% layer_text(text.hover:=~country,text.update:=~country) %>% 
      scale_numeric("x", domain = c(0, maxx), nice = FALSE, clamp = TRUE) %>% 
      add_axis("x",title=input$xaxis) 
    } else {
      base %>% scale_numeric("x", domain = c(0, maxx), nice = FALSE, clamp = TRUE) %>% 
      add_axis("x",title=input$xaxis)
    }
    }) %>% bind_shiny("ggvis", "ggvis_ui")


output$text<-renderText({
  HTML("Data aggregated from the World Bank Development Indicators from 1990-2013.<p>
  Github repository for data aggregation and sources <a href='http://goo.gl/ncwq0d'>available here</a> and
  for interactive visualization <a href='http://goo.gl/LZ1cTi'>available here</a>."
  )
  })

 })