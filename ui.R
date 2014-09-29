library(shiny)
library(ggplot2)
library(ggvis)

xaxisChoices=c("Gender Inequality Index Score","Maternal Mortality Ratio","Male-Female Secondary School Enrollment Ratio",
  "Female Secondary School Completion Rate","Percent of Girls Married before Age 18","Under 5 Mortality Rate",
  "Female Labor Force Participation","Labor force participation rate for ages 15-24, female (%) (modeled ILO estimate)","Labor force, female (% of total labor force)",
  "Account at a formal financial institution, female (% age 15+)","Female legislators, senior officials and managers (% of total)")
regions = c("All","Asia","Europe","Africa","Americas")

shinyUI(
  fluidPage(
    tags$head(includeScript("google-analytics.js")),
    titlePanel(
      tags$div(class="header", checked=NA,
        a(href="http://www.bread.org/","Bread for the World"),
        tags$small(p("Interactive explorer of stunting and women's empowerment"))
      )
    ),
    sidebarLayout(position="right",
      sidebarPanel(
        checkboxInput("countryText","Country text",value=FALSE),
        checkboxInput("layerSmooth","Display a fittted smooth model",value=FALSE),
        selectInput("regionGroup","Visualize region",regions,regions[1]),
        selectInput("xaxis","x-axis:",xaxisChoices,xaxisChoices[1]),
        uiOutput("ggvis_ui")
      ),
      mainPanel(
        ggvisOutput("ggvis"),
        br(),
        uiOutput('text')
      )
    )
  )
)