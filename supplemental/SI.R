#Run as Rscript to plot:
# 1) Global coverage for all samples
# 2) Individual coverage, factored by population
# 3) Phred score distribution
# 4) Intergenic / exonic admixture and PCAs

library(ggplot2)
library(reshape2)
library(plyr)
library(data.table)

#Set working directory folder containing all files:
setwd("~/files/)

#Global Depth, all samples together (Fig_S1)
#Edit Global file by transposing and adding 1:501 row.names
x<-read.table("ALL_global")
ggplot(data=x,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth")+ylab("Sites")
ggsave("S1.svg")


#Sample Depth, population origin factor (Fig_S2)
#Edit by pasting sample names in col.1 and population origin in col.2.
a<-read.table("ALL_sample")
a_sub<-a[1:22]
colnames(a_sub)<-c("Sample","Population","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20")
neworder<-c("MS","SC","LR")
b <- melt(a_sub, id.vars=c("Sample","Population"))
neworder<-c("MS","SC","LR")
b2<-arrange(transform(b,Population=factor(Population,levels=neworder)),Population)
ggplot(b2, aes(x=variable,y=value,fill=as.factor(Population))) + geom_bar(stat="identity")+theme_classic()+facet_wrap(~Population,ncol=1)+scale_fill_manual( values =c("SC"="black","LR"="black","MS"="darkgrey"))+ theme(legend.position="none")+xlab("Coverage Level")+ylab("Number of Nucleotides")
ggsave("Fig_S2.svg")


#Phred score distribution (Fig_S3)
phred<-read.table("ALL.qa.gs")
ggplot(phred, aes(x=qscore,y=counts)) + geom_bar(stat="identity")+theme_classic()+ scale_x_discrete(name ="Phred score",limits=c(13:37))+ylab("Number of bases") + geom_vline(xintercept = 30,linetype="dashed")
ggsave("Fig_S3.svg")

#Intergenic / exonic admixture and PCAs. Six panel plot (Fig_S4)
#Read in Q table for K2 and K3, based upon intergenic sites only:
k2<-readQ("INTER_K2.qopt")
k3<-readQ("INTER_K3.qopt")
#Combine the two Q tables
all_K<-joinQ(k2,k3)
#Plot
plotQ(qlist=all_K,imgoutput = "join",returnplot=T,exportplot=F,basesize=11,showindlab=T, clustercol=c("black","grey","slateblue"))
#Save
ggsave("Fig_S4a.svg")   

#Read in Q table for K2 and K3, based upon exonic sites only:
k2<-readQ("EXON_K2.qopt")
k3<-readQ("EXON_K3.qopt")
#Combine the two Q tables
all_K<-joinQ(k2,k3)
#Plot
plotQ(qlist=all_K,imgoutput = "join",returnplot=T,exportplot=F,basesize=11,showindlab=T, clustercol=c("black","grey","slateblue"))
#Save
ggsave("Fig_S4b.svg")  

#Pool-seq PCA-Exon sites only
infile<-fread(file="exon.fz", showProgress=FALSE, header=TRUE)
infile$Chr=NULL
infile$Pos=NULL
infile$Ref=NULL
infile$A1=NULL
colnames(infile) <- c("SC","LR","MS")
plotting<-na.omit(infile)
pca1<-prcomp(infile,scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")
pop<-c("SC","LR","MS")
esu<-c("ESU-2","ESU-2","ESU-1")
plotting<-as.data.frame(pca1$rotation)
ggplot(plotting, aes(x=PC1,y=PC2,color=esu, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(values=c("black", "darkgrey", "black"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ylim(c(0,1))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")
#Save
ggsave("Fig_S4c.svg")  


#Pool-seq PCA-Intergenic sites only
infile<-fread(file="inter.fz", showProgress=FALSE, header=TRUE)
infile$Chr=NULL
infile$Pos=NULL
infile$Ref=NULL
infile$A1=NULL
colnames(infile) <- c("SC","LR","MS")
plotting<-na.omit(infile)
pca1<-prcomp(infile,scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")
pop<-c("SC","LR","MS")
esu<-c("ESU-2","ESU-2","ESU-1")
plotting<-as.data.frame(pca1$rotation)
ggplot(plotting, aes(x=PC1,y=PC2,color=esu, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(values=c("black", "darkgrey", "black"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ylim(c(0,1))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")
#Save
ggsave("Fig_S4d.svg") 

#lcWGR PCA of Exon sites only
cov<-as.matrix(read.table("EXON.cov"))
popmap <- read.delim("~/popmap", header=FALSE)
x<-eigen(cov)
x$values/sum(x$values)
PC1_3<-as.data.frame(x$vectors[,1:3])
title<-"Population"
ggplot(data=PC1_3, aes(y=V2, x=V1, shape=as.factor(popmap$V2),color=as.factor(popmap$V3)))+ geom_point(size=5)+ theme_classic() + xlab("PC1 (38.6%)") +ylab("PC2 (3.2%)")+scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="darkgrey"))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual(title,values=c(20,18,4))
ggsave("Fig_S4e.svg") 

#lcWGR PCA of Intergenic sites only
cov<-as.matrix(read.table("EXON.cov"))
popmap <- read.delim("~/popmap", header=FALSE)
x<-eigen(cov)
x$values/sum(x$values)
PC1_3<-as.data.frame(x$vectors[,1:3])
title<-"Population"
ggplot(data=PC1_3, aes(y=V2, x=V1, shape=as.factor(popmap$V2),color=as.factor(popmap$V3)))+ geom_point(size=5)+ theme_classic() + xlab("PC1 (38.6%)") +ylab("PC2 (3.2%)")+scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="darkgrey"))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual(title,values=c(20,18,4))
ggsave("Fig_S4f.svg") 
