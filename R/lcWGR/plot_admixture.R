#Plot Q matrx (Figure 2)
#R version 4.2.0
#pophelper v.2.3.1
library(pophelper)
setwd("~/Files")

labels <- read_excel("labels.xlsx")
both <- as.data.frame(labels[,c(3,2)])

plotQ(slist[1:3],returnplot=T,exportplot=T,imgoutput = "join",clustercol=c("black","blue","darkgoldenrod","darkmagenta"),grplab=both,ordergrp=T,showlegend=F,height=1.6,indlabsize=1.2,indlabheight=0.08,indlabspacer=1,barbordercolour="white",divsize = 0.3,grplabsize=1.5,barbordersize=0.1,linesize=0.4,showsp = F,splabsize = 0,outputfilename="plotq",imgtype="png",exportpath=getwd(),splab = c("K=2","K=3","K=4"),divcol = "black",splabcol="black",grplabheight=1)


plotQ(qlist=k2,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("black","darkgrey"))
ggsave("Fig_2.svg")

plotQ(qlist=k3,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("slateblue","black","darkgrey"))
ggsave("Fig_2B.svg")

#Done
