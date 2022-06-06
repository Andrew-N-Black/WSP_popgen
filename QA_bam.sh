#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 25
#SBATCH -t 8-00:00:00
#SBATCH --job-name=angsd_QA
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=20GB


module load biocontainers
module load pcangsd/1.10
module load angsd/0.935

REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa

#####Dump output files for All samples####
angsd -P 25 -b ALL_bamlist -ref $REF -out ../angsd_out/ALL.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1
 
#Transpose and add row numbers, corresponding to cov, then plot in R
cat ALL.qa.depthGlobal | tr "\t" "\n" | awk '{print $0,NR}' | head -n 501 > wsp_global
x<-read.table("wsp_global")
library("ggplot2")
ggplot(data=x,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth")+ylab("Sites")
ggsave("All_depth.svg")

####Dump output files ONLY for Lost River samples#####
angsd -P 25 -b LR_bamlist.txt -ref $REF -out ../angsd_out/LR.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1

#Transpose and add row numbers, corresponding to cov, then plot in R
cat LR.qa.depthGlobal | tr "\t" "\n" | awk '{print $0,NR}' | head -n 501 > LR_global
y<-read.table("LR_global")
ggplot(data=y,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth LR")+ylab("Sites")
ggsave("LR_depth.svg")

###Dump output files ONLY for Malpais Spring samples####
angsd -P 25 -b MS_bamlist.txt -ref $REF -out ../angsd_out/MS.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1
        
#Transpose and add row numbers, corresponding to cov, then plot in R
cat MS.qa.depthGlobal | tr "\t" "\n" | awk '{print $0,NR}' | head -n 501 > MS_global
z<-read.table("LR_global")
ggplot(data=z,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth MS")+ylab("Sites")
ggsave("MS_depth.svg")

#Dump output files ONLY for Salt Creek samples
angsd -P 25 -b SC_bamlist.txt -ref $REF -out ../angsd_out/SC.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1

#Transpose and add row numbers, corresponding to cov, then plot in R
cat SC.qa.depthGlobal | tr "\t" "\n" | awk '{print $0,NR}' | head -n 501 > SC_global
zz<-read.table("LR_global")
ggplot(data=y,aes(x=V1,y=V2))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth SC")+ylab("Sites")
ggsave("SC_depth.svg")


#Depth by Individual / population:
ls ../cleaned/*1.fq.gz | cut -c 12-18 > samp.names
ls ../cleaned/*1.fq.gz | cut -c 12-13 > pop.names
paste samp.names pop.names ALL.qa.depthSample | sed 's/\t/ /g' > conSamp

a<-read.table("conSamp")
sam_sub<-a[1:22]
library(reshape2)
b <- melt(sam_sub, id.vars=c("V1","V2"))
ggplot(b, aes(x=variable,y=value,fill=as.factor(V2))) + geom_bar(stat="identity")+theme_classic()+facet_wrap(~V2,ncol=1)+scale_fill_manual(name="Population", values =c("SC"> slateblue","LR"="black","MS"="green"))


