library(shiny)
library(ggplot2)
library(ggvis)

load("data.rdata")

shinyUI(navbarPage("HelpMeViz",
  tabPanel("Scatter plot",sidebarLayout(sidebarPanel(
    selectInput("yaxis","y-axis:",colnames(df_complete),colnames(df_complete)[1]),
    selectInput("xaxis","x-axis:",colnames(df_complete),colnames(df_complete)[2]),
    selectInput("choice","Size:",colnames(df_complete),colnames(df_complete)[3]),
    uiOutput("ggvis_ui")
  ),
  mainPanel(
    ggvisOutput("ggvis")
  ))),
  tabPanel("Box plots",sidebarLayout(sidebarPanel(
    selectInput("boxplot","Choice:",colnames(df_complete),colnames(df_complete)[1])
    ),
    mainPanel(
      plotOutput('boxp')
    )
    )
  )
))