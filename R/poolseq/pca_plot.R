#Plot pool-seq PCA
#R version 4.2.0
#ggplot2 version 3.3.6 

library(ggplot2)
library(data.table)

infile<-fread(file="pupfish.fz", showProgress=FALSE, header=TRUE)
X<-infile[,c(5:7)]
colnames(X) <- c("SC","LR","MS")
pca1<-prcomp(na.omit(X),scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")

#format accordingly
plotting = as.data.frame(pca1$rotation[,1:3])
#Set factor order
ESU<-c("ESU-1","ESU-1","ESU-2")
pop<-c("SC","LR","MS")
#plot
gplot(plotting, aes(x=PC1,y=PC2,color=ESU, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="blue"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ylim(c(0,1))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+ggtitle("Pool-seq")+ggtitle("A")


#Genic regions only
library(ggplot2)
library(data.table)
infile<-fread(file="genes.fz", showProgress=FALSE, header=TRUE)
X<-infile[,c(5:7)]
colnames(X) <- c("SC","MS","LR")
pca1<-prcomp(na.omit(X),scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")

plotting = as.data.frame(pca1$rotation[,1:3])
ESU<-c("ESU-1","ESU-2","ESU-1")
pop<-c("SC","MS","LR")
ggplot(plotting, aes(x=PC1,y=PC2,color=ESU, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="blue"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ggtitle("Non-Genic")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")


#Non-genic regions
library(ggplot2)
library(data.table)
infile<-fread(file="inter.fz", showProgress=FALSE, header=TRUE)
X<-infile[,c(5:7)]
colnames(X) <- c("SC","MS","LR")
pca1<-prcomp(na.omit(X),scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")

plotting = as.data.frame(pca1$rotation[,1:3])
ESU<-c("ESU-1","ESU-2","ESU-1")
pop<-c("SC","MS","LR")
ggplot(plotting, aes(x=PC1,y=PC2,color=ESU, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="blue"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ggtitle("Non-Genic")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")



