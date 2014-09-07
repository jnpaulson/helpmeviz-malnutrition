library(shiny)
library(ggplot2)
library(ggvis)


df_complete = read.csv("./Stunting_clean.csv")
regions_complete = df_complete[,2]
rownames(df_complete) = df_complete[,1]
df_complete = df_complete[,-c(1:2)]

shinyUI(navbarPage("HelpMeViz",
  tabPanel("Scatterplots",sidebarLayout(sidebarPanel(
    selectInput("yaxis","y-axis:",colnames(df_complete),colnames(df_complete)[9]),
    selectInput("xaxis","x-axis:",colnames(df_complete),colnames(df_complete)[11]),
    selectInput("choice","Size:",colnames(df_complete),colnames(df_complete)[2]),
    uiOutput("ggvis_ui")
  ),
  mainPanel(
    ggvisOutput("ggvis")
  ))),
  tabPanel("Boxplots",sidebarLayout(sidebarPanel(
    selectInput("boxplot","Choice:",colnames(df_complete),colnames(df_complete)[1])
    ),
    mainPanel(
      plotOutput('boxp')
    )
    )
  )
))
