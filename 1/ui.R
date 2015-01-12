#install.packages('shiny')
#setwd('/myStuff/9-DevelopingDataProducts/projects/1')
library(shiny)


shinyUI(pageWithSidebar(
  headerPanel('Fuel Consumption Predictor'),
  sidebarPanel(
    h3('Key Parameters'),
    sliderInput('weight',
                'Vehicle weight in pounds',
                min=500, max=7000, value=2000),
    sliderInput('qmtime',
                'Quarter mile time in seconds',
                min=10, max=25, value=18),
    selectInput('manauto',
                'Transmission Type',
                choices=c('auto', 'manual')),
    helpText('See the expected fuel consumption for different combinations of vehicle weight,
             quarter mile time and transmission type.')
    ),
  mainPanel(
   h3('Expected fuel consumption'),
   p(' '),
   h4('Input Data'),
   textOutput("weight"),
   textOutput("qmtime"),
   textOutput("manauto"),
   p(' '),
   h4('Result'),
   textOutput("fit"),
   p(' '),
   p('95 % confidence interval')
)
))
