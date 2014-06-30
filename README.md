HelpMeViz Hackathon - Saturday, June 28, 2014

=============
Overview
--------

The following is an interactive visualization of various indices related to women's empowerment and nutrition created for the 
[HelpMeViz](http://helpmeviz.com/) [hackathon on Women's Empowerment and Nutrition](http://helpmeviz.com/2014/06/28/hackathon-womens-empowerment-nutrition/) to explore their relationship.

From the HelpMeViz description:

> As we begin to explore years of data on women’s empowerment from the World
> Bank and United Nations, we want to ask the question: Do countries that
> significantly improve the status of women also see lower rates of stunting?
> Women are the primary caregivers in the family. Research from countries
> around the world has shown that when women are empowered to earn more and
> have a greater say in home finances, they are more likely than men to invest
> the additional money in promoting the welfare of their children — through
> nutritious food, for example. In this project, Bread for the World Institute
> is interested in exploring whether and where women’s empowerment is
> associated with improvements in stunting and, if so, over what period of
> time. The answer to the question of whether the two indicators coincide is
> most likely to be "sometimes yes, sometimes no."

For more information on the goals of the visualization challenge, see:

* [HelpMeViz: Women's Empowerment &
  Nutrition](http://helpmeviz.com/2014/06/28/hackathon-womens-empowerment-nutrition/)
* [Bread for the World](http://www.bread.org/institute/)

Data Sources
------------

The data used for this analysis comes from several sources and was compiled into a nice comprehensible format by [Keith Hughitt](https://github.com/khughitt/helpmeviz-womens-empowerment) in his Github repo related to the same challenge.

Running the visualization locally
----------------

To install the shiny app load up R:
```S
if(!require(shiny)){
  install.packages("shiny")
}
library("shiny")
runGitHub("helpmeviz-malnutrition", "nosson")
```

Exploring the data
----------------
The visualization can be accessed [here](https://jpaulson.shinyapps.io/helpmeviz/).
