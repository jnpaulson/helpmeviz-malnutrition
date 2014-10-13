library(shiny)
library(ggplot2)
library(ggvis)

# xaxisChoices=c("Gender Inequality Index Score","Maternal Mortality Ratio","Male-Female Secondary School Enrollment Ratio",
  # "Female Secondary School Completion Rate","Percent of Girls Married before Age 18","Under 5 Mortality Rate",
  # "Female Labor Force Participation","Labor force participation rate for ages 15-24, female (%) (modeled ILO estimate)","Labor force, female (% of total labor force)",
  # "Account at a formal financial institution, female (% age 15+)","Female legislators, senior officials and managers (% of total)")
xaxisChoices=c(
"GII_2012",                        
"maternal_mortality_ratio",        
"adolescent_fertility_rate_gii",   
"seats_parlim_female_gii",         
"labor_participation_female_gii",  
"labor_participation_male_gii",    
"ifpri_hunger_index",              
"ifpri_under5_mortality",          
"ifpri_undernourishment",          
"ifpri_under5_underweight",        
"labor_participation_female",      
"labor_participation_total_ilo",   
"labor_participation_total_nat",   
"labor_participation_ratio_ilo",   
"secondary_school_female",         
"secondary_school_male",           
"secondary_school_female_ratio",   
"contraceptive_prevalence",        
"hiv_rate_female",                 
"married_by_18_rate",              
"adolescent_fertility_rate",       
"labor_participation_female_ilo",  
"labor_force_female_percent",      
"account_at_financial_inst_female",
"female_legislators_officials_mgrs",
"mortality_under5_female",         
"contrib_family_workers_female",   
"credit_card_female",              
"educational_attainment_femae",    
"mortality_rate_female_child",     
"belief_beating_justified",        
"mean_stunting",                   
"mean_malnutrition",               
"secondary_education"           
)
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