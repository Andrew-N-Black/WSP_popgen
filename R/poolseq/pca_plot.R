
library(ggplot)
#Read in metadata
popmap <- read.delim("~/popmap", header=FALSE)

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

#Pool-seq pca 
library(data.table)
infile<-fread(file="~/analysis/pupfish.fz", showProgress=FALSE, header=FALSE)
colnames(infile) <- c("Chr","Pos","Ref","Alt", "SC","LR","MS")
X<-infile[,c(5:7)]
pca1<-prcomp(na.omit(X),scale. = TRUE)
#Calculate variance explained
pca.eig= pca1$sdev^2
ax1 <-round((pca.eig[1] / sum(pca.eig)*100), digits=1)
ax2 <-round((pca.eig[2] / sum(pca.eig)*100), digits=1)
ax1 <- paste ("PC1 ","(", ax1,"%",")", sep= "")
ax2 <- paste ("PC2 ","(", ax2,"%",")", sep= "")

plotting = as.data.frame(pca1$rotation[,1:3])
ESU<-c("ESU-1","ESU-1,"ESU-2")
pop<-c("SC","LR","MS")
ggplot(plotting, aes(x=PC1,y=PC2,color=ESU, shape=as.factor(pop)))+geom_point(size=5)+scale_shape_manual(title,values=c(20,18,4))+ scale_color_manual(name="", values =c("ESU-1"="darkgrey","ESU-2"="black"))+theme(legend.position = "none",panel.grid = element_blank())+theme_classic()+xlab(ax1) +ylab(ax2)+ylim(c(0,1))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+ggtitle("Pool-seq")+ggtitle("A")

ggsave("Fig_1A.svg")

