#Plot individual PCA from lcWGR data
#R version 4.2.0
#ggplot2 version 3.3.6


library(ggplot)
#Read in metadata
setwd("~/Files")
popmap <- read.delim("popmap", header=FALSE)

#Add col names
names(popmap)<-c("sample","population","ESU")
head(popmap)
#            sample population   ESU
#1 LR-5017_filt.bam         LR ESU-1
#2 LR-5018_filt.bam         LR ESU-1
#3 LR-5019_filt.bam         LR ESU-1
#4 LR-5020_filt.bam         LR ESU-1
#5 LR-5021_filt.bam         LR ESU-1
#6 LR-5146_filt.bam         LR ESU-1

#Low Coverage Whole Genome Resequencing pca 

#Read in covariation matrix and metadata
cov<-as.matrix(read.table("FINAL.cov"))

#Extract eigenvalues
axes<-eigen(cov)
#print out eigenvalues for PCA axes
axes$values/sum(axes$values)*100
#[1] 43.6212647  3.1988981

#Save as dataframe and plot
PC1_3<-as.data.frame(axes$vectors[,1:3])
title<-"Population"

ggplot(data=PC1_3, aes(y=V2, x=V1, shape=as.factor(popmap$population),color=as.factor(popmap$ESU)))+geom_point(size=5)+ theme_classic() + xlab("PC1 (41.5%)") +ylab("PC2 (3.3%)")+scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="darkgrey"))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual(title,values=c(20,18,4))
ggsave("Fig_1B.svg")

#DONE


