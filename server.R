library(shiny)
library(ggplot2)
library(grid)
data(mtcars)
#options(error = recover)
#mtcars$trans <- with(mtcars, interaction(gear,am))

regression_model <- function(regressors){
  regressors <- c("mpg",unlist(regressors))
 # cat(regressors)
  dataforlm <- mtcars[, regressors]
  fit_gear <- lm(mpg  ~ ., data =  dataforlm )
  return(fit_gear)
}





shinyServer(
  
  function(input,output){
    #    output$regressors <- renderPrint({input$Var_choice})
    sum1 <- reactive({regression_model(input$Var_choice_1)})
    output$modres1 <- renderPrint({summary(sum1())})
    sum2 <- reactive({regression_model(input$Var_choice_2)})
    output$modres2 <- renderPrint({summary(sum2())})
    
    #   output$modres1 <- renderPrint({summary(regression_model(input$Var_choice_1))})
    #   output$modres2 <- renderPrint({summary(regression_model(input$Var_choice_2))})
    output$anova <- renderPrint({anova(sum1(),sum2())}) 
    output$diagnos1 <- renderPrint({
      if(input$showdiag1)   influence.measures(sum1())
      })
    output$diagnos2 <- renderPrint({
      if(input$showdiag2) influence.measures(sum2())
      })
    
    
    output$plot1 <- renderPlot({
      if(input$showdplot1){
        par(mfrow = c(2,2))
        plot(sum1())
       
      } else {
      # plot("No plot requested.") 
      }
    })      
    
    
    output$plot2 <- renderPlot({
      if(input$showdplot2){
        par(mfrow = c(2,2))
        plot(sum2())
        
      }
      
 })
  }  
  
)