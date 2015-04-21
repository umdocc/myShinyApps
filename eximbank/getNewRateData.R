# Eximbank mobile app and data collector, shiny version
# Dedicated to my mom, for educational purpose only

library(httr)
library(dplyr)
library(XML)
getNewRateData <- function(){ 
# -------------- get the XML from APSX table -------------------
basePage <- "https://eximbank.com.vn"
h <- handle(basePage)
res <- GET(handle = h, path = "/WebsiteExrate/ExchangeRate_vn_2012.aspx")
resXML <- htmlTreeParse(content(res, as = "text"),encoding="UTF-8",useInternalNodes = T)

# -------------- data extraction ----------------------

dataName <- as.data.frame(c("USD (50-100)","USD (5-20)","USD (5)","GBP","HKD","CHF","JPY","AUD","CAD","SGD","EUR","NZD","THD","NOK"))
colnames(dataName) <- "Ngoai te" 
# function to crawl the remaining column, return a vector of 1x3
getExRate <- function(tableID=7){ #default tableID to AUD
  pathname <- paste("//span[@id='ExchangeRateRepeater_lblCSHBUYRT_",as.character(tableID),"']",sep="")
  dataCshBuy <- xpathSApply(resXML, pathname, xmlValue)
  pathname <- paste("//span[@id='ExchangeRateRepeater_lblTTBUYRT_",as.character(tableID),"']",sep="")
  dataTtBuy <- xpathSApply(resXML, pathname, xmlValue)
  pathname <- paste("//span[@id='ExchangeRateRepeater_lblCSHSELLRT_",as.character(tableID),"']",sep="")
  dataCshSell <- xpathSApply(resXML, pathname, xmlValue)
  ExRate <- cbind(as.character(tableID),dataCshBuy,dataTtBuy,dataCshSell)
  
  return(ExRate)
} 

#get data for all types of currency
exRateData <- lapply(0:13, FUN=getExRate)
exRateData <- bind_rows(lapply(exRateData, function(x) as.data.frame(x)))
exRateData <- cbind(dataName,exRateData)

# attach time stamp
exRateData$Date <- Sys.Date()
return(exRateData)
}