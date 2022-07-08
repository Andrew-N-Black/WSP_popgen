qqchi<-function(x,...){
lambda<-round(median(x)/qchisq(0.5,1),2)
  qqplot(qchisq((1:length(x)-0.5)/(length(x)),1),x,ylab="Observed",xlab="Expected",...);abline(0,1,col=2,lwd=2)
legend("topleft",paste("lambda=",lambda))
}

library(RcppCNPy)
s<-npyLoad("EXON.selection.npy")
qqchi(s)
pval<-1-pchisq(s,1)

# awk '{print $1}' EXON.beagle  | tail -n +2 | sed 's/NW_/NW./g' |sed 's/_/\t/g' |sed 's/NW./NW_/g' > EXON.sites
p<-read.table("EXON.sites",colC=c("factor","integer"),sep="\t")
names(p)<-c("chr","pos")
 p$pos[which.max(s)]
[1] 447209

exon_df<-cbind(p,s,pval)
plot(-log10(pval),col=p$chr,xlab="Chromosomes",main="Manhattan plot")
exons<--log10(exon_df$pval)
library(qvalue)
qval <- qvalue(exon_df$pval)$qvalues
EXON_DF<-cbind(exon_df,qval)

qplot(-log10(exon_df$pval), geom="density",main = "Exon selection",xlab = "-log10(p-value)",fill=I("grey"),col=I("black"))+theme_bw()+geom_vline(xintercept =1.30103,linetype="dashed")



#PCADAPT
library(pcadapt)
library(RcppCNPy)
library(bigutilsr)

s<-npyLoad("EXON.pcadapt.zscores.npy")

#	args[1]: zscores matrix
#	args[2]: prefix for output files
#

args = commandArgs(trailingOnly=TRUE)



zscores <- npyLoad(s)
K <- ncol(zscores)

# For one component only
if (K == 1) {
	d2 <- (zscores - median(zscores))^2
} else {
	d2 <- dist_ogk(zscores)
}

write.table(d2, file=paste0(pupfish, ".pcadapt.test.txt"), quote=F, row.names=F, col.names=F)
write.table(pchisq(d2, df=K, lower.tail=F), file=paste0(args[2], ".pcadapt.pval.txt"), quote=F, row.names=F, col.names=F)


