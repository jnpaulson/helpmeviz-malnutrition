library(shiny)
library(ggplot2)
library(ggvis)

xaxisNamesUI = c(
"Gender Inequality Index Score (0-1, 1 is Extreme Inequality)",
"Maternal Mortality Ratio (per 100,000 live births)",
"Female Under 5 Mortality Rate",
"Female Secondary School Completion Rate",
"Ratio of Female to Male Secondary School Enrollment",
"Percent of Girls Married Before Age 18",
"Adolescent Fertility Rate (number of births per 1,000 girls age 15-19)",
"Female Labor Force Participation Rate (percent of females age 15-64)",
"Percent of Females with an Account at a Formal Financial Institution (age 15+)",
"Percent of Legislators, Senior Officials, and Managers that are Female",
"Number of Females Who Die Before Age 5 (per 1,000)",
"Percent of Females with a Credit Card (age 15+)",
"Percent of Women Who have Completed Lower-Secondary School (age 25+)",
"Number of Female Infants Who Die before Age 1 (per 1,000)",
"Percent of Women who Believe a Husband is Justified in Beating his Wife When she Argues with him")

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
        a(href="http://www.bread.org/","As Women Rise, Malnutrition Falls"),
        tags$small(p("Use this interactive tool to compare country data on women's empowerment and stunting."))
      )
    ),
    sidebarLayout(position="right",
      sidebarPanel(
        checkboxInput("countryText","Display Country Labels",value=FALSE),
        checkboxInput("layerSmooth","Display a fittted smooth model",value=FALSE),
        selectInput("regionGroup","Visualize region",regions,regions[1]),
        selectInput("xaxis","Select Women's Empowerment Indicators",xaxisNamesUI,xaxisNamesUI[1]),
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