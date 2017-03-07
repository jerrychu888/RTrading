#install.packages("quantmod")
library("quantmod")
getSymbols(c("2330.tw","2317.tw"))
STK1 = get("2330.TW")          
STK2 = get("2317.TW")         
mylayout = layout(matrix(1:8, nrow=4)) 
chartSeries(STK1,subset="last 9 months",theme = "white",order=1,layout=mylayout)
chartSeries(STK2,subset="last 9 months",theme = "white",order=1,layout=mylayout)


layout(matrix(c(1,1,2,2),nrow=2,ncol=2, byrow=TRUE))
#matrix
"
figure1 | figure1
figure2 | figure2
"
#another way is 
layout(matrix(c(1,2),byrow=TRUE))
chartSeries(STK1,TA=NULL,layout = NULL) #TA is vol chart , vol is also a chart
chartSeries(STK2,TA=NULL,layout = NULL) #TA is vol chart , vol is also a chart



layout(matrix(c(1,2,3,4),nrow=2,ncol=2, byrow=FALSE))
#matrix
"
figure1 | figure3
figure2 | figure4
"
chartSeries(STK1,layout = NULL)
chartSeries(STK2,layout = NULL)