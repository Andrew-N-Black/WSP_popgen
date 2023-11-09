#Plot Q matrx (Figure 2)
#R version 4.2.0
#pophelper v.2.3.1
library(pophelper)
#load in file listing attribute data
labels <- read_excel("labels.xlsx")
#Extract relevant columns
both <- as.data.frame(labels[,c(3,2)])

#plot K2
k2<-readQ("K2.Q")
plotQ(qlist=k2,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("blue","black"))

#plot K3
k3<-readQ("K3.Q")
plotQ(qlist=k3,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("blue","black","goldenrod"))


#Done
