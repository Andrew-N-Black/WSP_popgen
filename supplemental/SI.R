#Run as Rscript to plot:
# 1) Global coverage for all samples
# 2) Individual coverage, factored by population
# 3) Phred score distribution
# 4) Intergenic / genic admixture PCAs

library(ggplot2)
library(reshape2)
library(plyr)
library(data.table)

#Set working directory folder containing all files:
setwd("Files/")



#Global Depth, all samples together (Fig_S1)
#Edit Global file by transposing and adding 1:501 row.names
x<-read.table("ALL_global")
ggplot(data=x,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth")+ylab("Sites")
ggsave("Fig_S1.svg")


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

#Genetic load plot (Fig_S4)
#See R/load.R

#Non-genic / genic PCA. Six panel plot (Fig_S5)

#Pool-seq PCA-genic sites only
infile<-fread(file="genic.fz", showProgress=FALSE, header=TRUE)
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



#Pool-seq PCA-non-genic sites only
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


#lcWGR PCA of genic sites only
cov<-as.matrix(read.table("genic.cov"))
popmap <- read.delim("~/popmap", header=FALSE)
x<-eigen(cov)
x$values/sum(x$values)
PC1_3<-as.data.frame(x$vectors[,1:3])
title<-"Population"
ggplot(data=PC1_3, aes(y=V2, x=V1, shape=as.factor(popmap$V2),color=as.factor(popmap$V3)))+ geom_point(size=5)+ theme_classic() + xlab("PC1 (40.9%)") +ylab("PC2 (3.3%)")+scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="darkgrey"))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual(title,values=c(20,18,4))


#lcWGR PCA of Intergenic sites only
cov<-as.matrix(read.table("inter.cov"))
popmap <- read.delim("~/popmap", header=FALSE)
x<-eigen(cov)
x$values/sum(x$values)
PC1_3<-as.data.frame(x$vectors[,1:3])
title<-"Population"
ggplot(data=PC1_3, aes(y=V2, x=V1, shape=as.factor(popmap$V2),color=as.factor(popmap$V3)))+ geom_point(size=5)+ theme_classic() + xlab("PC1 (40.2%)") +ylab("PC2 (3.2%)")+scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="darkgrey"))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual(title,values=c(20,18,4))
 
#ML tree of 11 Cyprinodon species (Fig_S6)
#See /analysis/lcWGR/mtDNA_workflow.R


#Sites only within pgd, using Pool-seq data (Fig_S7)
pop<-c("SC","LR","MS")
ESU<-c("ESU-1","ESU-1","ESU-2")
cov<-as.matrix(read.table("PGD_pool.cov",header = F))
axes<-eigen(cov)
PC1_3<-as.data.frame(axes$vectors[,1:3])
axes$values/sum(axes$values)*100
#[1] 55.9178253 43.5840862  0.4980885
ggplot(PC1_3, aes(x=V1,y=V2,color=ESU, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(values=c("black", "blue", "black"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab("PC1 (55.9%)") +ylab("PC2 (43.5%)")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+ggtitle("A")

#Sites only within pgd , using lcWGR data
cov<-as.matrix(read.table("PGD.cov"))
axes<-eigen(cov)
PC1_3<-as.data.frame(axes$vectors[,1:3])

axes$values/sum(axes$values)*100
#[1] 5.137600e+01 2.889389e+01 7.748587e+00 3.944816e+00 3.687274e+00
ggplot(data=PC1_3, aes(y=V2, x=V1, shape=as.factor(labels$Population),color=as.factor(labels$ESU)))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual("",values=c(20,18,4))+geom_point(size=5)+ theme_classic() + xlab("PC1 (51.4%)") +ylab("PC2 (28.9%)")+scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="blue"))

# (Fig_S8-S9) Add Erangi's new figures
