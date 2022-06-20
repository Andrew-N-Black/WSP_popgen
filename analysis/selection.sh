 
 qqchi<-function(x,...){
+ lambda<-round(median(x)/qchisq(0.5,1),2)
+   qqplot(qchisq((1:length(x)-0.5)/(length(x)),1),x,ylab="Observed",xlab="Expected",...);abline(0,1,col=2,lwd=2)
+ legend("topleft",paste("lambda=",lambda))
+ }
 
s<-npyLoad("exons.selection.npy")
qqchi(s)
pval<-1-pchisq(s,1)

p<-read.table("exon.sites",colC=c("factor","integer"),sep="\t")
names(p)<-c("chr","pos")
 p$pos[which.max(s)]
[1] 245807

exon_df<-cbind(p,s,pval)
plot(-log10(pval),col=p$chr,xlab="Chromosomes",main="Manhattan plot")
exons<--log10(exon_dataframe$pval)
qplot(exons,
+       geom="histogram",
+       binwidth = 0.1,  
+       main = "Exon selection", 
+       xlab = "-log10(p-value)",  
+       fill=I("grey"), 
+       col=I("black"))+theme_bw()


