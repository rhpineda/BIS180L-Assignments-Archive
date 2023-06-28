

library(shiny)
library(tidyverse)

shinyServer(function(input, output) {
	#-----------------------------------------
	tomato <- read_csv("Tomato.csv")
	output$barPlot <- renderPlot({
		# convert string to name
		# set up the plot
		tomato %>%
			filter(alt >= input$Range[1], alt <= input$Range[2]) %>%
			group_by(species)%>%
			summarize(count = n())%>%
			ggplot(aes(x = species,
					 y = count,
					 fill=species)) +
			geom_col()
	})
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#-----------------------------------------
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#-----------------------------------------
	output$scatter <- renderPlot({
		filtered_tomato <- tomato %>%
			filter(who == input$who)
		# set up the plot
		pl <- ggplot(data = filtered_tomato,
				   aes(
				   	x = hyp,
				   	y = totleng,
				   	color  =  trt
				   ))
		pl + geom_point()
		# draw the boxplot for the specified trait
		
	})
	
	
	
})


