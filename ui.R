library(shiny)
library(ggplot2)
library(ggvis)

load("data.rdata")
regions_complete[regions_complete==2] = "Africa"
regions_complete[regions_complete==142] = "Asia"
regions_complete[regions_complete==150] = "Europe"
regions_complete[regions_complete==19] = "South America"

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
