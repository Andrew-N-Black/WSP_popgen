
library(pophelper)
setwd("~/comp/K2")
list.files(path="~/comp/K2")
sfiles<-list.files(path="~/comp/K2")
clumppExport(readQ(sfiles),exportpath=getwd())
pup_k2<-readQ("~/comp/K2/pop_K2-combined.txt")

setwd("~/comp/K3")
list.files(path="~/comp/K3")
sfiles<-list.files(path="~/comp/K3")
clumppExport(readQ(sfiles),exportpath=getwd())
pup_k3<-readQ("~/comp/K3/pop_K3-combined.txt")



#for file in *.qopt; do mv "$file" "${file%.qopt}_r18.qopt"; done
#mv r[0-9]/*qopt ../comp
#mv r1[0-9]/*qopt ../comp


setwd("~/comp/K4")
list.files(path="~/comp/K4")
sfiles<-list.files(path="~/comp/K4")
clumppExport(readQ(sfiles),exportpath=getwd())
pup_k4<-readQ("~/comp/K4/pop_K4-combined.txt")

setwd("~/comp/K5")
list.files(path="~/comp/K5")
sfiles<-list.files(path="~/comp/K5")
clumppExport(readQ(sfiles),exportpath=getwd())
pup_k5<-readQ("~/comp/K5/pop_K5-combined.txt")


#upload to cluster and run
CLUMPP

k2<-readQ("~/comp/pop_K2/pop_K2-combined-merged.txt")
k3<-readQ("~/comp/K3/pop_K3/pop_K3/pop_K3-combined-merged.txt")
k4<-readQ("~/comp/pop_K4/pop_K4-combined-merged.txt")
k5<-readQ("~/comp/pop_K5/pop_K5-combined-merged.txt")

#Merge together
all_K<-joinQ(k2,k3,k4,k5)

#Add sample names
if(length(unique(sapply(all_K,nrow)))==1) all_K <- lapply(all_K,"rownames<-",ind$...1)

#Confirm
lapply(all_K, rownames)[1:4]

#plot
plotQ(qlist=all_K,imgoutput = "join",returnplot=T,exportplot=F,basesize=11,
      showindlab=T, clustercol=c("black","green","slateblue","grey","orange"))

