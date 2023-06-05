#Plot Q matrx (Figure 2)
#R version 4.2.0
#pophelper v.2.3.1
library(pophelper)
setwd("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/WS_Pupfish/PopulationGenomics/Manuscript/Figures/Files/")

#load in file listing attribute data
labels <- read_excel("labels.xlsx")
#Extract relevant columns
both <- as.data.frame(labels[,c(3,2)])

#plot K2
plotQ(qlist=k2,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("black","darkgrey"))

#plot K3
plotQ(qlist=k3,returnplot=T,exportplot=F,basesize=11,showindlab=F, clustercol=c("slateblue","black","darkgrey"))


#Done
