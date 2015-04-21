# ui.R
# choice<-read.csv("maker.csv",header=TRUE)
# colnames(choice)<-c("order","name")
# inputName<-as.character(choice$name)

shinyUI(fluidPage(
  titlePanel("#Thedress voting app"),
  
  sidebarLayout(
    sidebarPanel(
      img(src = "dress.jpg", height = 278, width = 200),
      radioButtons("var", label = "What is the color of #thedress?",
                  choices = c("Undecided","Blue and Black","White and Gold")
                  ),
      submitButton("Add my answer")
      ),
    mainPanel(
      textOutput("text1"),
      plotOutput("myPlot")
  )
))
)