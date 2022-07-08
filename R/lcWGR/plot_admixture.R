
library(pophelper)

k2<-readQ("~/ADX/FINAL_K2.qopt")
k3<-readQ("~/ADX/FINAL_K3.qopt")

plotQ(qlist=k2,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("black","darkgrey"))
ggsave("k2.svg")

plotQ(qlist=k3,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("slateblue","black","darkgrey"))
ggsave("k3.svg")
