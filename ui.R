library(shiny)
library(ggplot2)
library(ggvis)


df_complete = read.csv("./Stunting_clean.csv")
regions_complete = df_complete[,2]
rownames(df_complete) = df_complete[,1]
df_complete = df_complete[,-c(1:2)]

shinyUI(fluidPage(
  titlePanel("HelpMeViz"),
  
  sidebarLayout(position="right",sidebarPanel(
    selectInput("xaxis","x-axis:",colnames(df_complete)[c(1,17,15,20,8,11)],colnames(df_complete)[1]),
    uiOutput("ggvis_ui")
  ),
  
  mainPanel(
    ggvisOutput("ggvis"),
    br(),
    textOutput('text')
  ))
  # ,
  # tabPanel("Boxplots",sidebarLayout(sidebarPanel(
  #   selectInput("boxplot","Choice:",colnames(df_complete),colnames(df_complete)[1])
  #   ),
  #   mainPanel(
  #     plotOutput('boxp'),
  #   )
  #   )
  # )
))


