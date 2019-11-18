setwd("C:/Users/cmilbank/Documents")

#Sys.setenv(JAVA_HOME = "H:/Decision Support/Stats Jam/R files/Java/jre1.8.0_201")

library(shiny)
library(shinythemes)

warnings()


ui <- fluidPage(theme = shinytheme("readable"),
  
  # App title ----
  titlePanel("WFI Turnover/Statistical Significance Tool"),
  
  fluidRow(
    column(10, offset = 0,
           p("How do we know if the turnover that we're seeing for a given group is meaningfully different from what we should expect? 
             For example, maybe turnover of 7 people out of 17 can be reasonably expected when looking at a high-risk group (such as first 
             year employees in a high-churn job), but is a signal of a deeper issue when looking under a different context (such as 
             high-performing leaders). This tool attempts to arm us with statistical data to know when the turnover rates we're seeing are 
             significantly different than could be expected due to chance alone.")
    )
    ),
  

  fluidRow(
    column(10, offset = 0,
           p("In order to perform a statistical test all you need are a few simple numbers:")
    )
  ),
  
  fluidRow(
    column(10, offset = 0,
           p("Number of Terminations: This is the number of terminations in your sample during the measurement period. It can be thought of
             as the numerator of your termination rate (e.g. 7 in the example above).")
    )
  ),
  
  fluidRow(
    column(10, offset = 0,
           p("Number of Employees: This is the number of employees in your sample during the measurement period. It can be thought of
             as the denominator of your termination rate (e.g. 17 in the example above).")
    )
  ),
  
  fluidRow(
    column(10, offset = 0,
           p("Hypothesized Termination Rate: The hypothesized rate can be viewed as the termination rate that we would *expect* to see from the 
             given population over the given time period. As a rough example, maybe we would set our hypothesized rate to 13% 
             when analyzing overall turnover, 9% when analyzing resignation, and 20% when analyzing first year benefited
             turnover. NOTE: If you are looking at *monthly* turnover rates, be sure to adjust your hypothesized rate
             by dividing by 12.")
           )
           ),
  
  fluidRow(
    column(10, offset = 0,
           p("Confidence Level: This input is 
             a statistical parameter that balances the risk of arriving at an incorrect conclusion. If you would like to be
             more confident in your results you may adjust this value to as low as .01, but we recommend simply leaving it 
             at the .05 level.")
           )
           ),
  
  fluidRow(
    column(10, offset = 0,
           p("At the bottom of the screen is a dynamic table with the calculated p-value, which measures the probability of seeing the level of results that
              we are seeing. If the p-value is less than the confidence level we can conclude that the observed termination rates are most likely not due to 
              chance alone.")
    )
  ),
  
  fluidRow(
    column(10, offset = 0,
           p("For any questions on this tool or its applications please reach out to Christian Milbank or another member of the WFI team.")
           )
           ),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      
      # Input: Simple integer interval ----
      sliderInput("n_terminations", "Number of Terminations:",
                  min = 0, max = 50,
                  value = 5),
      
      # Input: Simple integer interval ----
      sliderInput("n_employees", "Number of Employees:",
                  min = 0, max = 100,
                  value = 50),
      
      # Input: Decimal interval with step value ----
      sliderInput("hypothesized_rate", "Hypothesized Termination Rate:",
                  min = 0, max = 1,
                  value = 0.1, step = 0.01),
      
      # Input: Decimal interval with step value ----
      sliderInput("alpha", "Confidence Level:",
                  min = 0, max = 1,
                  value = 0.05, step = 0.01)
      
    ),
    
    
    # Main panel for displaying outputs ----
       mainPanel( 
         #img(src='screenshot_smallest4.png', align = "middle", offset = 0),
    
    # Output: Table summarizing the values entered ----
    tableOutput("values")
      
      
    )
  )
)
