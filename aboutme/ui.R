shinyUI(fluidPage(
  titlePanel("Cuong Do PhD - Interactive Profile App"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("about", label = "About me",
                   choices = c("Personal information","What I like","Extras")
      ),
      selectInput("works", label = "My works",
                  choices = c("Science- Dispersion","Science - PMD","Extras")
      ),
      uiOutput("slider1")
    ),
    mainPanel(
      h2("text1")
    )
  ))
)