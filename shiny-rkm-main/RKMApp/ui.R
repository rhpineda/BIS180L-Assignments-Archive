
library(shiny)

shinyUI(fluidPage(
	titlePanel("Tomato Count for Altitude Range, by Species"),
	#----------------------------------------------- 
	fluidRow(
		titlePanel("Altitude Range and Species Present"),
		sidebarPanel(
			helpText("This application creates histogram to show which species are",
				    "present in the range selected on the slider. Use the slider",
				    "to choose range of interest"),
			sliderInput(inputId = "Range",
					  label = "Altitude range:",
					  min = 0,
					  max = 4000,
					  value = c(500,2500))
		),
		mainPanel(
			plotOutput("barPlot") #This is where ur output$urplot goes
		)
	),

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#----------------------------------------------- Next person
	fluidRow(
		titlePanel("Hypocotyl Length vs Total Length by Data Collector of your Choosing"),
		sidebarPanel(
			selectInput("who", #the input variable that the value will go into
						"Choose Data Collector:",
						c("Dan",
						  "Pepe")
			)),
		mainPanel(

			plotOutput("scatter") 


		)
	)
))