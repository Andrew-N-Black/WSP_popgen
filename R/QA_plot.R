#Run as Rscript to plot:
# 1) Global coverage for all samples
# 2) Global coverage by population
# 3) Individual coverage, factored by population

setWD("/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out") 
x<-read.table("wsp_global")
library("ggplot2")
ggplot(data=x,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth")+ylab("Sites")
ggsave("All_depth.svg")
quit()


#Transpose and add row numbers, corresponding to cov, then plot in R
cat MS.qa.depthGlobal | tr "\t" "\n" | awk '{print $0,NR}' | head -n 501 > MS_global
z<-read.table("LR_global")
ggplot(data=z,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth MS")+ylab("Sites")
ggsave("MS_depth.svg")



y<-read.table("LR_global")
ggplot(data=y,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth LR")+ylab("Sites")
ggsave("LR_depth.svg")


zz<-read.table("LR_global")
ggplot(data=y,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth SC")+ylab("Sites")
ggsave("SC_depth.svg")



a<-read.table("conSamp")
a_sub<-a[1:22]
colnames(a_sub)<-c("Sample","Population","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20")
library(reshape2)

library(plyr)
neworder<-c("MS","SC","LR")

b <- melt(a_sub, id.vars=c("Sample","Population"))
neworder<-c("MS","SC","LR")
b2<-arrange(transform(b,Population=factor(Population,levels=neworder)),Population)
ggplot(b2, aes(x=variable,y=value,fill=as.factor(Population))) + geom_bar(stat="identity")+theme_classic()+facet_wrap(~Population,ncol=1)+scale_fill_manual( values =c("SC"="black","LR"="black","MS"="darkgrey"))+ theme(legend.position="none")+xlab("Coverage Level")+ylab("Number of Nucleotides")ggsave("Population_depth.svg")

