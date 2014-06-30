library(shiny)
library(ggplot2)
library(ggvis)
dat = read.csv("Stunting3.csv",header=TRUE,stringsAsFactors=FALSE)
dat = dat[,c(1:12,15,18,21,24,26,27)]
colnames(dat) = c("Country","Female parliament % (12)","LaborForceF (11)","LaborForceM (11)",
                  "Maternal.Mortality.Ratio (10)","Adolescent fertility rate","Pop. 2nd Ed Female (06-10)",
                  "Pop. 2nd Ed Male (06-10)","LaborForceF Participation (11)","LaborForceM Participation (11)",
                  "GII (10)","GII (12)","2013 Global Hunger Index","Under-five Mortality rate (%)","Prevalence of undernourishment"
                  ,"Prevalence of underweight in children under five years","MeanStuntingF","MeanStuntingM")

shinyUI(navbarPage("HelpMeViz",
  tabPanel("Scatter plot",sidebarLayout(sidebarPanel(
    selectInput("yaxis","y-axis:",colnames(dat)[2:ncol(dat)],colnames(dat)[14]),
    selectInput("xaxis","x-axis:",colnames(dat)[2:ncol(dat)],colnames(dat)[12]),
    selectInput("choice","Size:",colnames(dat)[2:ncol(dat)],colnames(dat)[4]),
    uiOutput("ggvis_ui")
  ),
  mainPanel(
    ggvisOutput("ggvis")
  ))),
  tabPanel("Scatter plots",sidebarLayout(sidebarPanel(
    selectInput("size","size:",colnames(dat)[2:ncol(dat)],colnames(dat)[4])
    ),
    mainPanel(
      plotOutput('plot')
    )
    )
  )
))