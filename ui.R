library(shiny)
library(ggplot2)
library(ggvis)

xaxisChoices=c("Gender Inequality Index Score","Maternal Mortality Ratio","Male-Female Secondary School Enrollment Ratio",
  "Female Secondary School Completion Rate","Percent of Girls Married before Age 18","Under 5 Mortality Rate",
  "Female Labor Force Participation","Labor force participation rate for ages 15-24, female (%) (modeled ILO estimate)","Labor force, female (% of total labor force)",
  "Account at a formal financial institution, female (% age 15+)","Female legislators, senior officials and managers (% of total)")
regions = c("All","Asia","Europe","Africa","Americas")

googleAnalytics <- function(account="UA-55278636-1"){
  HTML(paste("<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', '",account,"', 'umd.edu');
  ga('send', 'pageview');

</script>", sep=""))
}

shinyUI(
  fluidPage(
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
        googleAnalytics(),
        ggvisOutput("ggvis"),
        br(),
        uiOutput('text')
      )
    )
  )
)