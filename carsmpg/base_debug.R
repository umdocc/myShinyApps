data <- read.table("vehicles.csv",sep=",",header=TRUE)
relData <- data[(data$year>1995 )&(data$year<max(data$year)), ]
vehicles<-relData[,c("year","comb08","displ","fuelType","make","evMotor")]
vehicles$make<-as.character(vehicles$make)

merits<-vector(length=20)
for (i in 1:20){
  makerVehicles<-vehicles[((vehicles$make=="Acura")&(vehicles$year==(i+1995))),]
  #skip if manufacturer does not have a model for that year
  if (dim(makerVehicles)[1]!=0){
    makerData<-aggregate( comb08~displ, makerVehicles, mean )
    x<-makerData$displ; y<-makerData$comb08
    
    fit <- lm( y~x) #linear regression model  
    meritPoint<- -(fit$coeff[2]) # the inverse of the slope indicates the maker technical ability
    
    merits[i]<-meritPoint #write merit point to vector
  }
  
}
merits[is.na(merits)]<-0 #replace NA with zero
total_sum<-as.character(sum(merits))

xdata <- 1996:2015 # 
ydata  <- merits
par(bg="grey") 
plot(xdata,ydata,type="b", lwd=2,col="red", xlab="Year",ylab="Point",main=paste("Technical points for", "Acura", "over the last 20 years"),sub=paste("Total points =", (total_sum)))