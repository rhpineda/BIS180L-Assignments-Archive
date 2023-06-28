library(shiny)
library(tidyverse)

# Inputs are generations, weight, statistic
# Define server logic
shinyServer(function(input, output) {
  pokemon <- read_csv("pokemon.csv") %>%
    mutate(Generation = as.factor(Generation))
  
  output$statsPlot <- renderPlot({
    filtered_pokemon <- pokemon %>%
      filter(Generation %in% input$Generations) %>%
      filter(Weight_kg >= input$weight[1], Weight_kg <= input$weight[2])
    
    plotStat <- as.name(input$statistic)
    
    ggplot(filtered_pokemon, aes(
      x = Generation,
      y = !!plotStat,
      group = Generation,
      color = Generation
    )) +
      geom_violin() +
      theme(legend.position = "none",
            axis.text = element_text(size = 15),
            axis.title=element_text(size=20,face="bold"))
  })
})