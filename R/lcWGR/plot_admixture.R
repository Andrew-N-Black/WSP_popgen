#Plot Q matrx (Figure 2)
library(pophelper)
setwd("~/Files")
k2<-readQ("FINAL_K2.qopt")
k3<-readQ("FINAL_K3.qopt")

plotQ(qlist=k2,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("black","darkgrey"))
ggsave("Fig_2A.svg")

plotQ(qlist=k3,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("slateblue","black","darkgrey"))
ggsave("Fig_2B.svg")

#Done
