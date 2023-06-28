library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Pokemon Stats"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "Generations",
        "What generations should be included",
        c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4,
          "Five" = 5, "Six" = 6, "Seven" = 7),
        selected = 1:7
      ),
      sliderInput("weight",
                  "Weight range of pokemon",
                  min = 0,
                  max = 1000,
                  value = c(0,1000)),
      selectizeInput("statistic",
                     "Stat to show",
                     c("Attack","Defense","Speed","Hp"),
                     selected = "Attack")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(plotOutput("statsPlot"))
  )
))
