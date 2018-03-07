library(shiny)
library(ggplot2)


data("iris")

iris <- iris

shinyServer(function(input, output, session) {
selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
})


    
output$text1 <- renderText({input$id1})
    
output$text2 <- renderText({input$select1})
    
output$plot1 <- renderPlot({
    g <- ggplot(iris, aes_string(x=input$x, y=input$y)) 
    g <- g + geom_point(aes(color=Species, shape=Species)) +
        geom_vline(aes(xintercept = mean(Sepal.Length)), color = "red", linetype = "dashed") +
        geom_hline(aes(yintercept = mean(Sepal.Width)), color = "red", linetype = "dashed") +
        geom_smooth(aes(group=Species, color=Species), method="lm") +  
        ggtitle("Edgar Anderson's Iris Data")
    print (g)
    })
    
    output$summary <- renderPrint({
        summary(iris)
    })
    
    output$pairsplot <- renderPlot({
    pairs(iris[1:4], main = "Edgar Anderson's Iris Data", pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)])
    })
    
    output$distPlot4 <- renderPlot({
        ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
            geom_boxplot() +
            ylab("Sepal Length") +
            xlab("Species") +
            ggtitle("Sepal Length by Species") +
            theme_bw() +
            theme(plot.title = element_text(hjust = 0.5))
    })
    
    output$out1 <- renderText({
        paste("Hello, ", input$name)
        
})
})
