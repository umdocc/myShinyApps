# server.R
library(shiny)
library(plotrix)
library(RMySQL)
con <- dbConnect(MySQL(),
                 user = 'ozphdapps',
                 password = 'deployingshiny',
                 host = 'apps.ozphd.com',
                 dbname='apps_ozphd_com')
data<-dbReadTable(con, "theDress")
dbDisconnect(con)
shinyServer(
  function(input, output) {
    #draw a pie chart  
    output$myPlot <- renderPlot({
      # compute new variables     
      if(input$var=="Blue and Black"){
        data$value[1]<-data$value[1]+1
        
      }
      else if (input$var=="White and Gold") {
        data$value[2]<-data$value[2]+1
      }
      # write data to remote SQL table
      con <- dbConnect(MySQL(),
                       user = 'ozphdapps',
                       password = 'deployingshiny',
                       host = 'apps.ozphd.com',
                       dbname='apps_ozphd_com')
      dbWriteTable(conn = con, name = 'theDress', value = as.data.frame(data),overwrite=TRUE)
      dbDisconnect(con)
      
      
      blue=data$value[1]/2;black=data$value[1]/2;
      white=data$value[2]/2;gold=data$value[1]/2;
      
      # draw the 3D pie chart
      slices <- c(gold, blue, black, white) 
      lbls <- c("Gold","Blue", "Black", "White")
      pie3D(slices,labels=lbls,
            col=c("darkgoldenrod4","blue4","black","white"),
            main=paste("Total votes:",as.character(sum(data$value))))
    })
    output$text1 <- renderText({ 
      paste("You have selected", input$var)
    })
  }
)
