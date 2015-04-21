# server.R
library(shiny)
data <- read.table("vehicles.csv",sep=",",header=TRUE)
relData <- data[(data$year>1995 )&(data$year<max(data$year)), ]
vehicles<-relData[,c("year","comb08","displ","fuelType","make","evMotor")]
vehicles$make<-as.character(vehicles$make)

#Exclude all EV and hybrid vehicles
vehicles$evMotor<-as.character(vehicles$evMotor)
vehicles<-vehicles[vehicles$evMotor=="",]

#sort the data by makers then by engine
vehicles<-vehicles[with(vehicles,order(vehicles$make,vehicles$displ)),]
vehicles<-vehicles[complete.cases(vehicles),]

shinyServer(
  function(input, output) {
    #We're now ready to calculate merit points of all automaker and grade them
    #       create a merit points data frame  
    
    output$myPlot <- renderPlot({
      merits<-vector(length=20)
      for (i in 1:20){
        makerVehicles<-vehicles[((vehicles$make==input$var)&(vehicles$year==(i+1995))),]
        #skip if manufacturer does not have a model for that year
        if (dim(makerVehicles)[1]!=0){
          x<-makerVehicles$displ; y<-makerVehicles$comb08
          if (input$mode=="Linear"){
            fit <- lm( y~x) #linear regression model  
            meritPoint<--(fit$coeff[2]) # the inverse of the slope indicates the maker technical ability
          }
          if (input$mode=="Quadratic"){
            fit2 <- lm( y~poly(x,2,raw=TRUE)) #quadratic regression model
            meritPoint<-(fit2$coeff[3]) # the curvature of parabola indicates the maker technical ability
          }
          merits[i]<-meritPoint #write merit point to vector
        }
        
      }
    
    merits[is.na(merits)]<-0 #replace NA with zero
    total_sum<-as.character(sum(merits))
    
    xdata <- 1996:2015 # 
    ydata  <- merits
    
    # draw the histogram with the specified number of bins
    par(bg="grey") 
    plot(xdata,ydata,type="b", lwd=2,col="red", xlab="Year",ylab="Point",main=paste("Technical points for", input$var, "over the last 20 years"),sub=paste("Total points =",total_sum))
  })
output$text1 <- renderText({ 
  paste("You have selected car maker", input$var, ".The regression model used is",input$mode)
})
}
)
