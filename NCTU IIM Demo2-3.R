#Read 

setwd(file.choose())
library(readr)
files <- list.files(pattern = ".rpt")
all = list()
for (filename in files){
  print(filename)
  DailyData <- read_csv(filename, col_names = FALSE, skip = 1)
  all<-rbind(all, DailyData) 
}

