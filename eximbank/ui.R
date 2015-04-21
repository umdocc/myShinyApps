# ui.R
# choice<-read.csv("maker.csv",header=TRUE)
# colnames(choice)<-c("order","name")
# inputName<-as.character(choice$name)

shinyUI(fluidPage(
  titlePanel("Eximbank"),
  
  sidebarLayout(
    sidebarPanel(
      width=3,
      selectInput("currency", 
                  label = "Chon loai ngoai te",
                  choices = c("USD (50-100)","USD (5-20)","USD (5)","GBP","HKD","CHF","JPY","AUD","CAD","SGD","EUR","NZD","THD","NOK"),
                  selected = "AUD", width="150px",selectize=FALSE),
      textOutput("text4")),
    mainPanel(
      h4("Gia ban"),
      textOutput("text3"),
      h4("Gia mua TM"),
      textOutput("text1"),
      h4("Gia mua CK"),
      textOutput("text2")
    )
    
  )
))
