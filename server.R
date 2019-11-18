setwd("C:/Users/cmilbank/Documents")

#Sys.setenv(JAVA_HOME = "H:/Decision Support/Stats Jam/R files/Java/jre1.8.0_201")

library(shiny)
library(shinythemes)

warnings()

server <- function(input, output) {
  
  #Calculate p-value
  values <- reactiveValues()
  observe({
#    input$action_Calc
    values$p_value <- round(1 - pbinom(input$n_terminations - 1, input$n_employees, input$hypothesized_rate),3)
    values$observed_rate <- round(input$n_terminations/input$n_employees, 3)
    values$reject <- ifelse(values$p_value < input$alpha, "yes", "no")
  })
  
  # Reactive expression to create data frame of all input values ----
  sliderValues <- reactive({
    
    data.frame(
      Name = c("Number of terminations",
               "Number of employees",
               "Observed termination rate",
               "Hypothesized termination rate",
               "Confidence level",
               "P-value",
               "Statistically significant turnover?"),
      Value = as.character(c(input$n_terminations,
                             input$n_employees,
                             values$observed_rate,
                             input$hypothesized_rate,
                             input$alpha,
                             values$p_value,
                             values$reject)),
      stringsAsFactors = FALSE)
    
  })
  
# Show the values in an HTML table ----
  output$values <- renderTable({
    sliderValues()
  })
  
#  output$text_int <- renderText({
#    if(input$action_Calc == 0) ""
#    else
#      paste("Simple Interest [$]:", values$p_value)
#  })
  
}