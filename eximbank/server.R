# Eximbank mobile app and data collector, shiny version
# Dedicated to my mom, for educational purpose only
# server.R

library(shiny)
library(RMySQL)
source("./getNewRateData.R")

# ---- read and write to database ---------------------- 
con <- dbConnect(MySQL(),
                 user = 'ozphdapps',
                 password = 'deployingshiny',
                 host = 'apps.ozphd.com',
                 dbname='apps_ozphd_com')

# use SQL query to read lastest date of data table
rs <- dbSendQuery(con, "SELECT Date FROM eximbank 
                        ORDER BY Date DESC LIMIT 1")
lastDate <- dbFetch(rs)  
# append data if the date is newer
if (Sys.Date()>lastDate$Date){
  exRateData <- getNewRateData()
  dbWriteTable(conn = con, name = 'eximbank', value = as.data.frame(exRateData),append=TRUE)
  dbDisconnect(con)
}else{
  exRateData <- getNewRateData()
  dbDisconnect(con)  
}


# --------------- beginning shiny server -------------------------------

shinyServer(
  function(input, output) {
    output$text1 <- renderText({ 
      rate <- exRateData[exRateData$"Ngoai te"==input$currency,]
      paste(as.character(rate$dataCshBuy))
    })
    output$text2 <- renderText({ 
      rate <- exRateData[exRateData$"Ngoai te"==input$currency,]
      paste(as.character(rate$dataTtBuy))
    })
    output$text3 <- renderText({ 
      rate <- exRateData[exRateData$"Ngoai te"==input$currency,]
      paste(as.character(rate$dataCshSell))
    })
    output$text4 <- renderText({ 
      paste("cap nhat:",as.character(Sys.Date()))
    })
  }
)
