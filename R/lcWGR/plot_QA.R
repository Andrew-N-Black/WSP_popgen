#Run as Rscript to plot:
# 1) Global coverage for all samples
# 2) Individual coverage, factored by population
# 3) Phred score distribution

#Edit Global file by transposing and adding 1:501 row.names
setWD("/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out") 
x<-read.table("wsp_global")
library("ggplot2")
ggplot(data=x,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth")+ylab("Sites")
ggsave("All_depth.svg")
quit()


#Edit by pasting sample names in col.1 and population origin in col.2.
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
ggsave("Fig_S3.svg")

#Phred score distribution
phred<-read.table("ALL.qa.gs")
ggplot(phred, aes(x=qscore,y=counts)) + geom_bar(stat="identity")+theme_classic()+ scale_x_discrete(name ="Phred score",limits=c(13:37))+ylab("Number of bases") + geom_vline(xintercept = 30,linetype="dashed")
ggsave("Fig_S4.svg")
