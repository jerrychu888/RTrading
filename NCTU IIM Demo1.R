#NCTU IIM Demo1
#Jerry Chu 20170219

install.packages("quantmod")
library(quantmod)

TW50symbols= c("2330.tw","2317.tw","2412.tw")
getSymbols(TW50symbols)
getSymbols(TW50symbols,from='2016-01-01',to='2017-02-20')
Stock = get("2330.TW")
View(Stock)
colnames(Stock) = c("Open","High","Low","Close","Volume","Adj")
Stock$Volume[which(Stock$Volume==0)] = NA
Stock = na.omit(Stock)
STK=as.matrix(to.daily(Stock))
colnames(STK) = c("Open","High","Low","Close","Volume")

chartSeries(STK,theme = "white")
zoomChart("2016-12::2017-02")
STK_SMA = SMA(STK[,4],n = 5)
STK = cbind(STK,STK_SMA)
addTA(STK_SMA, on=1, col="blue", legend=NULL, lwd=3)
#dropTA(STK_SMA)

profit=setNames(numeric(length(rownames(STK))), rownames(STK))	## profit vector

for (m in rownames(STK)) {
  profit[m]=STK[m,4]-STK[m,1] #Buy when day open , sell when day close
}


plot(cumsum(profit),type="l",col="red",lwd=2)
abline(h=0,col="green")

#STK_weekly=as.matrix(to.weekly(STK))
profit=setNames(numeric(length(rownames(STK))), rownames(STK))	## profit vector
position = 0 
lastMA = STK[5,6]
lastClose = STK[5,4]
for (m in rownames(STK)[-seq(1,5)]) {
  if (position ==0 && lastClose>lastMA) {
      entryPrice = STK[m,1]
      position = 1
  }
  if (position == 1 && lastClose<lastMA) {
      profit[m] = STK[m,1] - entryPrice
      position = 0
  }
  lastMA = STK[m,6]
  lastClose = STK[m,4]
}
