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
sam_sub<-a[1:22]
library(reshape2)
b <- melt(sam_sub, id.vars=c("V1","V2"))
ggplot(b, aes(x=variable,y=value,fill=as.factor(V2))) + geom_bar(stat="identity")+theme_classic()+facet_wrap(~V2,ncol=1)+scale_fill_manual(name="Population", values =c("SC"> slateblue","LR"="black","MS"="green"))


