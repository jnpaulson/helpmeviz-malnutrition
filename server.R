library(shiny)
library(ggplot2)
library(ggvis)

xaxisChoices=
c("GII_2012",
"maternal_mortality_ratio",
"ifpri_under5_mortality",
"secondary_school_female",
"secondary_school_female_ratio",
"married_by_18_rate",
"adolescent_fertility_rate",
"labor_participation_female_ilo",
"account_at_financial_inst_female",
"female_legislators_officials_mgrs",
"mortality_under5_female",
"credit_card_female",
"educational_attainment_femae",
"mortality_rate_female_child",
"belief_beating_justified",
"mean_stunting")

xaxisNames = 
c("Gender Inequality Index Score (0-1, 1 is Extreme Inequality)",
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
"Percent of Women who Believe a Husband is Justified in Beating his Wife When she Argues with him",
"Percent of Children Under Age 5 who are Stunted")

df_complete = read.csv("./Stunting_clean.csv")
Region = factor(df_complete[,2])
names(Region) = df_complete[,1]
rownames(df_complete) = df_complete[,1]
df_complete = df_complete[,-c(1:2)]
df_complete = df_complete[,xaxisChoices]
colnames(df_complete) = xaxisNames
df_complete = cbind(df_complete,Region)

all_values <- function(x) {
 if(is.null(x)) return(NULL)
 paste0(names(x)[1:2], ": ", format(x)[1:2], collapse = "<br />")
}
shinyServer(function(input, output) {

  df <- reactive({
    dataframe = data.frame(x=df_complete[,input$xaxis],y=df_complete[,"Percent of Children Under Age 5 who are Stunted"],
      country=rownames(df_complete),Regions=df_complete[,"Region"])
    if(input$regionGroup!="All"){
      dataframe = dataframe[dataframe$Regions==input$regionGroup,]
    }
    dataframe = na.omit(dataframe)
    dataframe
    })

  reactive({
    maxx = max(df()$x,na.rm=TRUE)
    maxy = max(df()$y,na.rm=TRUE)

    base <- df() %>% ggvis(x=~x,y=~y) %>%
      layer_points(size=100,fill.update=~Regions) %>% 
      add_tooltip(all_values,"hover") %>%
      add_axis("y", title = "Percent of Children Under Age 5 who are Stunted") %>% 
      scale_numeric("y", domain = c(0, maxy), nice = FALSE, clamp = TRUE) %>%
      add_axis("x",title=input$xaxis) 

    if(input$countryText==TRUE){
      base <- base %>% layer_text(text.hover:=~country,text.update:=~country)
    }
    if(input$layerSmooth==TRUE){
      base <- base %>% layer_smooths(span = 1)
    }
    base
    }) %>% bind_shiny("ggvis", "ggvis_ui")


output$text<-renderText({
  HTML("Data aggregated from the World Bank Development Indicators from 1990-2013.<p>
  Github repository for data aggregation and sources <a href='http://goo.gl/ncwq0d'>available here</a> and
  for interactive visualization <a href='http://goo.gl/LZ1cTi'>available here</a>."
  )
  })

 })