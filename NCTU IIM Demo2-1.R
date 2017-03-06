install.packages("quantmod")
library("quantmod")
getSymbols("AAPL")
AAPL = AAPL["2007-01-05::2014-04-06"]
chartSeries(AAPL,subset="last 9 months",theme = "white")
#chartSeries(AAPL,theme = "white")

addSMA(20,col="blue")
addSMA(60,col="red")
dropTA("SMA")
fastMA = runMean(AAPL[,4],n=20)
slowMA = runMean(AAPL[,4],n=60)
position = Lag(ifelse(fastMA>=slowMA,1,0))
position[is.na(position)] = 0

profit=setNames(numeric(length(index(AAPL))), index(AAPL))	## profit vector
for(i in 2:length(position)){
  if(position[i-1]==0 && position[i]==1){
    entryPrice = as.double(AAPL[i,1])
  }else if(position[i-1]==1 && position[i]==0){
    print(entryPrice)
    profit[i] = AAPL[i,1]-entryPrice
  }
}

#return = ROC(Op(AAPL))*position*100
#return = na.omit(return)
plot(cumsum(profit),type="l",col="red",lwd=2)

#profit = cumsum(return)

shortPos = function(x){
  diff(x) <0 
}

longPos = function(x){
  diff(x) >0 
}

#position[,">0"]
longPos(position)

#AAPL[position[,">0"],"AAPL.Low"] - 30
chartSeries(AAPL["2007-01-05::2014-04-06"],theme = "white" , type = "candle")
fastMA = runMean(AAPL[,4],n=20)
slowMA = runMean(AAPL[,4],n=60)
addTA(fastMA,on=1 , col="blue")
addTA(slowMA,on=1 , col="brown")
#AAPL[longPos(position),"AAPL.Low"] - 30
#zoomChart("2007-01-05::2014-04-06")

addTA(AAPL[longPos(position),"AAPL.Low"] - 5, pch=2 ,type = "p" , col="red" , on = 1)
addTA(AAPL[shortPos(position),"AAPL.High"] + 5, pch=6 ,type = "p" , col="green" , on = 1 )
#addSMA(n=11)
#dropTA("addTA")
#dropTA("addSMA")


zoomChart("2007-01-05::2007-12-30")




#diff
#methods(diff)
#getAnywhere(diff.ts)
#Stock=as.matrix(to.daily(AAPL))
getSymbols("2330.tw")
Stock=get("2330.TW")
chartSeries(Stock["2007-01-05::2007-03-30"],theme = "white" , type = "candle")
colnames(Stock) = c("Open","High","Low","Close","Volume","Adj")
myStock = as.data.frame(Stock)
myStock$Time = rownames(myStock)
collength = ncol(myStock)
myStock = myStock[, c(collength, 1:(collength-1))]
row.names(myStock) = NULL
get_HReverse =  function(t,o,h,l,c){
  mydata = data.frame(date=as.Date(t),fhigh=0,flow=0) ##as.Date() very Important!!! No:Integer, With:Double
  #mydata = data.frame(date=t,fhigh=0,flow=0)
  #print(mydata)
  for (i in 4:length(t)) {
    if(c[i]>c[i-1] && c[i-1]>c[i-2] && c[i-2]<c[i-3]){
      mydata[i,"flow"] = c[i-2]
    }else{
      mydata[i,"flow"] = mydata[i-1,"flow"]
    }
    if(c[i]<c[i-1] && c[i-1]<c[i-2] && c[i-2]>c[i-3]){
      mydata[i,"fhigh"] = c[i-2]
    }else{
      mydata[i,"fhigh"] = mydata[i-1,"fhigh"]
    }
  }
  #mydata$fhigh[which(mydata$fhigh==0)] = NA
  #mydata$flow[which(mydata$flow==0)] = NA
  #mydata = na.omit(mydata)
  #print(mydata)
  return(mydata)
}
myHL = get_HReverse(myStock$Time,myStock$Open,myStock$High,myStock$Low,myStock$Close)
#print(typeof(myHL$date))
TA_fhigh = xts(myHL[,"fhigh"], order.by=as.POSIXct(myHL$date))
TA_flow = xts(myHL[,"flow"], order.by=as.POSIXct(myHL$date))

Stock$fhigh = TA_fhigh
addTA(TA_fhigh,on=1,col="green")
addTA(TA_flow,on=1,col="red")
zoomChart("2007-01-05::2007-06-30")



