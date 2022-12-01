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
            sample population   ESU
1 MS-5310_filt.bam         MS ESU-2
2 MS-5311_filt.bam         MS ESU-2
3 MS-5312_filt.bam         MS ESU-2
4 MS-5313_filt.bam         MS ESU-2
5 MS-5315_filt.bam         MS ESU-2
6 MS-5319_filt.bam         MS ESU-2

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

ggplot(data=PC1_3, aes(y=V2, x=V1, shape=as.factor(popmap$population),color=as.factor(popmap$ESU)))+geom_point(size=5)+ theme_classic() + xlab("PC1 (43.6%)") +ylab("PC2 (3.1%)")+scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="blue"))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual("",values=c(20,18,4))
ggsave("Fig_1B.svg")

#DONE


