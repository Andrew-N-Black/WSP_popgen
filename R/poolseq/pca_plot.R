#Plot pool-seq PCA
#R version 4.2.0
#ggplot2 version 3.3.6 

library(ggplot2)
library(data.table)
infile<-fread(file="~/analysis/pupfish.fz", showProgress=FALSE, header=TRUE)
X<-infile[,c(5:7)]
colnames(X) <- c("SC","LR","MS")
pca1<-prcomp(na.omit(X),scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")

plotting = as.data.frame(pca1$rotation[,1:3])
ESU<-c("ESU-1","ESU-1","ESU-2")
pop<-c("SC","LR","MS")
gplot(plotting, aes(x=PC1,y=PC2,color=ESU, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="blue"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ylim(c(0,1))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+ggtitle("Pool-seq")+ggtitle("A")

ggsave("Fig_1A.svg")
#DONE

#Genic regions only
library(ggplot2)
library(data.table)
infile<-fread(file="~/genes.fz", showProgress=FALSE, header=TRUE)
X<-infile[,c(5:7)]
colnames(X) <- c("SC","LR","MS")
pca1<-prcomp(na.omit(X),scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")

plotting = as.data.frame(pca1$rotation[,1:3])
ESU<-c("ESU-1","ESU-1","ESU-2")
pop<-c("SC","LR","MS")
ggplot(plotting, aes(x=PC1,y=PC2,color=ESU, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(name="", values =c("ESU-1"="blue","ESU-2"="black"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ggtitle("Genic")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")
ggsave("~/Fig_gene_pool.svg")

#Non-genic regions
library(ggplot2)
library(data.table)
infile<-fread(file="~/inter.fz", showProgress=FALSE, header=TRUE)
X<-infile[,c(5:7)]
colnames(X) <- c("SC","LR","MS")
pca1<-prcomp(na.omit(X),scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")

plotting = as.data.frame(pca1$rotation[,1:3])
ESU<-c("ESU-1","ESU-1","ESU-2")
pop<-c("SC","LR","MS")
ggplot(plotting, aes(x=PC1,y=PC2,color=ESU, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(name="", values =c("ESU-1"="blue","ESU-2"="black"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ggtitle("Genic")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")
ggsave("~/Fig_non-gene_pool.svg")


ggsave("Fig_non-genic_pool.svg")


