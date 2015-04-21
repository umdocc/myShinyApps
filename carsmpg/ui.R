# ui.R
choice<-read.csv("maker.csv",header=TRUE)
colnames(choice)<-c("order","name")
inputName<-as.character(choice$name)

shinyUI(fluidPage(
  titlePanel("Automakers' technical abilities"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("var", 
                  label = "Select an auto manufacturer",
                  choices = inputName,
                  selected = "Acura"),
      selectInput("mode", 
                  label = "Select calculation mode",
                  choices = c("Linear","Quadratic"),
                  selected = "Linear")
      
    ),
    mainPanel(
      textOutput("text1"),
      plotOutput("myPlot"),
      h1("Explanation"),
      p("This app will attemp to \"grade\" a car manufacturer technical ability by looking at how the MPGs in their cars change with the size of their engines. It uses a simple and naive regression method to calculate this point for a specific car manufacturer for every year that the manufacturer release a model. A larger boost in MPG towards smaller engine size simply indicates that the manufacturer has better technical ability. The total points are the point accumulated by a manufacturer over 20 years"),
      p("In Linear mode, it will fit a linear regression model and calculate the slope as technical ability point."),
      p("In Quadratic mode, it will fit a quadratic model and calculate the curvature of the fitted parabola as technical ability point."),
      p("MPG data available at the U.S Department of Energy website: http://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip")    
    )
    
  )
))
