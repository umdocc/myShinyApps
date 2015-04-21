shinyServer(
  function(input, output, clientData, session) {
    
#     output$slider1 <- renderUI({
#       if (input$works=="Science- Dispersion"){sliderLabel<-"Selec Dispersion Range"
#                                               sliderMin<-0
#                                               sliderMax<-5000}
#       if (input$works=="Science - PMD"){sliderLabel<-"Selec PMD"
#                                         sliderMin<-0
#                                         sliderMax<-50}
#     
#       sliderInput("control_num",
#                   label=sliderLabel,
#                   min = sliderMin, max = sliderMax, value = 5)
#     })
    output$slider1 <- NULL
    
  })