#NCTU IIM-Demo 2-4
#Opening Type demofile1_read 5 min data

TX_5 = read.table(file='TXF1_2016.txt',header = TRUE, sep=',')
head(TX_5)
library("xts")
timeCharVector = paste(TX_5$Date,TX_5$Time)
timeVector = strptime(timeCharVector,"%Y/%m/%d %H:%M:%S",tz = Sys.timezone() ) #%y for 2 digits of year %Y for 4 digits of year!!!

xts_TX5 = xts(TX_5[,c(3:7)],as.POSIXct(timeVector))
head(xts_TX5)
xts_TX_5min = to.period(xts_TX5,"minutes",5)
View(xts_TX_5min)

####time period wrong up side###

#TX_5 = read.table(file='TXF1_2011.txt',header = TRUE, sep=',')
#timeCharVector = paste(TX_5$Date,TX_5$Time)
timeVector = strptime(timeCharVector,"%Y/%m/%d %H:%M:%S",tz = Sys.timezone() ) #%y for 2 digits of year %Y for 4 digits of year!!!
head(timeVector)
typeof(timeVector)

#two way
#1
timeVector = as.POSIXct(timeVector) #POSIXct # continous time #1970-1-1 #pasted second
head(timeVector)
typeof(timeVector)
timeVector = timeVector-60
head(timeVector)
TX_5 = cbind(TX_5,timeVector)
TX_5 = TX_5[,c(-1,-2)]
xts_TX5 = xts(TX_5[,c(1:5)],as.POSIXct(timeVector))
head(xts_TX5)
xts_TX_5min = to.period(xts_TX5,'minutes',5)
head(xts_TX_5min)
xts_TX_5min = xts_TX_5min+60 # wrong  add to internal data not index
head(xts_TX_5min)
xts_TX_5min = xts_TX_5min-60
head(xts_TX_5min)
index(xts_TX_5min)
index(xts_TX_5min) = index(xts_TX_5min) + 60    # adds a minute
head(xts_TX_5min)


#POSIXlt # legible time
timeVector = strptime(timeCharVector,"%Y/%m/%d %H:%M:%S",tz = Sys.timezone() ) #%y for 2 digits of year %Y for 4 digits of year!!!
timeVector = as.POSIXlt(timeVector) #POSIXlt # legible time
head(timeVector)
typeof(timeVector)
unclass(timeVector)
unclass(as.POSIXlt(Sys.time(), Sys.timezone()))
timeVector$min
timeVector$min = timeVector$min-1
head(timeVector)
colnames(timeVector)


"val = read.table('5minValidate.csv',header=TRUE,sep=',')
val = val[-1,]"
#val = list(100)
head(xts_TX_5min)
xts_TX_5min["2016-01-04 13:45:00"]
xts_TX_1day = to.period(xts_TX_5min,'days',1)
head(xts_TX_1day)
days = format(index(xts_TX_1day),"%Y-%m-%d")
yesClose = double()
t850 = double()
t855 = double()
t900 = double()
Daytype = character()
ChangePercentage = double()
yesClose = double()
for(dayCount in 1:length(days)){
  print(paste(days[dayCount], "08:50:00"))
  t850[dayCount] = xts_TX_5min[paste(days[dayCount], "08:50:00"),4]
  t855[dayCount] = xts_TX_5min[paste(days[dayCount], "08:55:00"),4]
  t900[dayCount] = xts_TX_5min[paste(days[dayCount], "09:00:00"),4]
  Daytype[dayCount] = ""
  yesClose[dayCount+1] = xts_TX_5min[paste(days[dayCount], "13:30:00"),4]
  ChangePercentage[dayCount] = (xts_TX_5min[paste(days[dayCount], "13:30:00"),4]-xts_TX_5min[paste(days[dayCount], "09:05:00"),1])/xts_TX_5min[paste(days[dayCount], "09:05:00"),1]
}
yesClose =yesClose[-length(yesClose)]


Val =list(days,yesClose,t850,t855,t900,Daytype,ChangePercentage)
