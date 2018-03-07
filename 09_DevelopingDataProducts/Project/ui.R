library(shiny)
library(shinythemes)
library(ggplot2)
data(iris)
opts <- unique(colnames(iris))
opts <- opts[-1]
shinyUI(fluidPage(theme = shinytheme("united"),
    titlePanel("Iris Data"),
    sidebarLayout(
        sidebarPanel(
            textInput('name', 'Enter your name', value = "fellow human!"),
            selectInput('x', 'X', names(iris), selected = 'Sepal.Lenght'),
            selectInput('y', 'Y', names(iris), selected = 'Sepal.Width')
        ),
        mainPanel(
            h1(textOutput("out1")),
            p("For the 'Plot' tab below , please select x and y variables on the left panel"),
            p("The other tabs do not require user interface! :)"),
            tabsetPanel(type = "tabs",
                        tabPanel("Pairs", plotOutput("pairsplot")),
                        tabPanel("Summary", plotOutput("distPlot4"),
                                 verbatimTextOutput("summary"),tableOutput("view")),
                        tabPanel("Plot", plotOutput("plot1"))
                                 
                       
            )
        )
    )
))