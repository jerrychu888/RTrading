#Read Single TX Tick file
#Jerry Chu 20170226

# use import tool
"
#Set Root Directory
setwd(file.choose())
library(readr)
Daily_2017_02_24 <- read_csv('Daily_2017_02_24.rpt', col_names = FALSE, skip = 1)
View(Daily_2017_02_24)
"

colnames(Daily_2017_02_24) = c("Date","Symbol","Delivery","Time","Price","Volume","","","")
typeof(Daily_2017_02_24)
Daily_2017_02_24 = Daily_2017_02_24[c(-7,-8,-9)] # Trim unused data
Row = which(Daily_2017_02_24$Symbol=="TX") # get TX Index
TXData = Daily_2017_02_24[Row,] #get TX Data
TXHotData = TXData[TXData$Delivery=="201703",]

timeCharVector = paste(TXHotData$Date,TXHotData$Time)
timeVector = strptime(timeCharVector,"%Y%m%d %H%M%S",tz = Sys.timezone() ) #%y for 2 digits of year %Y for 4 digits of year!!!
#timeseriesData <- xts(TXHotData[,c(5:6)], as.POSIXct(timeVector), Sys.timezone(), "%Y-%m-%d %H:%M:%S")
timeseriesData <- xts(TXHotData[,c(5:6)], as.POSIXct(timeVector))
TX_10second = to.period(timeseriesData,"seconds",10)
TX_1min = to.period(timeseriesData,"minutes",1)
TX_1min$Volume = TX_1min$Volume/2
colnames(TX_1min) = c("Open","High","Low","Close","Volume")


chartSeries(TX_1min,theme = "white",type="candle")
zoomChart("2017-02-24 13:00:59::")
addSMA(5)
addSMA(30)
zoomChart()
